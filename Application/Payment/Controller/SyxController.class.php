<?php
namespace Payment\Controller;

class SyxController extends PaymentController
{

    public function __construct()
    {
        parent::__construct();
    }

    private $bankCode = [

        '中国邮政储蓄银行' => 'PSBC',
        '中国工商银行'   => 'ICBC',
        '中国民生银行'   => 'CMBC',
        '中国建设银行'   => 'CCB',
        '中国银行'     => 'BOC',
        '中国农业银行'   => 'ABC',
        '中国光大银行'   => 'CEB',
        '中国兴业银行'   => 'CIB',
        '中国广发银行'   => 'GDB',
        '中国华夏银行'   => 'HXBANK',
        '中国交通银行'   => 'COMM',
        '中国招商银行'   => 'CMB',
        '中国平安银行'   => 'SPABANK',
        '中国北京银行'   => 'BJBANK',
        '中国浦发银行'   => 'SPDB',
        '中国上海银行'   => 'SHBANK',

        '邮政储蓄银行'   => 'PSBC',
        '工商银行'     => 'ICBC',
        '民生银行'     => 'CMBC',
        '建设银行'     => 'CCB',
        '农业银行'     => 'ABC',
        '光大银行'     => 'CEB',
        '兴业银行'     => 'CIB',
        '广发银行'     => 'GDB',
        '华夏银行'     => 'HXBANK',
        '交通银行'     => 'COMM',
        '招商银行'     => 'CMB',
        '平安银行'     => 'SPABANK',
        '北京银行'     => 'BJBANK',
        '浦发银行'     => 'SPDB',
        '上海银行'     => 'SHBANK',
        '中信银行'     => 'CITIC',
    ];

    public function PaymentExec($wttlList, $pfaList)
    {

        foreach ($this->bankCode as $k => $v) {
            if ($k == $wttlList['bankname']) {
                $bankCode = $v;
            }
        }
        if (!$bankCode) {
            return ['status' => 3, 'msg' => '该银行不支持！'];
        }

        $arraystr = [
            'service'         => 'agentpay',
            'format'          => 'json',
            'merchantId'      => $pfaList['mch_id'],
            'inputCharset'    => 'UTF-8',
            'outOrderId'      => $wttlList['orderid'],
            'serialNo'        => 1,
            'payMethod'       => 'singleAgentPay',
            'payAmount'       => $wttlList['money'],
            'cardHolder'      => $wttlList['bankfullname'],
            'bankCardNo'      => $wttlList['banknumber'],
            'bankName'        => $wttlList['bankname'],
            'bankBranchName'  => $wttlList['bankzhiname'],
            'bankProvince'    => $wttlList['sheng'],
            'bankCity'        => $wttlList['shi'],
            'bankCode'        => $bankCode,
            'cardAccountType' => 1,
        ];
        $pfaList['public_key'] = file_get_contents($pfaList['public_key']);
        $pfaList['private_key'] = file_get_contents($pfaList['private_key']);
        $key = openssl_get_publickey($pfaList['public_key']);
        openssl_public_encrypt($wttlList['banknumber'], $encrypt, $key);
        $arraystr['bankCardNo'] = base64_encode($encrypt);

        $arraystr['sign'] = base64_encode(rsaEncryptVerify(md5Sign($arraystr, '', '', false), $pfaList['private_key']));

        $arraystr['signType'] = 'RSA';
		file_put_contents('./Data/syx.txt', "【".date('Y-m-d H:i:s')."】\r\n".json_encode($arraystr)."\r\n\r\n",FILE_APPEND);
        $returnData           = curlPost($pfaList['exec_gateway'], http_build_query($arraystr), [], 'Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US; rv:1.9.1.2) Gecko/20090729 Firefox/3.5.2 GTB5');
        file_put_contents('./Data/syx.txt', "【".date('Y-m-d H:i:s')."】\r\n".$returnData."\r\n\r\n",FILE_APPEND);
		$returnData           = json_decode($returnData, true);
        if ($returnData['retCode'] == '0000') {
            if ($returnData['status'] == '00') {
                $result = ['status' => 1, 'msg' => '申请成功'];
            } else if ($returnData['status'] == '04') {
                $result = ['status' => 2, 'msg' => '支付成功'];
            } else if ($returnData['status'] == '05') {
                $result = ['status' => 3, 'msg' => '申请失败'];
            }
        } else {
            $result = ['status' => 3, 'msg' => $returnData['retMsg']];
        }

        return $result;
    }

    public function PaymentQuery($wttlList, $pfaList)
    {

        $arraystr = [
            'service'      => 'agentpay',
            'format'       => 'json',
            'merchantId'   => $pfaList['mch_id'],
            'inputCharset' => 'UTF-8',
            'outOrderId'   => $wttlList['orderid'],
            'version'      => '1',
        ];
        $arraystr['sign']     = base64_encode(rsaEncryptVerify(md5Sign($arraystr, '', '', false), $pfaList['private_key']));
        $arraystr['signType'] = 'RSA';
        $returnData           = curlPost($pfaList['query_gateway'], http_build_query($arraystr), [], 'Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; SV1; .NET CLR 2.0.50727;)');
        $returnData           = json_decode($returnData, true);
        $returnData           = $returnData['pResult'];
        if ($returnData['retCode'] == '0000') {
            if ($returnData['status'] == '00') {
                $result = ['status' => 1, 'msg' => '申请成功'];
            } else if ($returnData['status'] == '04') {
                $result = ['status' => 2, 'msg' => '支付成功'];
            } else if ($returnData['status'] == '05') {
                $result = ['status' => 3, 'msg' => '申请失败'];
            }
        } else {
            $result = ['status' => 3, 'msg' => $returnData['retMsg']];
        }
        return $result;

    }
}
