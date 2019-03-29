<?php
namespace User\Controller;

use Think\Controller;

class ApplyEPlatformController extends UserController
{
    const MER_CODE = '205413';

    const MER_ACC_CODE = '2054130022';

    const KEY = 'A3vAjbR0ktVr9PZ7cp9sz1bm8WepTH7JbN3qcrYghQ0tsdLDJrdDlAcMEfWu0L5lhoOrbbrmq1eFDSewESt1A0YECTlLvPuVvJlOS78zm5ASnNNl3LUTg1VfPSErgCHu';

    const GATEWAY = 'http://bctrade.ips.com.cn/psfp-webfmp/createUser.do';

    const IV       = 'Bgtrq2xO';
    const TDES_KEY = 'YnqPSZARUDCFBbfUyqx0kQ9o';

    public function index()
    {

        $info = M('ApplyEPlatform')->where(['user_id' => session('user_auth.uid')])->find();
        if ((time() - $info['apply_time']) > 7000) {
            M('ApplyEPlatform')->where(['id' => $info['id']])->save(['status' => 0]);
        }
        $this->assign('info', $info);
        $this->display();
    }

    public function add()
    {
        if (IS_AJAX) {
            $data = I('post.', '');
            $info = M('ApplyEPlatform')->where(['user_id' => session('user_auth.uid')])->find();

            $params = [
                'api_type'     => 1,
                'user_type'    => $data['user_type'],
                'id_type'      => 1,
                'id_card'      => $data['id_card'],
                'bank_no'      => $data['bank_no'],
                'user_name'    => (10000 + session('user_auth.uid')),
                'real_name'    => $data['real_name'],
                'acc_name'     => session('user_auth.username'),
                'mobile'       => $data['mobile'],
                'email'        => $data['email'],
                'company_name' => $data['company_name'],
                'biz_no'       => $data['biz_no'],
                'company_no'   => $data['company_no'],
                'user_id'      => session('user_auth.uid'),
                'status'       => 1,
            ];

            if (!$info || (time() - $info['apply_time']) > 7000) {
                $params['reg_bill_no'] = date('Ymd') . mt_rand(10, 99) . str_pad(session('user_auth.uid'), 4, 0, STR_PAD_LEFT);
                $params['apply_time']  = time();
            }

            if ($info == 0) {
                $res = M('ApplyEPlatform')->add($params);
            } else {
                $res = M('ApplyEPlatform')->where(['user_id' => session('user_auth.uid')])->save($params);
            }
        }

        $this->ajaxReturn(['status' => $res]);
    }

    public function apply()
    {
        $info = M('ApplyEPlatform')->where(['user_id' => session('user_auth.uid'), 'status' => 1])->find();
        $site = ((is_https()) ? 'https' : 'http') . '://' . C("DOMAIN") . '/';

        if ($info) {
            $request = [
                'Head' => [
                    'version' => 'V1.0.0',
                ],
                'Body' => [
                    'regBillNo'   => $info['reg_bill_no'],
                    'apiType'     => $info['api_type'],
                    'merCode'     => self::MER_CODE,
                    'merAccCode'  => self::MER_ACC_CODE,
                    'userType'    => $info['user_type'],
                    'idType'      => $info['id_type'],
                    'idCard'      => $info['id_card'],
                    'bankNo'      => $info['bank_no'],
                    'userName'    => $info['user_name'],
                    'realName'    => $info['real_name'],
                    'accName'     => $info['acc_name'],
                    'mobile'      => $info['mobile'],
                    'email'       => $info['email'],
                    'companyName' => $info['company_name'],
                    'bizNo'       => $info['biz_no'],
                    'companyNo'   => $info['company_no'],
                    'pageUrl'     => $site . 'Pay_EPlatform_callbackurl.html',
                    's2sUrl'      => $site . 'Pay_EPlatform_notifyurl.html',
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

            echo $this->createForm(self::GATEWAY, ['argMerCode' => self::MER_CODE, 'arg3DesXmlPara' => $ciphertext]);
            exit;
        } else {
            $this->error('请填写信息！');
        }
    }

    public function createForm($url, $data)
    {
        $str = '<!doctype html>
            <html>
                <head>
                    <meta charset="utf8">
                    <title>正在申请页</title>
                </head>
                <body onLoad="document.pay.submit()">
                <form method="post" action="' . $url . '" name="pay">';

        foreach ($data as $k => $vo) {
            $str .= "<input type='hidden' name='{$k}' value='{$vo}'>";
        }

        $str .= '</form>
                <body>
            </html>';
        return $str;
    }

    public function toIPSXml($data)
    {

        $arr = [
            'realName',
            'accName',
            'companyName',
            'pageUrl',
            's2sUrl',
            'checkUrl',
            'memo',
            'remark1',
            'remark2',
        ];
        $xmlStr = '';
        foreach ($data as $k => $v) {

            $xmlStr .= '<' . $k . '>';
            foreach ($v as $k1 => $v1) {
                // if ($v1) {
                // if (in_array($k1, $arr)) {
                // $xmlStr .= '<' . $k1 . '><![CDATA[' . trim($v1) . ']]></' . $k1 . '>';
                // } else {
                $xmlStr .= '<' . $k1 . '>' . trim($v1) . '</' . $k1 . '>';

                // }
                // }
            }
            $xmlStr .= '</' . $k . '>';

        }
        return $xmlStr;
    }

}
/**
 *
 */
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
