<?php


namespace Pay\Controller;

class TonglianWxSmController extends PayController
{

    private $gateway = 'https://vsp.allinpay.com/apiweb/unitorder';

    /**
     *  发起支付
     */
    public function Pay($array)
    {
        $orderid = I("request.pay_orderid");
        $body = I('request.pay_productname');
        $notifyurl = $this->_site ."Pay_TonglianWxSm_notifyurl.html"; //异步通知

        $parameter = array(
            'code' => 'TonglianWxSm',
            'title' => '通联（微信扫码）',
            'exchange' => 100, // 金额比例
            'gateway' => '',
            'orderid'=>'',
            'out_trade_id' => $orderid, //外部订单号
            'channel'=>$array,
            'body'=>$body
        );

        // 订单号，可以为空，如果为空，由系统统一的生成
        $return = $this->orderadd($parameter);
        $params = array();
        $params["cusid"] = $return['mch_id'];
        $params["appid"] = $return['appid'];
        $params["version"] = '11';
        $params["trxamt"] = $return['amount'];
        $params["reqsn"] = $return['orderid'];//订单号,自行生成
        $params["paytype"] = "W01";
        $params["randomstr"] = $this->random_str();
        $params["body"] = $body;
        $params["remark"] = $body;
        $params["acct"] = "";
        $params["limit_pay"] = "no_credit";
        $params["notify_url"] = $notifyurl;
        $params["sign"] = $this->SignArray($params, $return['signkey']);//签名
        $paramsStr = $this->ToUrlParams($params);
        $url = $this->gateway . "/pay";
        $rsp = $this->request($url, $paramsStr);
        $rspArray = json_decode($rsp, true);
        if($rspArray['retcode'] == 'SUCCESS') {
            if($this->validSign($rspArray, $return['signkey'])){
                if($rspArray['trxstatus'] == '0000') {
                    $return['amount']/=100;
                    $this->showQRcode($rspArray['payinfo'], $return, 'weixin');
                } else {
                    $this->showmessage($rspArray['errmsg']);
                }
            } else {
                $this->showmessage('验签失败');
            }
        } else {
            $this->showmessage($rspArray['retmsg']);
        }
    }

    /**
     * 页面通知
     */
    public function callbackurl()
    {
        $Order      = M("Order");
        $orderid    = I('request.orderid', '', 'string,strip_tags,htmlspecialchars');
        if(!$orderid) {
            exit('error');
        }
        $pay_status = $Order->where(['pay_orderid' => $orderid])->getField("pay_status");
        if($pay_status == 0)
        {
            sleep(3);//等待3秒
            $pay_status = M('Order')->where(['pay_orderid' => $orderid])->getField("pay_status");
        }
        if($pay_status <> 0)
        {
            $this->EditMoney($orderid, '', 1);
        }
        else
        {
            exit('页面已过期请刷新');
        }
    }

    /**
     *  服务器通知
     */
    public function notifyurl()
    {
        file_put_contents('./Data/notify.txt', "【".date('Y-m-d H:i:s')."】\r\n".file_get_contents("php://input")."\r\n\r\n",FILE_APPEND);
        $params = array();
        foreach($_POST as $key=>$val) {
            $params[$key] = $val;
        }
        if(count($params)<1){//如果参数为空,则不进行处理
            echo "error";
            exit();
        }
        if($params['cusorderid']) {
            $key = getKey($params['cusorderid']);
            if($key) {
                if($this->ValidSign($params, $key)){//验签成功
                    $this->EditMoney($params['cusorderid'], 'TonglianAliSm', 0);
                    echo "success";
                }
                else{
                    echo "erro";
                }
            } else {
                echo "erro";
            }
        } else {
            echo "erro";
        }
    }

    private function SignArray(array $array,$appkey){
        $array['key'] = $appkey;// 将key放到数组中一起进行排序和组装
        ksort($array);
        $blankStr = $this->ToUrlParams($array);
        $sign = md5($blankStr);
        return $sign;
    }

    private function ToUrlParams(array $array)
    {
        $buff = "";
        foreach ($array as $k => $v)
        {
            if($v != "" && !is_array($v)){
                $buff .= $k . "=" . $v . "&";
            }
        }

        $buff = trim($buff, "&");
        return $buff;
    }

    /**
     * 校验签名
     * @param array 参数
     * @param unknown_type appkey
     */
    private function ValidSign(array $array,$appkey){
        $sign = $array['sign'];
        unset($array['sign']);
        $array['key'] = $appkey;
        $mySign = $this->SignArray($array, $appkey);
        return strtolower($sign) == strtolower($mySign);
    }

    //发送请求操作
    private function request($url,$params){
        $ch = curl_init();
        $this_header = array("content-type: application/x-www-form-urlencoded;charset=UTF-8");
        curl_setopt($ch,CURLOPT_HTTPHEADER,$this_header);
        curl_setopt($ch, CURLOPT_URL, $url);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
        curl_setopt($ch, CURLOPT_USERAGENT, 'Mozilla/5.0 (compatible; MSIE 5.01; Windows NT 5.0)');
        curl_setopt($ch, CURLOPT_TIMEOUT, 30);

        curl_setopt($ch, CURLOPT_POST, 1);
        curl_setopt($ch, CURLOPT_POSTFIELDS, $params);
        curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, FALSE);//如果不加验证,就设false,商户自行处理
        curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, FALSE);

        $output = curl_exec($ch);
        curl_close($ch);
        return  $output;
    }

    /**
     * 生成随机字符串
     */
    private function random_str($length = 32)
    {
        $chars = "abcdefghijklmnopqrstuvwxyz0123456789";
        $str ="";
        for ( $i = 0; $i < $length; $i++ ){
            $str.= substr($chars, mt_rand(0, strlen($chars)-1), 1);
        }
        return $str;
    }
}
