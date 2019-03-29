<?php

namespace Pay\Controller;

use Think\Log;

class SifangtwoPayController extends PayController
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
        $data = I('param.');
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

        $order_info = M('order')->where(['out_trade_id' => $orderid])->field('account_id,pay_orderid,pay_callbackurl')->find();
        $account_id = $order_info['account_id'];
        $pay_orderid = $order_info['pay_orderid'];
        $channel_account= M('channel_account')->where(['id' => $account_id])->field('mch_id,signkey')->find();
        $mch_id = $channel_account['mch_id'];
        $return['signkey'] = $channel_account['signkey'];
        //dump($orderid);
        $native = array(
            "pay_memberid" => $mch_id, //商户id
            "pay_orderid" => $pay_orderid,
            "pay_applydate" => $data['pay_applydate'],
            "pay_bankcode" => $data['pay_bankcode'],
            "pay_notifyurl" => "{$site}Pay_{$this->code}_notifyurl.html",
            "pay_callbackurl" => "{$site}Pay_{$this->code}_callbackurl.html",
            "pay_amount" => $return['amount'],
            "key" => $return['signkey'],
        );

        $native['pay_md5sign'] = $this->getSign($native);                //签名
        //拼装json

        $jsonData = array(
            'pay_memberid' => $mch_id,
            'pay_orderid' => $pay_orderid,
            'pay_applydate' => $native['pay_applydate'],
            'pay_bankcode' => $data['pay_bankcode'],
            'pay_notifyurl' => $native['pay_notifyurl'],
            'pay_callbackurl' => $native['pay_callbackurl'],
            'pay_amount' => $native['pay_amount'],
            'pay_md5sign' => $native['pay_md5sign'],
            'pay_productname' => $body,
        );

        $reInfo = $this->post_json_data('http://zyc.bianzhao168.com:8086/Pay_Index.html', $jsonData);
        echo $reInfo;
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
        file_put_contents('./Data/AaAa.txt', "【" . date('Y-m-d H:i:s') . "】\r\n callbackurl信息!" . json_encode(I('param.')) . "\r\n\r\n", FILE_APPEND);
        $pay_orderid = I('param.orderid', '', 'string,strip_tags,htmlspecialchars');
        $pay_status = M("Order")->where(['pay_orderid' => $pay_orderid])->getField("pay_status");
        file_put_contents('./Data/AaAa.txt', "【" . date('Y-m-d H:i:s') . "】\r\n callbackurl信息!" . M("Order")->where(['pay_orderid' => $pay_orderid])->fetchSql()->getField("pay_status") . "\r\n\r\n", FILE_APPEND);
        if ($pay_status != 0) {
            file_put_contents('./Data/AaAa.txt', "【" . date('Y-m-d H:i:s') . "】\r\n callbackurl下发通知!"  . "\r\n\r\n", FILE_APPEND);
            //业务逻辑开始、并下发通知.
            $this->EditMoney($pay_orderid, '', 1);
        } else {
            exit('error');
        }
    }

    //异步通知 参数 orderid为本系统单号，transaction_id为上游单号
    // {"memberid":"10001","orderid":"20190307100109535453","transaction_id":"20190307100109539710",
    //"amount":"0.1000","datetime":"20190307101443","returncode":"00",
    //"sign":"28D3CBDC198D46817A14B357CDE2D169","attach":""}
    public function notifyurl()
    {
        file_put_contents('./Data/AaAa.txt', "【" . date('Y-m-d H:i:s') . "】\r\n notifyurl信息!" . json_encode(I('param.')) . "\r\n\r\n", FILE_APPEND);
        $result = I('param.');
        if (!I("orderid")) return;
        $orderList = M('Order')->where(['pay_orderid' => I("orderid")])->find();
        if (!$orderList) return;
        $returnArray = array( // 返回字段
            "memberid" => I("memberid"), // 商户ID
            "orderid" => I("orderid"), // 订单号
            "amount" => I("amount"), // 交易金额
            "datetime" => I("datetime"), // 交易时间
            "transaction_id" => I("transaction_id"), // 支付流水号
            "returncode" => I("returncode"),
        );
        ksort($returnArray);
        $md5str = "";
        foreach ($returnArray as $key => $val) {
            $md5str = $md5str . $key . "=" . $val . "&";
        }
        $sign = strtoupper(md5($md5str . "key=" . $orderList['key']));
        if ($sign == I("sign")) {
            if ($result["returncode"] == "00") {
                file_put_contents('./Data/AaAa.txt', "【" . date('Y-m-d H:i:s') . "】\r\n 支付成功!" . "\r\n\r\n", FILE_APPEND);
                if (!$orderList['pay_status']) {
                    $this->EditMoney($result['orderid'], '', 0);
                    echo "ok";
                    return;
                }
            } else {
                echo "订单支付失败";
            }
        } else {
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
            'code' => $this->code,
            'title' => '万码HZ代收',
            'exchange' => 1, // 金额比例
            'gateway' => '',
            'orderid' =>'',
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
    function post_json_data($url,$data_string)
    {
        $ch = curl_init();

        curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, FALSE);
        curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, FALSE);

        curl_setopt($ch, CURLOPT_POST, 1);
        curl_setopt($ch, CURLOPT_URL, $url);
        curl_setopt($ch, CURLOPT_POSTFIELDS,$data_string);
//        curl_setopt($ch, CURLOPT_HTTPHEADER, array(
//                'Content-Type: application/json; charset=utf-8',
//                'Content-Length: ' . strlen($data_string))
//        );
        ob_start();
        curl_exec($ch);
        $return_content = ob_get_contents();
        ob_end_clean();
        $return_code = curl_getinfo($ch, CURLINFO_HTTP_CODE);
        return $return_content;
    }

    //下单签名
    function getSign($data)
    {
//        $key = $data['key'];
//        $data = array_filter($data);
//        array_pop($data);
//        ksort($data);
//        $data['key'] = $key;
//        $info = http_build_query($data);
//        return strtoupper(md5($info));
        $stringSignTemp="pay_amount=".$data['pay_amount']."&pay_applydate=".$data['pay_applydate']."&pay_bankcode=".$data['pay_bankcode']."&pay_callbackurl=".$data['pay_callbackurl']."&pay_memberid=".$data['pay_memberid']."&pay_notifyurl=".$data['pay_notifyurl']."&pay_orderid=".$data['pay_orderid']."&key={$data['key']}";
        //echo $stringSignTemp;
        return strtoupper(MD5($stringSignTemp));
    }
}
