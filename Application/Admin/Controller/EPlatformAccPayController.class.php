<?php
namespace Admin\Controller;

use Think\Controller;

class EPlatformAccPayController extends BaseController
{
    //网站地址
    protected $_site;

    const MER_CODE = '205413';

    const MER_ACC_CODE = '2054130022';

    const KEY = 'A3vAjbR0ktVr9PZ7cp9sz1bm8WepTH7JbN3qcrYghQ0tsdLDJrdDlAcMEfWu0L5lhoOrbbrmq1eFDSewESt1A0YECTlLvPuVvJlOS78zm5ASnNNl3LUTg1VfPSErgCHu';

    const GATEWAY = 'http://bctrade.ips.com.cn/psfp-webfmp/accPay.do';

    const IV       = 'Bgtrq2xO';

    const TDES_KEY = 'YnqPSZARUDCFBbfUyqx0kQ9o';

    const USER_NAME_PAYER = '';//付款方用户名

    const ACC_CODE_PAYER  = '';//付款方账户号

    const USER_NAME_PAYEE = '';//付款方用户名



    public function __construct()
    {
        parent::__construct();
        $this->_site = ((is_https()) ? 'https' : 'http') . '://' . C("DOMAIN") . '/';
    }

    public function index()
    {

        $user_name     = I('get.username', '', 'trim');//商户号
        $real_name     = I("get.realname", '', 'trim');//真实姓名
        $mobile        = I("get.mobile", '', 'trim');//手机号码
        $bank_no       = I("get.bankno", '', 'trim');//银行账户号
        $apply_time    = I("get.applytime", '', 'trim');//银行账户号
        if($user_name) {
            $where['user_name'] = ['like', '%'.$user_name.'%'];
        }
        if($real_name) {
            $where['real_name'] = ['like', '%'.$real_name.'%'];
        }
        if($mobile) {
            $where['mobile'] = ['eq', $mobile];
        }
        if($bank_no) {
            $where['bank_no'] = ['eq', $bank_no];
        }
        if ($apply_time) {
            list($starttime, $endtime) = explode('|', $apply_time);
            $where['apply_time']      = ["between", [strtotime($starttime), strtotime($endtime)]];
        }
        $where['status'] = 2;
        $count = M('ApplyEPlatform')->where($where)->count();
        $size  = 15;
        $rows  = I('get.rows', $size, 'intval');
        if (!$rows) {
            $rows = $size;
        }
        $page = new Page($count, $rows);
        $list = M('ApplyEPlatform')
            ->where($where)
            ->limit($page->firstRow . ',' . $page->listRows)
            ->order('id desc')
            ->select();
        $this->assign('rows', $rows);
        $this->assign("list", $list);
        $this->assign('page', $page->show());
        $this->assign('user_name', $user_name);
        $this->assign('real_name', $real_name);
        $this->assign('mobile', $mobile);
        $this->assign('bank_no', $bank_no);
        $this->assign('apply_time', $apply_time);
        $this->display();
    }

    //账户支付
    public function pay() {
        if (IS_POST) {
            $user_id = I("post.uid", 0 , 'intval');
            if($user_id<=0) {
                $this->ajaxReturn(['status' => 0, 'msg' => '参数错误']);
            }
            $info = M('ApplyEPlatform')->where(['user_id' => $user_id, 'status' => 2])->find();
            if(empty($info)) {
                $this->ajaxReturn(['status' => 0, 'msg' => '错误：商户未在环迅E平台开户或审核未通过']);
            }
            $amount = floatval(I("post.amount"));
            if($amount<=0) {
                $this->ajaxReturn(['status' => 0, 'msg' => '金额错误']);
            }
            $orderid     = date('Ymd') . mt_rand(10000, 99999) . str_pad($user_id, 4, 0, STR_PAD_LEFT);

            $accPayID = M('ips_accpay')->add([
                'orderid'      => $orderid,
                'user_id'      => $user_id,
                'amount'       => $amount,
                'create_at'    => time(),
                'status'       => 0,
            ]);
            if (!$accPayID) {
                $this->ajaxReturn(['status' => 0, 'msg' => '支付失败！']);
            }
            $request = [
                'Head' => [
                    'version' => 'V1.0.0',
                ],
                'Body' => [
                    'merCode'     => self::MER_CODE,//平台商户号
                    'merAccCode'  => self::MER_ACC_CODE,//平台商户账户号
                    'userNamePayer' => self::USER_NAME_PAYER,//付款方用户名
                    'accCodePayer' => self::ACC_CODE_PAYER,//付款方账户号
                    'userNamePayee' => self::USER_NAME_PAYEE,//收款方用户名
                    'accCodePayee' => self::ACC_CODE_PAYER,//收款方账户号
                    'merBillNo' => $orderid,//账户支付订单号
                    'merDate' => date('Ymd'),//提交日期
                    'crCode' => '156',//币种
                    'amount' => $amount,//支付金额
                    'fee' => '0',//手续费
                    'feeWho' => '1',//手续费承担方 1#付款方承担手续费 2#收款方承担手续费
                    'payType' => '1',//支付指令 1#直接支付 2#确认支付 3#网银支付
                    'pageUrl'     => $this->_site . 'Pay_EPlatform_accPayCallbackurl.html',
                    's2sUrl'      => $this->_site . 'Pay_EPlatform_accPayNotifyurl.html',
                    'checkUrl'    => '',
                    'memo'        => '',
                    'remark1'     => '',
                    'remark2'     => '',
                ],
            ];

            $signStr = $this->toIPSXml(['Body' => $request['Body']]) . self::KEY;

            $request['Head']['sign'] = md5($signStr);

            $xml = '<Req>' . $this->toIPSXml($request) . '</Req>';

            $ciphertext = TDEA::encrypt($xml, self::TDES_KEY, self::IV); //加密

            echo createForm(self::GATEWAY, ['argMerCode' => self::MER_CODE, 'arg3DesXmlPara' => $ciphertext]);
            exit;
        } else {
            $user_id = I("get.userid", 0 , 'intval');
            if($user_id<=0) {
                $this->error('参数错误');
            }
            $info = M('ApplyEPlatform')->where(['user_id' => $user_id, 'status' => 2])->find();
            if(empty($info)) {
                $this->error('错误：商户未在环迅E平台开户或审核未通过');
            }
            $this->assign('info', $info);
            $this->display();
        }
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
class TDEA
{
    public static function encrypt($input, $key, $iv, $base64 = true)
    {
        $size = 8;
        $input = self::pkcs5_pad($input, $size);
        $encryption_descriptor = mcrypt_module_open(MCRYPT_3DES, '', 'cbc', '');
        mcrypt_generic_init($encryption_descriptor, $key, $iv);
        $data = mcrypt_generic($encryption_descriptor, $input);
        mcrypt_generic_deinit($encryption_descriptor);
        mcrypt_module_close($encryption_descriptor);
        return base64_encode($data);
    }

    public static function decrypt($crypt, $key, $iv, $base64 = true)
    {
        $crypt = base64_decode($crypt);
        $encryption_descriptor = mcrypt_module_open(MCRYPT_3DES, '', 'cbc', '');
        mcrypt_generic_init($encryption_descriptor, $key, $iv);
        $decrypted_data = mdecrypt_generic($encryption_descriptor, $crypt);
        mcrypt_generic_deinit($encryption_descriptor);
        mcrypt_module_close($encryption_descriptor);
        $decrypted_data = self::pkcs5_unpad($decrypted_data);
        returnrtrim($decrypted_data);
    }

    private static function pkcs5_pad($text, $blocksize)
    {
        $pad = $blocksize - (strlen($text) % $blocksize);
        return $text . str_repeat(chr($pad), $pad);
    }

    private static function pkcs5_unpad($text)
    {
        $pad = ord($text{strlen($text) - 1});
        if ($pad > strlen($text)) {
            return false;
        }
        return substr($text, 0, -1 * $pad);
    }
}