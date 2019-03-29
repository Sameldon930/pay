<?php
/**
 * Created by PhpStorm.
 * User: gaoxi
 * Date: 2017-05-18
 * Time: 11:33
 */
namespace Pay\Controller;

include_once '../../Payment/Controller/AliTransferController.class.php';
use Payment\Controller\AliTransferController;
use Think\Exception;

class AliscanController extends PayController
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
        $json = I("request.json", 0 ,'intval');
        $orderid = I("request.pay_orderid");
        $body = I('request.pay_productname');
//        $notifyurl = $this->_site . 'Pay_Aliscan_notifyurl.html'; //异步通知
//        $callbackurl = $this->_site . 'Pay_Aliscan_callbackurl.html'; //返回通知

        $parameter = array(
            'code' => 'Aliscan', // 通道名称
            'title' => '支付宝官方扫码',
            'exchange' => 1, // 金额比例
            'gateway' => '',
            'orderid' => '',
            'out_trade_id' => $orderid,
            'body'=>$body,
            'channel'=>$array
        );

        // 订单号，可以为空，如果为空，由系统统一的生成
        $return = $this->orderadd($parameter);

        $site        = trim($return['unlockdomain']) ? $return['unlockdomain'] . '/' : $this->_site;
        $gateway     = "{$site}Pay_{$this->code}_Rpay.html";
        $notifyUrl   = "{$site}Pay_{$this->code}_notifyurl.html";
        $callbackUrl = "{$site}Pay_{$this->code}_callbackurl.html";

        $return['notifyurl']   = $notifyUrl;
        $return['callbackurl'] = $callbackUrl;

        /* $this->EditMoney($return['orderid'], 'Aliscan', 0);
         die;*/
        $return['subject'] = $body;

        //---------------------引入支付宝第三方类-----------------
        vendor('Alipay.aop.AopClient');
        vendor('Alipay.aop.SignData');
        vendor('Alipay.aop.request.AlipayTradePrecreateRequest');
        //组装系统参数
        $data = [
            'out_trade_no'=>$return['orderid'],
            'total_amount'=>$return['amount'],
            'subject'=>$return['subject'],
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
     	$aop->debugInfo=true;
        $request = new \AlipayTradePrecreateRequest ();
        $request->setBizContent($sysParams);
        $request->setNotifyUrl($return['notifyurl']);
        $result = $aop->execute ( $request);
              file_put_contents('./Data/WMTransferLogin.txt', "【" . date('Y-m-d H:i:s') . "】\r\nresult：" . json_encode($result) . "\r\n\r\n", FILE_APPEND);
        $responseNode = str_replace(".", "_", $request->getApiMethodName()) . "_response";
        $resultCode = $result->$responseNode->code;
      file_put_contents('./Data/WMTransferLogin.txt', "【" . date('Y-m-d H:i:s') . "】\r\resultCode：" . json_encode($resultCode) . "\r\n\r\n", FILE_APPEND);
        if(!empty($resultCode) && $resultCode == 10000){
            $url = urldecode($result->$responseNode->qr_code);
         	 print_r($url);
            die();
            file_put_contents('./Data/WMTransferLogin.txt', "【" . date('Y-m-d H:i:s') . "】\r\nqrurl：" . json_encode($url) . "\r\n\r\n", FILE_APPEND);
            if($json) {
                header('Content-Type:application/json; charset=utf-8');
                $data = array('status' => 'success', 'msg' => '下单成功', 'data' => $url);
                echo json_encode($data);
                exit;
            } else {
                header('Location:' . $url);
                /*echo createForm(
                    $gateway,
                    [
                        'data'    => encryptDecrypt(serialize([
                            'url'    => $url,
                            'return' => $this->filterData($return),
                            'view'   => 'alipay',
                        ]), md5(md5(C('DB_PWD')))),
                    ]
                );*/
            }
        } else {
            echo "失败";
        }
        exit();
    }

    /**
     *  过滤敏感信息
     */
    private function filterData($return)
    {
        unset($return['mch_id']);//商户id
        unset($return['signkey']);
        unset($return['appid']);
        unset($return['appsecret']);

        return $return;
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

        $this->showQRcode($formData['url'], $formData['return'], $formData['view']);
    }


    //同步通知
    public function callbackurl()
    {
        $orderid = I('request.orderid', '', 'string,strip_tags,htmlspecialchars');
        $Order = M("Order");
        $pay_status = $Order->where(['pay_orderid' => $orderid])->getField("pay_status");
      
        if($pay_status <> 0){
            $this->EditMoney($orderid, 'Aliscan', 1);
        }else{
            exit("error");
        }

    }

    //异步通知
    public function notifyurl()
    {
        $response = $_POST;
        $sign = $response['sign'];
        $sign_type = $response['sign_type'];
        unset($response['sign']);
        unset($response['sign_type']);
        $publiKey = getKey((string)$response["out_trade_no"]);// 密钥

        ksort($response);
        $signData = '';
        foreach ($response as $key=>$val){
            $signData .= $key .'='.$val."&";
        }
        $signData = trim($signData,'&');
        //$checkResult = $aop->verify($signData,$sign,$publiKey,$sign_type);
        $res = "-----BEGIN PUBLIC KEY-----\n" . wordwrap($publiKey, 64, "\n", true) . "\n-----END PUBLIC KEY-----";
        $result = (bool)openssl_verify($signData, base64_decode($sign), $res, OPENSSL_ALGO_SHA256);
		file_put_contents('./Data/WMTransferLogin.txt', "【" . date('Y-m-d H:i:s') . "】\r\n回调参数：---" . json_encode($response) . "\r\n\r\n", FILE_APPEND);
        if($result){
            if($response['trade_status'] == 'TRADE_SUCCESS' || $response['trade_status'] == 'TRADE_FINISHED'){
                $this->EditMoney((string)$response['out_trade_no'], 'Aliscan', 0);
             	/*sleep(5);//等待5秒
                $account_id = M('Order')->where(['pay_orderid' => $response['out_trade_no']])->getField("account_id");
                file_put_contents('./Data/WMTransferLogin.txt', "【" . date('Y-m-d H:i:s') . "】\r\naccount_id：" . json_encode($account_id) . "\r\n\r\n", FILE_APPEND);
                $mchid = M('channel_account')->where(['id'=>$account_id])->getField('mch_id');
                file_put_contents('./Data/WMTransferLogin.txt', "【" . date('Y-m-d H:i:s') . "】\r\nmchid：" . json_encode($mchid) . "\r\n\r\n", FILE_APPEND);
                $confiold='{"id":"2","code":"AliTransfer","title":"\u652f\u4ed8\u5b9d\u53e3\u7891\u4ee3\u4ed8","mch_id":"20170818082539331","appid":"20170818082539331","appsecret":"","signkey":"","public_key":"MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAmEGN9X6AHfdFeayVi2QOuhsFc8602f2c3IsMIdjjvVgJ7WZPojWtGedBhQ+7+P6Ev5kL0ULWAz8V22DnuqCRj7Z86HY5eZH9Y1yoObvq4Y7Txs1XXXm60O5eFsyTBempWraL+0aYzbyI\/jPM55SEDlvI3P7nz78IkLjdXEwAizdBuEYpnbvQNB13uHI\/c7BARRGgLwEjee5yKrw36UfF059XslglNTVS+\/y9AxZns0NPE6lsxiumGBtbanhXP3cpbQTPxeOE75jwtrhDO9HZS3TnTnz4arRljbjJd\/wic8EIXCgd2tM33VgwsSy+VPYFQ\/8ku8eKJS6VAu5jhrXySQIDAQAB","private_key":"MIIEvAIBADANBgkqhkiG9w0BAQEFAASCBKYwggSiAgEAAoIBAQCQQ1lAfBGRNEaYIax2\/uWUZYBgEJAdjRy7ow3lptPWY6ctPS7WHhh4eEeXoQWwjeF1ZPxLkWC\/PW+RuQDKEJBgggFPsKAaqTumYNlbZmdsrED6q7XTxZ7rrWKSB57WMVFSUqJt+9vdr1u\/JcBCNLcSSyqLjN5EGxK1AKuKRoPqkvDVKPNuIaCVbt+zII\/jIymdPbDV6A7T8sJp\/bU9UupfNElRKAZaPKaZ1KuNh4HV+xYb1Z58lCb9izHHP6CKBWSj4va2z4oaJhPlZVGcpsAA+2MMfJFjVvlZDdtfSt4No8at\/zPaq4TNvm9D9Rhyeu+k27YhQLlVDPt3dWn+o2N5AgMBAAECggEAAoU6tPa189x+8z97XOTdK\/eOA5+mdO23N8wEfSOqBc\/d5ttvywvhj5FCZvLIP6pq6vslsUhL8WtoXJpn2h\/p9dWvoi3Kzkxwn1qH0aH7Ypmr1PVVCusj+Kgh1b1OWB2qdw68icFhuQDMUI2fS0jSff5UMvX2GCiE7iah2JucyGdcFeo2ws0KY4VTROCaI8RXk0r0w1yB3HLpmMHqWSRujEXC7GKF1nI6pB7BrftAesUILi7ZgvH5rT9yPkfEVtosJ2efsIc6OaZxBnBbvsHkUvQhG5X97FXjhzIsHnwfqh6zWQxu1Vt1+qaxI4FX4x0qitaWasyHPG8XivE4sQ0eVQKBgQDLgBatmBdE6wZR8VFota3RAMKzUj63ow6yX93\/xxO2GKlboL\/Vat5UFdELAdw7HvYfVA6E87moLXcKe6zNy086hlpQG+hi+xrg+QUuN+OAMMYxGfGQ7t\/2hz1AOXqGmnV0Tr+tMsqJpw560KfLI51oAVntIXkoXFb93aFi29+upwKBgQC1ewNdiEdabBfjV9xXKjh0o\/aeMqovZ0WIn5W8YUeLwwINoOFSeqT0T2I\/H3ik1m4O4Qkf1zi1F9IWXTvvcs2jnT+Ez3aF8mbwi+0tNIzmo50lfZaDn6hz7rlIf9zUJ04wcaF7E5Q3t2rqWF1P44jenFLGrUpabR+GpfROLGvA3wKBgDeJx6as4Xzfn6PxdkRbgQqPaJPEGHXJvJMV8uKBlHGYHXByWKiIOBE+uwSEB3TjKEy4hhXm5n5tmhV0V176466XSEKguzV4ToejrrREcIRly1FPQUxKxTjlA+RpS3U85l1NuKYuPHSA8US3eXPJToY6CC7dedF4Eg3K1ObEFzH1AoGABnaREh2uXNwIpcIVSM1qIU1NlSi8wt9srIbycDkOsT2Kry2RmLxhb4n8N79JLqWsWb9N8eJaVKi6hK1hWw+9nxwUjQhOckrFu79f\/QIoGnatPA6S87EV8LsJwjk7hhq4QCVr2NRDrRBNMHdhK10xHKx4jjbRtRK50rPKVZZjaAUCgYAjoDWR5P9MJj2PMKgE\/+1VQ7CB2Bzf5uw6NfFGzbeNKcVmMgvFAcicDxn5mcZxyNP44JXwNhcGRELhChRl9h0+7sy8OHYf1oUeUFPDAIo3ZA0IWQ7RmZTb0mVwSwfh8NknufMDzrJlolFX6nxHc\/PPzuqBzaame\/AKnHwdAYIk5A==","exec_gateway":"https:\/\/openapi.alipay.com\/gateway.do","query_gateway":"https:\/\/openapi.alipay.com\/gateway.do","serverreturn":"https:\/\/openapi.alipay.com\/gateway.do","unlockdomain":"","updatetime":"1544867381","status":"1","is_default":"1","cost_rate":"0.0000","rate_type":"0"}';
                $confi = str_replace('20170818082539331', '2017081808253933', $confiold);
                file_put_contents('./Data/WMTransferLogin.txt', "【" . date('Y-m-d H:i:s') . "】\r\nconfi：" . json_encode($confi) . "\r\n\r\n", FILE_APPEND);
                //生成系统订单号
                $widthdrawOrderId = get_requestord();
                $widthdrawData='{"id":"6","userid":"4","bankname":"\u652f\u4ed8\u5b9d","bankzhiname":"","banknumber":"123671530@qq.com","bankfullname":"\u6d82\u7fa4\u7ae0","sheng":"\u798f\u5efa\u7701","shi":"\u6cc9\u5dde\u5e02","sqdatetime":"2018-12-17 11:39:49","cldatetime":null,"status":"0","tkmoney":"1.0000","sxfmoney":"0.0000","money":1,"t":"0","payapiid":"0","memo":null,"additional":null,"code":" ","df_id":"0","df_name":" ","orderid":"H1217179898479290","cost":"0.00","cost_rate":"0.0000","rate_type":"0","extends":"","out_trade_no":"","df_api_id":"0","auto_submit_try":"0","is_auto":"0","last_submit_time":"0","df_lock":"0","lock_time":"0","auto_query_num":"0","channel_mch_id":"","df_charge_type":"0","transaction_id":"","billno":""}';
                $widthdrawData = str_replace('H1217179898479290', $widthdrawOrderId, $widthdrawData);
                file_put_contents('./Data/WMTransferLogin.txt', "【" . date('Y-m-d H:i:s') . "】\r\n前面：---" . json_encode($widthdrawData) . "\r\n\r\n", FILE_APPEND);
                $array1=json_decode($widthdrawData,true);
                $array1["tkmoney"]=$response['buyer_pay_amount']*0.99;
                $array1["money"]=$response['buyer_pay_amount']*0.99;

                file_put_contents('./Data/WMTransferLogin.txt', "【" . date('Y-m-d H:i:s') . "】\r\n后面：---" . json_encode($array1) . "\r\n\r\n", FILE_APPEND);
                $AliTransferController =new AliTransferController();
                $AliTransferController->PaymentExec($array1,json_decode($confi,true));*/
                exit("success");
            }
        }else{
            exit('error:check sign Fail!');
        }

    }

}