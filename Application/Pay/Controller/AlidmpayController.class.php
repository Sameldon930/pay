<?php
/**
 * Created by PhpStorm.
 * User: gaoxi
 * Date: 2017-05-18
 * Time: 11:33
 */

namespace Pay\Controller;
//---------------------引入支付宝第三方类-----------------
vendor('Alipay.aop.AopClient');
vendor('Alipay.aop.SignData');
vendor('Alipay.aop.request.AlipayTradePrecreateRequest');
vendor('Alipay.aop.request.AlipayTradeQueryRequest');
vendor('Alipay.aop.request.AlipayFundTransToaccountTransferRequest');

class AlidmpayController extends PayController
{
    private $code = '';
    private $rsaPrivateKey = '';
    private $alipayrsaPublicKey = '';

    public function __construct()
    {
        parent::__construct();

        $matches = [];
        preg_match('/([\da-zA-Z\_]+)Controller$/', __CLASS__, $matches);
        $this->code = $matches[1];
    }

    //支付
    public function Pay($array)
    {
        $orderid = I("request.pay_orderid");
        $body = I('request.pay_productname');
//        $notifyurl   = $this->_site . 'Pay_Alipage_notifyurl.html'; //异步通知
//        $callbackurl = $this->_site . 'Pay_Alipage_callbackurl.html'; //$orderid
        file_put_contents('./Data/Aaron.txt', "【" . date('Y-m-d H:i:s') . "】\r\ARRAY：" . json_encode($array) . "\r\n\r\n", FILE_APPEND);
        $parameter = array(
            'code' => 'Alidmpay', // 通道名称
            'title' => '支付宝当面付',
            'exchange' => 1, // 金额比例
            'gateway' => '',
            'orderid' => '',
            'out_trade_id' => $orderid,
            'body' => $body,
            'channel' => $array,
        );

        // 订单号，可以为空，如果为空，由系统统一的生成
        $return = $this->orderadd($parameter);

        $site = trim($return['unlockdomain']) ? $return['unlockdomain'] . '/' : $this->_site;
        $gateway = "{$site}Pay_{$this->code}_Rpay.html";
        $notifyUrl = "{$site}Pay_{$this->code}_notifyurl.html";
        $callbackUrl = "{$site}Pay_{$this->code}_callbackurl.html?pay_orderid=" . $return['orderid'];

        $return['notifyurl'] = $notifyUrl;
        // $return['callbackurl'] = $callbackUrl;

        /* $this->EditMoney($return['orderid'], 'Aliscan', 0);
        die;*/
        $return['subject'] = $body;
        // //组装系统参数
        $data = [
            'out_trade_no' => $return['orderid'],
            'total_amount' => $return['amount'],
            'subject' => $return['subject'],
            // 'product_code' => "FAST_INSTANT_TRADE_PAY",
        ];

        $sysParams = json_encode($data, JSON_UNESCAPED_UNICODE);
        $aop = new \AopClient();
        $aop->gatewayUrl = 'https://openapi.alipay.com/gateway.do';
        $aop->appId = $return['mch_id'];
        $aop->rsaPrivateKey = $return['appsecret'];
        $aop->alipayrsaPublicKey = $return['signkey'];

        $aop->apiVersion = '1.0';
        $aop->signType = 'RSA2';
        $aop->postCharset = 'UTF-8';
        $aop->format = 'json';
        $aop->debugInfo = true;
        $request = new \AlipayTradePrecreateRequest();
        $request->setBizContent($sysParams);
        $request->setNotifyUrl($return['notifyurl']);
        // $request->setReturnUrl($return['callbackurl']);
        $result = $aop->execute($request);
        $responseNode = str_replace(".", "_", $request->getApiMethodName()) . "_response";
        $resultCode = $result->$responseNode->code;
        file_put_contents('./Data/Alidmpay.txt', "【" . date('Y-m-d H:i:s') . "】\r\nurl：---" . $return['notifyurl'] . "\r\n\r\n", FILE_APPEND);
        $mysign = md5('wmzf' . $orderid . 'wmzf');
        $checkurl = "{$site}Pay_{$this->code}_Check.html?id=" . $orderid . '&sign=' . $mysign;

        if (!empty($resultCode) && $resultCode == 10000) {
            $url = urldecode($result->alipay_trade_precreate_response->qr_code);
            // $this->showQRcode($resArr['imgurl'], $return, 'alipay');
            file_put_contents('./Data/WMTransferLogin.txt', "【" . date('Y-m-d H:i:s') . "】\r\nurl：---" . json_encode($url) . "\r\n\r\n", FILE_APPEND);
            $this->assign([
                'callbackUrl' => $callbackUrl,
                'orderid' => $return['orderid'],
                'body' => $body,
                'checkurl' => $checkurl,
                'money' => $return['amount'],
                'url' => $url
            ]);
            $this->display('Alidmpay/index');
        } else {
            echo "失败";
        }
        exit;


    }


    /**
     * 发起支付操作
     */
    public function Rpay()
    {
        //接收传输的数据
        $postData = I('post.', '');
        //将数据解密并反序列化
        $formData = unserialize(encryptDecrypt($postData['data'], md5(md5(C('DB_PWD'))), 1));

        echo $formData['result'];
    }


    //同步通知
    public function callbackurl()
    {
        $orderid = I('request.pay_orderid', '', 'string,strip_tags,htmlspecialchars');
        $Order = M("Order");
        $pay_status = $Order->where(['pay_orderid' => $orderid])->getField("pay_status");
        if ($pay_status != 0) {
            $this->EditMoney($orderid, '', 1);
        } else {
            exit("error");
        }
    }

    //异步通知
    public function notifyurl()
    {
        file_put_contents('./Data/Alidmpay.txt', "【" . date('Y-m-d H:i:s') . "】\r\收到回调：---" . "\r\n\r\n", FILE_APPEND);
        $response = $_POST;
        file_put_contents('./Data/Alidmpay.txt', "【" . date('Y-m-d H:i:s') . "】\r\回调参数：---" . json_encode($_POST) . "\r\n\r\n", FILE_APPEND);

        $publiKey = getKey((string)$response["out_trade_no"]); // 密钥
        file_put_contents('./Data/Alidmpay.txt', "【" . date('Y-m-d H:i:s') . "】\r\公钥：---" . $publiKey . "\r\n\r\n", FILE_APPEND);

        $aop = new \AopClient();
        $aop->alipayrsaPublicKey = $publiKey;
        $result = $aop->rsaCheckV1($response, null, $response['sign_type']);

        file_put_contents('./Data/Alidmpay.txt', "【" . date('Y-m-d H:i:s') . "】\r\结果：---" . $result . "\r\n\r\n", FILE_APPEND);

        if ($result) {
            if ($response['trade_status'] == 'TRADE_SUCCESS' || $response['trade_status'] == 'TRADE_FINISHED') {
                $this->EditMoney((string)$response['out_trade_no'], '', 0);
                echo "success";
            }
        } else {
            file_put_contents('./Data/Alidmpay.txt', "【" . date('Y-m-d H:i:s') . "】\r\签名失败：---" . "\r\n\r\n", FILE_APPEND);
            exit('error:check sign Fail!');
        }

    }


    /**
     * 订单支付状态查询
     */
    public function Check()
    {
        //接收传输的数据
        $getData = I('get.', '');
        //将数据解密并反序列化
        $mysing = md5('wmzf' . $getData['id'] . 'wmzf');
        if ($getData['sign'] != $mysing) {
            $this->ajaxreturn(array('code' => 00, 'msg' => '签名错误!'));
            exit();
        }
        $pay_info = M("Order")->where(array('out_trade_id' => $getData['id']))->field("pay_status")->find();

        if ($pay_info['pay_status'] == 0) {
            $this->ajaxreturn(array('code' => 100, 'msg' => '等待支付',));
        } else {
            $this->ajaxreturn(array('code' => 200, 'msg' => '订单已经支付过了', "pay_info" => M("Order")->where(array('out_trade_id' => $getData['id']))->field("pay_status")->fetchSql()->find(), "data" => $pay_info));
        }
    }
}
