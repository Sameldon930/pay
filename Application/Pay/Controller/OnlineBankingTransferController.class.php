<?php
namespace Pay\Controller;

use Think\Log;

class OnlineBankingTransferController extends PayController
{
    private $code = '';

    // private $gateway = 'http://129.28.84.68:8085/pay/doAction';
    private $gateway = 'http://118.24.63.21:8085/pay/doAction';

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
        $orderid = I("request.pay_orderid", '');
        $body = I('request.pay_productname', '');
        $memberid = I('request.pay_memberid', '');

        //创建订单
        $return = $this->creatorder($array, $orderid, $body);
        //如果生成错误，自动跳转错误页面
        $return["status"] == "error" && $this->showmessage($return["errorcontent"]);
        //跳转页面，优先取数据库中的跳转页面
        $site = trim($return['unlockdomain']) ? $return['unlockdomain'] . '/' : $this->_site;
        $gateway = "{$site}Pay_{$this->code}_Rpay.html";
        $return["notifyurl"] || $return["notifyurl"] = "{$site}Pay_{$this->code}_notifyurl.html";
        $return['callbackurl'] || $return['callbackurl'] = "{$site}Pay_{$this->code}_callbackurl.html";

        $native = array(
            "service" => 'unifiedorder', //商户uid
            "pay_code" => 'GATEWAY_PAY_PC', //接口名
            "merchants" => $return['mch_id'], //接口名
            "type" => '2', //接口名
            "merchant_no" => $return['mch_id'], //商户uid
            "order_no" => $return['orderid'],  //商户自定义订单号
            "amount" => intval($return['amount'] * 100), //金额
            "product_name" => $body, //金额
            "notify_url"=>   $return['notifyurl'],
        );

        ksort($native);
        $md5str = "";
        foreach ($native as $key => $val) {
            $md5str = $md5str . $key . "=" . $val . "&";
        }
        //echo($md5str . "key=" . $Md5key);
        file_put_contents('./Data/OnlineBankingTransferPay.txt', "【" . date('Y-m-d H:i:s') . "】\r下单报文:" . $md5str . "key=" .  $return['signkey'] . "\r\n\r\n", FILE_APPEND);
        $sign = strtolower(md5($md5str . "key=" .  $return['signkey']));
        $native['sign'] = $sign;                //签名
        file_put_contents('./Data/OnlineBankingTransferPay.txt', "【" . date('Y-m-d H:i:s') . "】\r下单密文:" . $native['sign'] . "\r\n\r\n", FILE_APPEND);

        $post_data  = [
            'service'            => $native['service'],
            'pay_code'        => $native['pay_code'],
            'merchants'        => $native['merchants'],
            'type'        => $native['type'],
            'merchant_no'        => $native['merchant_no'],
            'order_no'        => $native['order_no'],
            'amount'        => $native['amount'],
            'product_name'        => $native['product_name'],
            'notify_url'        => $native['notify_url'],
            'sign'        => $native['sign'],
        ];

        file_put_contents('./Data/OnlineBankingTransferPay.txt', "【" . date('Y-m-d H:i:s') . "】\r\n网银转账下单参数json_encode：" . json_encode($post_data)  . "\r\n\r\n", FILE_APPEND);

        $reInfo = json_decode(curlPost($this->gateway, http_build_query($post_data)), true);
        file_put_contents('./Data/OnlineBankingTransferPay.txt', "【" . date('Y-m-d H:i:s') . "】\r网银转账下单返回参数!" . json_encode($reInfo) . "\r\n\r\n", FILE_APPEND);
        if ($reInfo['code'] === 0) {
            //$result = json_encode($reInfo['data']);
          // $result = json_decode($result,true);
          $result = $reInfo['data'];
          file_put_contents('./Data/OnlineBankingTransferPay.txt', "【" . date('Y-m-d H:i:s') . "】\r网银转账data!" . json_encode($reInfo['data']) . "\r\n\r\n", FILE_APPEND);
           file_put_contents('./Data/OnlineBankingTransferPay.txt', "【" . date('Y-m-d H:i:s') . "】\r网银转账url!" . $result['url'] . "\r\n\r\n", FILE_APPEND);
            /*if(strpos($_SERVER['HTTP_USER_AGENT'], 'Android')||strpos($_SERVER['HTTP_USER_AGENT'], 'iPhone')){
                header('Location: '.$result['url']);
            }else{
                $this->showQRcode($result['url'], $return, 'yl');
            }*/
            //header('Location: '.$result['url']);
          file_put_contents('./Data/OnlineBankingTransferPay.txt', "【" . date('Y-m-d H:i:s') . "】\r网银转账IMG!" . $post_data['order_no'].'.jpg' . "\r\n\r\n", FILE_APPEND);
          $this->showQRcode($post_data['order_no'].'.jpg', $return, 'yl');
        }else{
            echo '系统繁忙！！【===  '.$reInfo['msg'].' ===】';
        }
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
        file_put_contents(RUNTIME_PATH . '/Logs/Pay/WMpay_callback.txt', "【" . date('Y-m-d H:i:s') . "】\r\n" . json_encode($_REQUEST) . "\r\n\r\n", FILE_APPEND);
        $out_trade_no = I('get.orderid', '', 'string,strip_tags,htmlspecialchars');
        $Order = M("Order");
        $pay_status = $Order->where(['pay_orderid' => $out_trade_no])->getField("pay_status");
        if ($pay_status <> 0) {
            //业务逻辑开始、并下发通知.
            $this->EditMoney($out_trade_no, '', 1);
        } else {
            exit('error');
        }
    }

    //异步通知
    public function notifyurl()
    {
        if (! $_REQUEST["order_no"]) return;
        $orderList = M('Order')->where(['pay_orderid' =>  $_REQUEST["order_no"]])->find();
        if (!$orderList) return;
        file_put_contents('./Data/OnlineBankingTransferPay.txt', "【" . date('Y-m-d H:i:s') . "】\r\n网银转账异步通知订单号：" .  $_REQUEST["order_no"]  . "\r\n\r\n", FILE_APPEND);

        $returnArray = array( // 返回字段
            "service" => $_REQUEST["service"], // 商户ID
            "pay_code" =>  $_REQUEST["pay_code"], // 订单号
            "merchant_no" =>  $_REQUEST["merchant_no"], // 交易金额
            "merchants" =>  $_REQUEST["merchants"], // 交易时间
            "order_no" =>  $_REQUEST["order_no"], // 支付流水号
            "amount" => $_REQUEST["amount"],
            "pay_state" => $_REQUEST["pay_state"]
        );
        file_put_contents('./Data/OnlineBankingTransferPay.txt', "【" . date('Y-m-d H:i:s') . "】\r\n网银转账异步通知：" .  json_encode($returnArray)  . "\r\n\r\n", FILE_APPEND);
        file_put_contents('./Data/OnlineBankingTransferPay.txt', "【" . date('Y-m-d H:i:s') . "】\r\n网银转账异步通知签名1：" .  $_REQUEST["sign"]  . "\r\n\r\n", FILE_APPEND);
        ksort($returnArray);
        $md5str = "";
        foreach ($returnArray as $key => $val) {
            $md5str = $md5str . $key . "=" . $val . "&";
        }
        file_put_contents('./Data/OnlineBankingTransferPay.txt', "【" . date('Y-m-d H:i:s') . "】\r\n网银转账异步通知报文：" .  $md5str . "key=" . $orderList['key']  . "\r\n\r\n", FILE_APPEND);
        $sign = strtolower(md5($md5str . "key=" . $orderList['key'] ));
        file_put_contents('./Data/OnlineBankingTransferPay.txt', "【" . date('Y-m-d H:i:s') . "】\r\n网银转账异步通知签名2：" .  $sign . "\r\n\r\n", FILE_APPEND);

        if ($sign == $_REQUEST["sign"]) {
            if ($_REQUEST["pay_state"] == "1") {
                file_put_contents('./Data/OnlineBankingTransferPay.txt', "【" . date('Y-m-d H:i:s') . "】\r\n网银转账异步通知成功：" ."\r\n\r\n", FILE_APPEND);
                $this->EditMoney($_REQUEST['order_no'], 'OnlineBankingTransfer', 0);
                echo "success";
                return;
            }
        }else {
            echo "签名错误！  " . json_encode($_REQUEST);
        }

    }


    /**
     * 创建订单
     * @param $array
     * @param $orderid
     * @param $body
     * @return array
     */
    private function creatorder($array, $orderid, $body)
    {
        $parameter = [
            'code' => 'OnlineBankingTransfer',
            'title' => '网银转账代收',
            'exchange' => 1, // 金额比例
            'gateway' => '',
            'orderid' => '',
            'out_trade_id' => $orderid, //外部订单号
            'channel' => $array,
            'body' => $body,
        ];
        // 订单号，可以为空，如果为空，由系统统一的生成
        return $this->orderadd($parameter);
    }

    /**
     * post提交
     * @param $url
     * @param $data
     * @return string
     */
    function post_json_data($url, $data_string)
    {
        $ch = curl_init();

        curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, FALSE);
        curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, FALSE);

        curl_setopt($ch, CURLOPT_POST, 1);
        curl_setopt($ch, CURLOPT_URL, $url);
        curl_setopt($ch, CURLOPT_POSTFIELDS, $data_string);
        curl_setopt($ch, CURLOPT_HTTPHEADER, array(
                'Content-Type: application/json; charset=utf-8',
                'Content-Length: ' . strlen($data_string))
        );
        ob_start();
        curl_exec($ch);
        $return_content = ob_get_contents();
        ob_end_clean();
        $return_code = curl_getinfo($ch, CURLINFO_HTTP_CODE);
        return $return_content;
    }

    //下单签名
    function ZFBS1Sign($dat)
    {
        $str = 'amount=' . $dat['amount'] . '&jspay_flag=' . $dat['jspay_flag'] . '&jump_url=' . $dat['jump_url'] . '&merchant_id=' . $dat['merchant_id'] . '&notify_url=' . $dat['notify_url']
            . '&nonce_str=' . $dat['nonce_str'] .'&pay_way=' . $dat['pay_way'] . '&service=' . $dat['service'] . '&third_order_id=' . $dat['third_order_id'] . '&key=' . $dat['key'];
        file_put_contents('./Data/OnlineBankingTransferPay.txt', "【" . date('Y-m-d H:i:s') . "】\r\下单报文:" . $str . "\r\n\r\n", FILE_APPEND);
        return strtoupper(md5($str));
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

     * 发送post请求

     * @param string $url 请求地址

     * @param array $post_data post键值对数据

     * @return string

     */

    function send_post($url, $post_data) {



        $postdata = http_build_query($post_data);

        $options = array(

            'http' => array(

                'method' => 'POST',

                'header' => 'Content-type:application/x-www-form-urlencoded',

                'content' => $postdata,

                'timeout' => 15 * 60 // 超时时间（单位:s）

            )

        );

        $context = stream_context_create($options);

        $result = file_get_contents($url, false, $context);



        return $result;

    }


}
