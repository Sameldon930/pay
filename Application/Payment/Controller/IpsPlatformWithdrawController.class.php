<?php
/**
 * Created by PhpStorm.
 * User: win 10
 * Date: 2018/6/11
 * Time: 11:41
 */

namespace Payment\Controller;

/**
 * 环迅E平台提现
 *
 * Class IpsPlatformWithdrawController
 * @package Payment\Controller
 */
class IpsPlatformWithdrawController extends PaymentController
{
    //网站地址
    protected $_site;

    const MER_CODE = '205413';

    const MER_ACC_CODE = '2054130022';

    const KEY = 'A3vAjbR0ktVr9PZ7cp9sz1bm8WepTH7JbN3qcrYghQ0tsdLDJrdDlAcMEfWu0L5lhoOrbbrmq1eFDSewESt1A0YECTlLvPuVvJlOS78zm5ASnNNl3LUTg1VfPSErgCHu';

    const GATEWAY = 'http://bctrade.ips.com.cn/psfp-webfmp/withdraw/cash.do';

    const IV       = 'Bgtrq2xO';

    const TDES_KEY = 'YnqPSZARUDCFBbfUyqx0kQ9o';

    public function __construct()
    {
        parent::__construct();
        $this->_site = ((is_https()) ? 'https' : 'http') . '://' . C("DOMAIN") . '/';
    }

    public function PaymentExec($data, $config)
    {
        $info = M('ApplyEPlatform')->where(['user_id' => $data['userid'], 'status' => 2])->find();
        if(empty($info)) {
            $result = [
                'status' => 3,
                'msg'    => "错误：商户未在环迅E平台开户或审核未通过"
            ];
            return $result;
        }
        $request = [
            'Head' => [
                'version' => 'V1.0.0',
            ],
            'Body' => [
                'merCode'    => self::MER_CODE,
                'merAccCode' => self::MER_ACC_CODE,
                'userName'   => $info['user_name'],
                'accCode'    => $info['acc_code'],
                'crCode'     => '156',
                'merBillNo'  => $data['orderid'],
                'merDate'    => date('Ymd'),
                'amount'     => round($data['money'], 2),
                'fee'        => round($data['sxfmoney'], 2),
                'pageUrl'    => '',
                's2sUrl'     => $this->_site . 'Payment_IpsPlatformWithdraw_s2sUrl.html',//Service 返回给商户的结果信息发送地址
                'checkUrl'   => '',
                'noticeUrl'  => $this->_site . 'Payment_IpsPlatformWithdraw_noticeUrl.html',//提现成功或退票通知地址
                'memo'       => '',
                'remark1'    => '',
                'remark2'    => '',
            ],
        ];

        $signStr = $this->toIPSXml(['Body' => $request['Body']]) . self::KEY;

        $request['Head']['sign'] = md5($signStr);

        $xml = '<Req>' . $this->toIPSXml($request) . '</Req>';

        $ciphertext = TDEA::encrypt($xml, self::TDES_KEY, self::IV); //加密
        $post_data['argMerCode']  = self::MER_CODE;
        $post_data['arg3DesXmlPara']  = $ciphertext;
        $post_data['withdrawVersion'] = '2.0.0';
		file_put_contents('./Data/IpsPlatformSumit.txt', "【".date('Y-m-d H:i:s')."】提交提现数据：\r\n".$xml."\r\n",FILE_APPEND);
        $res = curlPost(self::GATEWAY, $post_data);
		file_put_contents('./Data/IpsPlatformSumit.txt', "【".date('Y-m-d H:i:s')."】提交提现返回：\r\n".$res."\r\n",FILE_APPEND);
        if($res) {
            $res = json_decode($res, true);
            if ($res['errCode'] == '000000') {
                $params = TDEA::decrypt($res['p3DesXmlPara'], self::TDES_KEY, self::IV);
                $params = xmlToArray($params);
                switch ($params['Body']['status']) {
                    case '1'://初始化
                        $result = ['status' => 1, 'msg' => '初始化'];
                        break;
                    case '8'://处理中
                        $result = ['status' => 1, 'msg' => '处理中'];
                        break;
                    case '9'://失败
                        $result = ['status' => 3, 'msg' => '提现失败'];
                        break;
                    case '10'://成功
                        $orderBillNo = $res['Body']['orderBillNo'];//IPS订单号
                        $trdBillNo = $res['Body']['trdBillNo'];//IPS交易流水号
                        if ($orderBillNo && $trdBillNo) {
                            M('wttklist')->where(['id' => $data['id']])->save(['transaction_id' => $orderBillNo, 'billno' => $trdBillNo]);
                        }
                        $result = ['status' => 2, 'msg' => '提现成功'];
                        break;
                }
            } else {
                $result = ['status' => 3, 'msg' => $res['errMsg']];
            }
        } else {
            $result = ['status' => 3, 'msg' => '错误：服务不可用'];
        }
        return $result;
    }

    public function PaymentQuery($data, $config)
    {
        switch ($data['status']) {
            case '1':
                $return = ['status' => 1, 'msg' => '受理中！'];
                break;
            case '2':
                $return = ['status' => 2, 'msg' => '交易成功！'];
                break;
            case '3':
                $return = ['status' => 3, 'msg' => '交易失败！'];
                break;
            default:
                $return = ['status' => 1, 'msg' => '系统错误！'];
                break;
        }
        return $return;
    }

    public function s2sUrl()
    {
        file_put_contents('./Data/IpsPlatformWithdrawS2sUrl.txt', "【".date('Y-m-d H:i:s')."】\r\n".file_get_contents("php://input")."\r\n",FILE_APPEND);
        $data = $_REQUEST;
        if ($data['errCode'] == '000000') {
            $params = TDEA::decrypt($data['p3DesXmlPara'], self::TDES_KEY, self::IV);
            $params = xmlToArray($params);
            switch ($params['Body']['status']) {
                case '1'://初始化
                    $result = ['status' => 1, 'msg' => '初始化'];
                    break;
                case '8'://处理中
                    $result = ['status' => 1, 'msg' => '处理中'];
                    break;
                case '9'://失败
                    $result = ['status' => 4, 'msg' => '提现失败'];
                    break;
                case '10'://成功
                    $orderBillNo = $params['Body']['orderBillNo'];//IPS订单号
                    $trdBillNo = $params['Body']['trdBillNo'];//IPS交易流水号
                    if ($orderBillNo && $trdBillNo) {
                        M('wttklist')->where(['id' => $data['id']])->save(['transaction_id' => $orderBillNo, 'billno' => $trdBillNo]);
                    }
                    $result = ['status' => 2, 'msg' => '提现成功'];
                    break;
            }
            if($result) {
                M('wttklist')->where(['id' => $data['id']])->save(['status' => $result['status'], 'memo' => $result['msg']]);
            }
        }
    }

    public function noticeUrl()
    {
        file_put_contents('./Data/IpsPlatformWithdrawNoticeUrl.txt', "【".date('Y-m-d H:i:s')."】\r\n".file_get_contents("php://input")."\r\n",FILE_APPEND);
        $data = $_REQUEST;
        if ($data['errCode'] == '000000') {
            $params = TDEA::decrypt($data['p3DesXmlPara'], self::TDES_KEY, self::IV);
            $params = xmlToArray($params);
            $orderid = $params['Body']['merBillNo'];
            if ($params['Body']['status'] == 10) {//提现成功
                M('wttklist')->where(['orderid' => $orderid])->save(['status' => 2]);
            } elseif($params['Body']['status'] == 4) {//已退票
                M('wttklist')->where(['orderid' => $orderid])->save(['status' => 4, 'memo' => '已退票']);
            }
            exit('ipscheckok');
        }
    }

    public function toIPSXml($data)
    {

        $xmlStr = '';
        foreach ($data as $k => $v) {

            $xmlStr .= '<' . $k . '>';
            foreach ($v as $k1 => $v1) {
                $xmlStr .= '<' . $k1 . '>' . trim($v1) . '</' . $k1 . '>';
            }
            $xmlStr .= '</' . $k . '>';

        }
        return $xmlStr;
    }
}

class TDEA
{
    public static function encrypt($input, $key, $iv, $base64 = true)
    {
        $size                  = 8;
        $input                 = self::pkcs5_pad($input, $size);
        $encryption_descriptor = mcrypt_module_open(MCRYPT_3DES, '', 'cbc', '');
        mcrypt_generic_init($encryption_descriptor, $key, $iv);
        $data = mcrypt_generic($encryption_descriptor, $input);
        mcrypt_generic_deinit($encryption_descriptor);
        mcrypt_module_close($encryption_descriptor);
        return base64_encode($data);
    }

    public static function decrypt($crypt, $key, $iv, $base64 = true)
    {
        $crypt                 = base64_decode($crypt);
        $encryption_descriptor = mcrypt_module_open(MCRYPT_3DES, '', 'cbc', '');
        mcrypt_generic_init($encryption_descriptor, $key, $iv);
        $decrypted_data = mdecrypt_generic($encryption_descriptor, $crypt);
        mcrypt_generic_deinit($encryption_descriptor);
        mcrypt_module_close($encryption_descriptor);
        $decrypted_data = self::pkcs5_unpad($decrypted_data);
        return rtrim($decrypted_data);
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