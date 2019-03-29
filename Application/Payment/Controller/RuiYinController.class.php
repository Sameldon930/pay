<?php
namespace Payment\Controller;

class RuiYinController extends PaymentController
{
    //支付网关
    private $gateway = 'http://pay.dblhchina.com/api/createdforder';
    private $queryUrl = 'http://pay.dblhchina.com/api/querydforder';
    private $balanceUrl = 'http://pay.dblhchina.com/api/queryBalance';

    private $today = '';

    //放行的银行信息
    private $bankCode = [
        '中国农业银行'   => 'ABC',
        '北京农商银行'   => 'BJRC',
        '北京银行'     => 'BOB',
        '中国银行'     => 'BOC',
        '交通银行'     => 'BOCM',
        '上海银行'     => 'BOS',
        '渤海银行'     => 'CBHB',
        '中国建设银行'   => 'CCB',
        '中国光大银行'   => 'CEBB',
        '兴业银行'     => 'CIB',
        '招商银行'     => 'CMB',
        '中国民生银行'   => 'CMBC',
        '中信银行'     => 'CNCB',
        '浙商银行'     => 'CZBANK',
        '广发银行'     => 'GDB',
        '华夏银行'     => 'HXB',
        '中国工商银行'   => 'ICBC',
        '宁波银行'   => 'NCBC',
        '南京银行'   => 'NJCB',
        '平安银行'     => 'PAB',
        '中国邮政储蓄银行' => 'PSBC',
        '浦东银行' => 'SPDB',
    ];
    public function __construct()
    {
        $this->today = date('Ymd');
      parent::__construct();
    }
    //代付提交
    public function PaymentExec($data, $config)
    {
        foreach ($this->bankCode as $k => $v) {
            if ($k == $data['bankname']) {
                $bankCode = $v;
            }
        }
        if (!$bankCode) {
            return ['status' => 3, 'msg' => '该银行不支持！'];
        }
        $site = ((is_https()) ? 'https' : 'http') . '://' . C("DOMAIN") . '/';
        $param = [
            'merchant_no' => $config['mch_id'], //商户号
            'pay_num' => $data['orderid'],   //商户订单号
            'df_type' => 1,   //必填 0-原通道  1–SMK通道 2-Sand通道
            'amount' => intval($data['money']) * 100,  //代付金额
            'username' => $data['bankfullname'], //银行卡或存折的所有人姓名
            'banknumber' => $data['banknumber'], //银行卡号
            'notify_url' => $site . 'Payment_RuiYin_notifyurl.html',    //异步通知地址
        ];
        $signStr = $param['merchant_no'] . $param['amount'] . $param['pay_num'] . $this->today . $config['signkey'];
        $param['sign'] = strtoupper(md5($signStr));
        $result = curlPost($this->gateway, http_build_query($param));
        file_put_contents(RUNTIME_PATH . '/Logs/Payment/RuiYin.txt', "【" . date('Y-m-d H:i:s') . "】\r\n返回：" . $result . "\r\n\r\n", FILE_APPEND);

        $result = json_decode($result, true);
        switch ($result['result_code']) {
            case '1':
                $return = ['status' => 1, 'msg' => '正常申请'];
                # code...
                break;
            default:
                $return = ['status' => 3, 'msg' => $result['message']];
                # code...
                break;
        }
        return $return;
    }

    //代付异步回调
    public function notifyurl()
    {
        file_put_contents(RUNTIME_PATH . '/Logs/Payment/RuiYin.txt', "【" . date('Y-m-d H:i:s') . "】\r\n" . file_get_contents("php://input") . "\r\n\r\n", FILE_APPEND);
        $param = $_POST;
        $config = M('pay_for_another')->where(['code' => 'RuiYin'])->find();
        if (isset($param['return_code']) && $param['return_code'] == '1') {
            if (isset($param['pay_num']) && $param['pay_num']) {
                $data = M('Wttklist')->where(['orderid' => $param['pay_num']])->find();
                if (!empty($data)) {
                    $signStr = $config['mch_id'] . $param['out_trade_no'] . $param['pay_num'] . $param['amount'] . $this->today . $config['signkey'];
                    $sign = strtoupper(md5($signStr));//md5加密再转大写
                    if ($sign == $param['sign']) {
                        if ($data['memo']) {
                            $memo = '付款成功<br>' . $data['memo'];
                        } else {
                            $memo = '付款成功';
                        }
                        M('Wttklist')->where(['orderid' => $param['pay_num'], 'status' => ['in', ['1','4']]])->save(['status' => 2, 'memo' => $memo]);
                    }
                }
            }
        }
    }

    //代付订单查询
    public function PaymentQuery($data, $config)
    {
        $param = [
            'merchant_no' => $config['mch_id'],
            'pay_num' => $data['orderid'],
            'pay_method' => 1,
        ];
        $param['sign'] = strtoupper(md5($param['merchant_no'] . $param['pay_num'] .$this->today . $config['signkey']));
        file_put_contents(RUNTIME_PATH . '/Logs/Payment/RuiYin.txt', "【" . date('Y-m-d H:i:s') . "】\r\n代付查询参数" . json_encode($param) . "\r\n\r\n", FILE_APPEND);
        $result = curlPost($this->queryUrl, http_build_query($param));
        file_put_contents(RUNTIME_PATH . '/Logs/Payment/RuiYin.txt', "【" . date('Y-m-d H:i:s') . "】\r\n代付查询返回" . $result . "\r\n\r\n", FILE_APPEND);
        $result = json_decode($result, true);
        switch ($result['result_code']) {
            case '0':
                $return = ['status' => 3, 'msg' => '失败'];
                # code...
                break;
            case '1':
                $return = ['status' => 2, 'msg' => '成功'];
                # code...
                break;
            case '2':
                $return = ['status' => 1, 'msg' => '已受理'];
                # code...
                break;
            default:
                $return = ['status' => 3, 'msg' => $result['result_msg']];
                # code...
                break;
        }

        return $return;
    }

    //账户余额查询
    public function queryBalance()
    {

        if (IS_AJAX) {
           
            $config = M('pay_for_another')->where(['code' => 'RuiYin'])->find();
            $param = [
                'merchant_no' => $config['mch_id'],
                'pay_method' => 1,
            ];
            $param['sign'] = strtoupper(md5( $param['merchant_no'] . $this->today . $config['signkey']));
            $result = curlPost($this->balanceUrl, http_build_query($param));
            file_put_contents(RUNTIME_PATH . '/Logs/Payment/RuiYin.txt', "【" . date('Y-m-d H:i:s') . "】\r\n代付查询返回" . $result . "\r\n\r\n", FILE_APPEND);

            $result = json_decode($result, true);

            if ($result['return_code'] == '1') {
                $result['balance'] = $result['balance'];
                $data = [
                    [
                        'key' => '账户余额',
                        'value' => $result['balance'] . '元',
                    ],
                ];
                $this->assign('data', $data);
                $html = $this->fetch('Public/queryBalance');
                $this->ajaxReturn(['status' => 1, 'msg' => '成功', 'data' => $html]);

            } else {
                $this->ajaxReturn(['status' => 0, 'msg' => $result['message']]);
            }
        }
    }
}
