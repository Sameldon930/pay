<?php
namespace Pay\Controller;

use Think\Log;

class JiPayController extends PayController
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
        //$return["notifyurl"] || $return["notifyurl"] = "{$site}Pay_{$this->code}_notifyurl.html";
        //$return['callbackurl'] || $return['callbackurl'] = "{$site}Pay_{$this->code}_callbackurl.html";
        $return["notifyurl"]  = $this->_apiSite."Pay_{$this->code}_notifyurl.html";
        $return['callbackurl']  = $this->_apiSite."Pay_{$this->code}_callbackurl.html";

        $native = array(
            "channel" => 8, //金额
            "money" => intval($return['amount'] * 100), //金额
            "shop_id" => $return['mch_id'], //商户uid
            "trade_no" => $return['orderid'],  //商户自定义订单号
            "tzurl" => urlencode($return["notifyurl"]), //通知回调网址
            "token" => $return['signkey'], //秘钥
        );
        $native['sign'] = $this->ZFBS1Sign($native);                //签名
        file_put_contents('./Data/Jipay.txt', "【" . date('Y-m-d H:i:s') . "】\r\n下单密钥：" . json_encode($native) . "\r\n\r\n", FILE_APPEND);


        $url='http://cpay.jipay.club/indexH5?money='.$native['money'] .'&channel='. $native['channel'].'&shop_id='. $native['shop_id'].'&trade_no='. $native['trade_no'] .'&tzurl='. $native['tzurl'] .'&sign='. $native['sign'];
        file_put_contents('./Data/Jipay.txt', "【" . date('Y-m-d H:i:s') . "】\r\n下单地址：" . $url . "\r\n\r\n", FILE_APPEND);

        $reInfo = json_decode(file_get_contents($url),true);
        file_put_contents('./Data/Jipay.txt', "【" . date('Y-m-d H:i:s') . "】\r\n返回的二维码地址：" . json_encode($reInfo) . "\r\n\r\n", FILE_APPEND);

        $result = $reInfo['data'];//返回中的二维数组键值data中有url键

        if ($reInfo['status'] === 1) {
//            header('Location: '.$result['url']);
            $returnPara = array(
                "url" => $result['url'], //商户uid
            );
            $this->showSuccess("成功",$returnPara);
        }else{
            echo '系统繁忙';
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
        file_put_contents('./Data/Jipay.txt', "【" . date('Y-m-d H:i:s') . "】\r\n" . json_encode($_REQUEST) . "\r\n\r\n", FILE_APPEND);
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
        $res = file_get_contents("php://input");
        file_put_contents('./Data/Jipay.txt', "【" . date('Y-m-d H:i:s') . "】\r\n收到回调通知参数1：" . json_encode($res) . "\r\n\r\n", FILE_APPEND);
        $param = explode("&",$res);
        foreach($param as $key =>$val){
            $tmp = explode("=",$val);
            $array[$tmp[0]] = $tmp[1] ;
        }

        file_put_contents('./Data/Jipay.txt', "【" . date('Y-m-d H:i:s') . "】\r\n收到回调通知参数2：" . $array['trade_no'] . "\r\n\r\n", FILE_APPEND);
        if (!$array['trade_no']) return;
        $orderList = M('Order')->where(['pay_orderid' => $array['trade_no']])->find();

        if (!$orderList) return;
        $res_str = "channel=" . $array["channel"] .
            "&create_time=" . urldecode($array['create_time']) .
            "&end_time=" . urldecode($array["end_time"]) .
            "&mark_buy=" . $array["mark_buy"] .
            "&mark_sell=" . $array["mark_sell"] .
            "&money=" . $array["money"] .
            "&orderid=" . $array["orderid"] .
            "&pay_money=" . $array["pay_money"] .
            "&shop_id=" . $array["shop_id"] .
            "&status=" . $array["status"] .
            "&trade_no=" . $array["trade_no"] .
            "&token=" . $orderList['key'];
        file_put_contents('./Data/Jipay.txt', "【" . date('Y-m-d H:i:s') . "】\r\n接收到的字符串组织：" . $res_str . "\r\n\r\n", FILE_APPEND);

        $sign = md5($res_str);
        file_put_contents('./Data/Jipay.txt', "【" . date('Y-m-d H:i:s') . "】\r\nmd加密：" . $sign  . "\r\n\r\n", FILE_APPEND);

        if ($sign == $array["sign"]) {
            file_put_contents('./Data/Jipay.txt', "【" . date('Y-m-d H:i:s') . "】\r\n判断签名1：" . $sign . "\r\n\r\n", FILE_APPEND);
            file_put_contents('./Data/Jipay.txt', "【" . date('Y-m-d H:i:s') . "】\r\n判断签名2：" . $array["sign"] . "\r\n\r\n", FILE_APPEND);

            if ($array['status'] == 1) {
                file_put_contents('./Data/Jipay.txt', "【" . date('Y-m-d H:i:s') . "】\r\n收到回调的状态：" . $array['status'] . "\r\n\r\n", FILE_APPEND);

                $this->EditMoney($array['trade_no'], 'JiPay', 0);
                $back = array(
                    'code'=>'1',
                    'msg'=>'ok'
                );
                $json_back = json_encode($back);
                echo $json_back;
                die;
            }
        } else {
            echo "签名错误！  " . $res;
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
            'code' => 'JiPay',
            'title' => 'JiPay代收',
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
        $str = 'channel=' . $dat['channel'] . '&money=' . $dat['money'] . '&shop_id=' . $dat['shop_id'] . '&trade_no=' . $dat['trade_no'] . '&tzurl=' . $dat['tzurl'] .'&token=' . $dat['token'];
        file_put_contents('./Data/Jipay.txt', "【" . date('Y-m-d H:i:s') . "】\r\n下单报文：" . strtolower($str) . "\r\n\r\n", FILE_APPEND);
        return md5(strtolower($str));
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


}
