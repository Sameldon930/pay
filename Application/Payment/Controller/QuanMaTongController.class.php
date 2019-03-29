<?php

namespace Payment\Controller;

class QuanMaTongController extends PaymentController
{
    protected $password = "Fjjmlg1613.";

    public function __construct()
    {
        parent::__construct();
    }

    //代付提交
    public function PaymentExec($data, $config)
    {
        $site = ((is_https()) ? 'https' : 'http') . '://' . C("DOMAIN") . '/';
        //请求参数,先拼接所需的单号格式
        $time = date("Ymd", strtotime($data['sqdatetime']));
        $new_orderid = $time . "_" . $data['orderid'];
        $myParams = array(
            "method" => "ysepay.df.single.quick.accept",
            //"method" => "ysepay.df.single.normal.accept",
            "partner_id" => $config['mch_id'],//"jumeihui"
            "timestamp" => date("Y-m-d H:i:s", time()),
            "charset" => "utf-8",
            "sign_type" => "RSA",
            "notify_url" => $site . 'Payment_QuanMaTong_notifyurl.html',    //异步通知地址,
            "version" => "3.0",
        );

        $biz_content_arr = array(
            "out_trade_no" => $new_orderid,
            "shopdate" => $time,
            "business_code" => "2010022",
            "currency" => "CNY",
            "total_amount" => sprintf("%.2f", $data['money']),
            "subject" => "余额提现",
            "bank_name" => $data['bankname'],//银行名称
            "bank_city" => $data['shi'],
            "bank_account_no" => $data['banknumber'],//银行帐号
            "bank_account_name" => $data['bankfullname'],//银行帐号用户名
            "bank_account_type" => "personal",
            "bank_card_type" => "debit"
        );
        $myParams['biz_content'] = json_encode($biz_content_arr, JSON_UNESCAPED_UNICODE);//构造字符串
        //dump($myParams);
        ksort($myParams);
        $signStr = "";
        foreach ($myParams as $key => $val) {
            $signStr .= $key . '=' . $val . '&';
        }
        $signStr = rtrim($signStr, '&');
        //dump($signStr);
        $sign = $this->sign_encrypt(array('data' => $signStr));
        $myParams['sign'] = trim($sign['check']);
        //dump($myParams);
        $result = curlPost("https://df.ysepay.com/gateway.do", http_build_query($myParams));
        $result = json_decode($result, true);
        file_put_contents(RUNTIME_PATH . '/Logs/Payment/QuanMaTong_notify.txt', "【" . date('Y-m-d H:i:s') . "】\r\n代付请求结果：" . json_encode($result) . "\r\n\r\n", FILE_APPEND);
        $response = $result[str_replace(".", "_", $myParams["method"]) . "_response"];
        if ($response['code'] != 10000) {
            $return = ['status' => 3, 'msg' => $response['sub_msg'] . "! code:" . $response['code'] . "! sub_code:" . $response['sub_code']];
        } else {
            $return = ['status' => 1, 'msg' => $response['trade_status_description']];
        }
        return $return;
    }


    //代付异步回调
    //参数
    //account_date=20170712&fee=0.01&notify_time=2017-07-12 10:47:19&notify_type=ysepay.df.single.notify
    //&out_trade_no=20170712104713&sign_type=RSA&total_amount=100.00&trade_no=102170712196446868
    //&trade_status=TRADE_SUCCESS&trade_status_description=交易成功
    public function notifyurl()
    {
        //拆分出所需要的订单号
        $out_trade_no = $_POST['out_trade_no'];
        list($time, $orderid) = explode("_", $out_trade_no);
        file_put_contents(RUNTIME_PATH . '/Logs/Payment/QuanMaTong_notify.txt', "【" . date('Y-m-d H:i:s') . "】\r\n收到回调参数：" . json_encode($_POST) . "\r\n\r\n", FILE_APPEND);
        //返回的数据处理
        $sign = trim($_POST['sign']);
        $result = $_POST;
        unset($result['sign']);
        ksort($result);
        $url = "";
        foreach ($result as $key => $val) {
            if ($val) $url .= $key . '=' . $val . '&';
        }
        $data = trim($url, '&');
        /* 验证签名 仅作基础验证 *写入日志*/
        if ($this->sign_check($sign, $data) == true) {
            file_put_contents(RUNTIME_PATH . '/Logs/Payment/QuanMaTong_notify.txt', "【" . date('Y-m-d H:i:s') . "】\r\n收到回调sql1：" . M("wttklist")->where(['orderid' => $orderid])->fetchSql()->find() . "\r\n\r\n", FILE_APPEND);
            $data = M("wttklist")->where(['orderid' => $orderid])->find();
            if (!empty($data)) {
                if ($data['memo']) {
                    $memo = '付款成功<br>' . $data['memo'];
                } else {
                    $memo = '付款成功';
                }
                file_put_contents(RUNTIME_PATH . '/Logs/Payment/QuanMaTong_notify.txt', "【" . date('Y-m-d H:i:s') . "】\r\n收到回调sql2：" . M("wttklist")->where(['orderid' => $orderid, 'status' => ['in', [1, 4]]])->fetchSql()->save(['status' => 2, 'memo' => $memo]) . "\r\n\r\n", FILE_APPEND);
                //判断交易状态
                file_put_contents(RUNTIME_PATH . '/Logs/Payment/QuanMaTong_notify.txt', "【" . date('Y-m-d H:i:s') . "】\r\n收到回调交易状态：" . $_POST['trade_status'] . "\r\n\r\n", FILE_APPEND);
                if($_POST['trade_status']=="TRADE_SUCCESS"){
                    file_put_contents(RUNTIME_PATH . '/Logs/Payment/QuanMaTong_notify.txt', "【" . date('Y-m-d H:i:s') . "】\r\n进来过：" . $_POST['trade_status'] . "\r\n\r\n", FILE_APPEND);
                    M("wttklist")->where(['orderid' => $orderid, 'status' => ['in', [1, 4]]])->save(['status' => 2, 'memo' => $memo]);
                    file_put_contents(RUNTIME_PATH . '/Logs/Payment/QuanMaTong_notify.txt', "【" . date('Y-m-d H:i:s') . "】\r\n 输出成功：" . $_POST['trade_status'] . "\r\n\r\n", FILE_APPEND);
                    echo 'success';
                    exit;
                }
            }
        } else {
            file_put_contents(RUNTIME_PATH . '/Logs/Payment/QuanMaTong_notify.txt', "Validation failure!|\r\nnotify|:" . $data . "\r\n|异步通知验签失败sign:" . $sign, FILE_APPEND);
        }
        /*
           开发须知:
           收到异步通知后,必须响应success给银盛,用于告诉银盛已成功接收到异步消息,
           多次不返回success的商户银盛将不会往商户异步地址发送异步消息(并拉黑商户异步地址,拉黑多个地址后拉黑商户号 无法解除)
         */
        echo 'success';
        exit;
    }


    //代付订单查询
    public function PaymentQuery($data, $config)
    {
        //请求参数,先拼接所需的单号格式
        $time = date("Ymd", strtotime($data['sqdatetime']));
        $new_orderid = $time . "_" . $data['orderid'];
        $myParams = array(
            "method" => "ysepay.df.single.query",
            "partner_id" => $config['mch_id'],//"jumeihui"
            "timestamp" => date("Y-m-d H:i:s", time()),
            "charset" => "utf-8",
            "sign_type" => "RSA",
            "version" => "3.0",
        );

        $biz_content_arr = array(
            "out_trade_no" => $new_orderid,
            "shopdate" => $time,
        );
        $myParams['biz_content'] = json_encode($biz_content_arr, JSON_UNESCAPED_UNICODE);//构造字符串
        ksort($myParams);
        $signStr = "";
        foreach ($myParams as $key => $val) {
            $signStr .= $key . '=' . $val . '&';
        }
        $signStr = rtrim($signStr, '&');
        $sign = $this->sign_encrypt(array('data' => $signStr));
        $myParams['sign'] = trim($sign['check']);
        $result = curlPost("https://searchdf.ysepay.com/gateway.do", http_build_query($myParams));
        $result = json_decode($result, true);
        //file_put_contents(RUNTIME_PATH . '/Logs/Payment/QuanMaTong_notify.txt', "【" . date('Y-m-d H:i:s') . "】\r\n订单查询结果：" . json_encode($result) . "\r\n\r\n", FILE_APPEND);
        $response = $result[str_replace(".", "_", $myParams["method"]) . "_response"];
        $data = json_encode($response, JSON_UNESCAPED_UNICODE);
        if ($this->sign_check($result['sign'], $data) == true) {
            if ($response['trade_status'] != "TRADE_SUCCESS") {
                $return = ['status' => 3, 'msg' => $response['trade_status_description']];
            } else {
                $return = ['status' => 2, 'msg' => $response['trade_status_description']];
            }
            //file_put_contents(RUNTIME_PATH . '/Logs/Payment/QuanMaTong_notify.txt', "【" . date('Y-m-d H:i:s') . "】\r\n订单查询结果：" . "验证签名成功" . "\r\n\r\n", FILE_APPEND);
        } else {
            $return = ['status' => 3, 'msg' => "验签失败"];
            //file_put_contents(RUNTIME_PATH . '/Logs/Payment/QuanMaTong_notify.txt', "【" . date('Y-m-d H:i:s') . "】\r\n订单查询结果：" . "验证签名失败" . "\r\n\r\n", FILE_APPEND);
        }
        return $return;
    }

    //账户余额查询
    public function queryBalance()
    {
        if (IS_AJAX) {
            $config = M('pay_for_another')->where(['code' => 'YinYingTong'])->find();
            $myParams = array(
                "method" => "ysepay.df.single.quick.accept",
                "partner_id" => $config['mch_id'],//"jumeihui"
                "timestamp" => date("Y-m-d H:i:s", time()),
                "charset" => "utf-8",
                "sign_type" => "RSA",
                "version" => "3.0",
            );
            $biz_content_arr = array(
                "user_code" => $config['mch_id'],
                "user_name" => $config['appid']
            );
            $myParams['biz_content'] = json_encode($biz_content_arr, JSON_UNESCAPED_UNICODE);//构造字符串
            ksort($myParams);
            $signStr = "";
            foreach ($myParams as $key => $val) {
                $signStr .= $key . '=' . $val . '&';
            }
            $signStr = rtrim($signStr, '&');
            $sign = $this->sign_encrypt(array('data' => $signStr));
            $myParams['sign'] = trim($sign['check']);
            dump($myParams);
            $ch = curl_init("https://openapi.ysepay.com/gateway.do");
            curl_setopt($ch, CURLOPT_POST, 1);
            curl_setopt($ch, CURLOPT_POSTFIELDS, http_build_query($myParams));
            curl_setopt($ch, CURLOPT_FOLLOWLOCATION, 1);
            curl_setopt($ch, CURLOPT_HEADER, 0);
            curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
            curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, 0);
            curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, 0);
            $response = curl_exec($ch);
            file_put_contents(RUNTIME_PATH . '/Logs/Payment/QuanMaTong_notify.txt', "【" . date('Y-m-d H:i:s') . "】\r\n余额查询结果：" . json_encode($response) . "\r\n\r\n", FILE_APPEND);
            if (curl_errno($ch)) {
                dump($ch);
            } else {
                $response = json_decode($response, true);
                dump($response);
                $sign = $response['sign'];
                echo $sign;
                $data = json_encode($response['ysepay_online_user_account_get_response'], JSON_UNESCAPED_UNICODE);
                dump($data);
                /* 验证签名 仅作基础验证*/
                if ($this->sign_check($sign, $data) == true) {
                    echo "验证签名成功!";
                } else {
                    echo '验证签名失败!';
                }
            }
        }
    }


    /**
     * 签名加密
     * @param input data
     * @return success
     * @return check
     * @return msg
     */
    function sign_encrypt($input)
    {
        $return = array('success' => 0, 'msg' => '', 'check' => '');
        $pkcs12 = file_get_contents("./cert/ysepay/shanghu.pfx"); //私钥
        if (openssl_pkcs12_read($pkcs12, $certs, $this->password)) {
            //dump('证书,密码,正确读取');
            $privateKey = $certs['pkey'];
            $publicKey = $certs['cert'];
            $signedMsg = "";
            //print_r("加密密钥" . $privateKey);
            if (openssl_sign($input['data'], $signedMsg, $privateKey, OPENSSL_ALGO_SHA1)) {
                //dump('签名正确生成');
                $return['success'] = 1;
                $return['check'] = base64_encode($signedMsg);
                $return['msg'] = base64_encode($input['data']);
            }
        }
        return $return;
    }

    /**
     * 验签转明码
     * @param input check
     * @param input msg
     * @return data
     * @return success
     */
    function sign_check($sign, $data)
    {
        $publickeyFile = "./cert/ysepay/businessgate.cer"; //公钥
        $certificateCAcerContent = file_get_contents($publickeyFile);
        $certificateCApemContent = '-----BEGIN CERTIFICATE-----' . PHP_EOL . chunk_split(base64_encode($certificateCAcerContent), 64, PHP_EOL) . '-----END CERTIFICATE-----' . PHP_EOL;
        //print_r("验签密钥" . $certificateCApemContent);
        // 签名验证
        $success = openssl_verify($data, base64_decode($sign), openssl_get_publickey($certificateCApemContent), OPENSSL_ALGO_SHA1);
        //dump($success);
        return $success;
    }
}
