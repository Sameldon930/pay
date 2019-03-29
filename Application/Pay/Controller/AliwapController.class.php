<?php
/**
 * Created by PhpStorm.
 * User: gaoxi
 * Date: 2017-05-18
 * Time: 11:33
 */
namespace Pay\Controller;


class AliwapController extends PayController
{
    private $code = '';


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
//        $notifyurl = $this->_site . 'Pay_Aliwap_notifyurl.html'; //异步通知
//        $callbackurl = $this->_site . 'Pay_Aliwap_callbackurl.html'; //返回通知
        $parameter = [
            'code' => 'Aliwap', // 通道名称
            'title' => '支付宝官方（WAP）',
            'exchange' => 1, // 金额比例
            'gateway' => '',
            'orderid' => '',
            'out_trade_id' => $orderid,
            'body'=>$body,
            'channel'=>$array
        ];
        // 订单号，可以为空，如果为空，由系统统一的生成
        $return = $this->orderadd($parameter);
        $return['subject'] = $body;

        $site        = trim($return['unlockdomain']) ? $return['unlockdomain'] . '/' : $this->_site;
        $gateway     = "{$site}Pay_{$this->code}_Rpay.html";
        $notifyUrl   = "{$site}Pay_{$this->code}_notifyurl.html";
        $callbackUrl = "{$site}Pay_{$this->code}_callbackurl.html";

        $return['notifyurl']   = $notifyUrl;
        $return['callbackurl'] = $callbackUrl;

        //---------------------引入支付宝第三方类-----------------       
        vendor('Alipay.aop.AopClient');
        vendor('Alipay.aop.SignData');
        vendor('Alipay.aop.request.AlipayTradeWapPayRequest');
        $data = [
            'out_trade_no'=>$return['orderid'],
            'total_amount'=>$return['amount'],
            'subject'=>$return['subject'],
            'product_code' => "QUICK_WAP_WAY"
        ];
        $sysParams = json_encode($data,JSON_UNESCAPED_UNICODE);
        $aop = new \AopClient();
        $aop->gatewayUrl = 'https://openapi.alipay.com/gateway.do';
        $aop->appId = $return['mch_id'];
        $aop->rsaPrivateKey = $return['appsecret'];
        $aop->alipayrsaPublicKey= $return['signkey'];
        $aop->apiVersion = '1.0';
        $aop->signType = 'RSA2';
        $aop->postCharset='UTF-8';
        $aop->format='json';
        $request = new \AlipayTradeWapPayRequest ();
        $request->setBizContent($sysParams);
        $request->setNotifyUrl($return['notifyurl']);
        $request->setReturnUrl($return['callbackurl']);
        $result = $aop->pageExecute ( $request,"post");
        // exit;
        echo createForm(
            $gateway,
            [
                'data' => encryptDecrypt(serialize([
                    'result' => $result,
                ]), md5(md5(C('DB_PWD')))),
            ]
        );
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
        $out_trade_no = I('get.out_trade_no', '', 'string,strip_tags,htmlspecialchars');
        $Order = M("Order");
        $pay_status = $Order->where(['pay_orderid' => $out_trade_no])->getField("pay_status");
        if ($pay_status <> 0) {
            //业务逻辑开始、并下发通知.
            $this->EditMoney($out_trade_no, '', 1);
        }else{
            exit('error');
        }
    }

    //异步通知
    public function notifyurl()
    {

        // $f = fopen('./api_data.txt', 'a+');
        // fwrite($f, serialize($_POST));
        // fclose($f);
        $response = $_POST;
       
        $sign = $response['sign'];
        $sign_type = $response['sign_type'];
        unset($response['sign']);
        unset($response['sign_type']);
        $publiKey =  getKey((string)$response['out_trade_no']); // 密钥

        ksort($response);
        $signData = '';
        foreach ($response as $key=>$val){
            $signData .= $key .'='.$val."&";
        }
        $signData = trim($signData,'&');
        //$checkResult = $aop->verify($signData,$sign,$publiKey,$sign_type);
        $res = "-----BEGIN PUBLIC KEY-----\n" . wordwrap($publiKey, 64, "\n", true) . "\n-----END PUBLIC KEY-----";
        $result = (bool)openssl_verify($signData, base64_decode($sign), $res, OPENSSL_ALGO_SHA256);
        if($result){
            if($response['trade_status'] == 'TRADE_SUCCESS' || $response['trade_status'] == 'TRADE_FINISHED'){
                $this->EditMoney((string)$response['out_trade_no'], 'Aliwap', 0);
                exit("success");
            }
        }else{
            exit('error:check sign Fail!');
       }

    }
}