<?php
namespace Admin\Controller;

use Think\Controller;

class ApplyIPSController extends BaseController
{
    private $mchID = '212352';

    private $account = '2123520021';

    private $key = 'nKUTRH9fAPdxkeXrQbpGpCmRphcy8gVvA35JgH7kgAQp1DMXPaYrv5nSwRrcS1KX1jXjAX3VUtrtsQSUu0lfXEXojM7GjWu2u6qlgMv3Gkl7yg5NjvQKg0B1uAXUkZky';

    private $gateway = 'https://settlement.ips.com.cn/stms/supplier/add_new.do';

    private $xiafaUrl = 'https://settlement.ips.com.cn/stms/order/add.do';

    public function index()
    {
        $applyIpsList = M('ApplyIps')->select();
        $this->assign('applyIpsList', $applyIpsList);
        $this->display();
    }

    public function show()
    {
        $this->display();
    }

    public function apply()
    {

        $id           = I('get.id');
        $applyIPSInfo = M('ApplyIps')->where(['id' => $id])->find();
        if (!$applyIPSInfo) {
            $this->ajaxReturn(['status' => 0, 'msg' => '无此信息！']);
        }

        $requestData = [
            'head' => [
                'version'      => 'v1.0.0',
                'platformCode' => $this->account,
                'reqIp'        => getIP(),
                'reqDate'      => date('Y-m-d H:i:s'),
                'signature'    => '1',
            ],
            'body' => [
                'batchNumber'     => $applyIPSInfo['batch_id'],
                'number'          => 1,
                'supplierDetails' => [
                    'supplierDetail' => [
                        'supplierCode'     => $applyIPSInfo['supplier_id'],
                        'organizationCode' => $applyIPSInfo['id_no'],
                        'supplierName'     => $applyIPSInfo['ips_name'],
                        'blendingParty'    => 1,
                        'accType'          => 1,
                        'accountIngcycle'  => 1,
                        'invoice'          => 0,
                        'presentMethod'    => '0',
                        'counterFee'       => '0.00',
                        // 'email'            => $applyIPSInfo['email'],
                        // 'loginPwd'         => $applyIPSInfo['login_pass'],
                        // 'businessPwd'      => $applyIPSInfo['pay_pass'],
                        // 'name'             => $applyIPSInfo['bank_fullname'],
                        // 'bankAccount'      => $applyIPSInfo['bank_account'],
                        // 'bankCode'         => $applyIPSInfo['bank_code'],
                        // 'branchName'       => $applyIPSInfo['bank_address'],
                        // 'reservedPhone'    => $applyIPSInfo['mobile'],
                    ],
                ],

            ],
        ];

        $signStr                          = $this->toIPSXml(['body' => $requestData['body']]) . $this->mchID . $this->key;
        $requestData['head']['signature'] = md5($signStr);

        $xml = '<ips>' . $this->toIPSXml($requestData) . '</ips>';

        $res = curlPost($this->gateway, ['supplierAddReq' => $xml]);
        $res = xmlToArray($res);
        if ($res['head']['rspCode'] == '00000000' && $res['body']['sucNumber']) {
            M('ApplyIps')->where(['id' => $id])->save(['status' => 2, 'update_at' => time()]);
            $this->ajaxReturn(['status' => 1, 'msg' => '供应商创建成功']);
        }

        $this->ajaxReturn(['status' => 0, 'msg' => $res['body']['supplierDetails']['supplierDetail']['msg']]);

    }

    public function xiafa()
    {
        $this->display();
    }

    public function xiafaapi()
    {
        $amount      = I('post.amount');
        $uid         = I('post.uid');
        $batchNumber = date('Ymd') . mt_rand(10, 99) . str_pad($uid, 4, 0, STR_PAD_LEFT);
        $orderid     = date('Ymd') . mt_rand(10000, 99999) . str_pad($uid, 4, 0, STR_PAD_LEFT);

        $applyIPSInfo = M('ApplyIps')->where(['user_id' => $uid])->find();
        if (!$applyIPSInfo) {
            $this->ajaxReturn(['status' => 0, 'msg' => '该用户未开户！']);
        }

        $xiafaID = M('ips_xiafa')->add([
            'batch_number' => $batchNumber,
            'orderid'      => $orderid,
            'user_id'      => $uid,
            'amount'       => $amount,
            'create_at'    => time(),
            'status'       => 0,
        ]);
        if (!$xiafaID) {
            $this->ajaxReturn(['status' => 0, 'msg' => '下发失败！']);
        }

        $requestData = [
            'head' => [
                'version'      => 'v1.0.0',
                'platformCode' => $this->mchID,
                'reqIp'        => getIP(),
                'reqDate'      => date('Y-m-d H:i:s'),
                'signature'    => '1',
            ],
            'body' => [
                'batchNumber'  => $batchNumber,
                'number'       => 1,
                'orderDetails' => [
                    'orderDetail' => [
                        'orderCode'        => $orderid,
                        'supplierCode'     => $applyIPSInfo['supplier_id'],
                        'supplierName'     => $applyIPSInfo['ips_name'],
                        'orderName'        => '在线支付',
                        'businessAmount'   => $amount,
                        'settlementAmount' => $amount,
                        'businessTime'     => date('Y-m-d H:i:s'),
                    ],
                ],

            ],
        ];
        $signStr                          = $this->toIPSXml(['body' => $requestData['body']]) . $this->mchID . $this->key;
        $requestData['head']['signature'] = md5($signStr);

        $xml = '<ips>' . $this->toIPSXml($requestData) . '</ips>';

        $res = curlPost($this->xiafaUrl, ['orderAddReq' => $xml]);

        $res = xmlToArray($res);
      
        if ($res['head']['rspCode'] == '00000000' && $res['body']['sucNumber']) {
            M('ips_xiafa')->where(['id' => $xiafaID])->save(['status' => 1]);
            $this->ajaxReturn(['status' => 1, 'msg' => '下发成功！']);
        }
        $this->ajaxReturn(['status' => 0, 'msg' => $res['body']['orderDetails']['orderDetail']['msg']]);

    }

    private function toIPSXml($data, $isTo = true)
    {

        $xmlStr = '';
        foreach ($data as $k => $v) {

            if ($isTo) {
                $xmlStr .= '<' . $k . '>';
            }

            foreach ($v as $k1 => $v1) {

                if ($k1 == 'supplierDetails' || $k1 == 'orderDetails') {
                    if ($k1 == 'supplierDetails') {
                        $xmlStr .= '<supplierDetails><supplierDetail>';
                        foreach ($v1['supplierDetail'] as $k2 => $v2) {
                            $xmlStr .= '<' . $k2 . '>' . $v2 . '</' . $k2 . '>';
                        }
                        $xmlStr .= '</supplierDetail></supplierDetails>';
                    } else {
                        $xmlStr .= '<orderDetails><orderDetail>';
                        foreach ($v1['orderDetail'] as $k2 => $v2) {
                            $xmlStr .= '<' . $k2 . '>' . $v2 . '</' . $k2 . '>';
                        }
                        $xmlStr .= '</orderDetail></orderDetails>';
                    }

                } else {
                    $xmlStr .= '<' . $k1 . '>' . $v1 . '</' . $k1 . '>';
                }
            }
            if ($isTo) {
                $xmlStr .= '</' . $k . '>';
            }

        }
        return $xmlStr;
    }
}
