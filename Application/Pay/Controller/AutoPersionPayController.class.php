<?php
namespace Pay\Controller;

use Think\Log;

class AutoPersionPayController extends PayController
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
      	//$mark = I('request.pay_attach', '');

      	//=================== 验证BC账号是否上传  开始 ==========================
      	/*if (empty($mark) ) {
            $this->showmessage("缺少必要参数!");
        }*/
		//=================== 验证BC账号是否上传  开始 ==========================
      
        //创建订单
        $return = $this->creatorder($array, $orderid, $body);
        //如果生成错误，自动跳转错误页面
        $return["status"] == "error" && $this->showmessage($return["errorcontent"]);
        //跳转页面，优先取数据库中的跳转页面
        $site = trim($return['unlockdomain']) ? $return['unlockdomain'] . '/' : $this->_site;
        $gateway = "{$site}Pay_{$this->code}_Rpay.html";
        $return["notifyurl"] || $return["notifyurl"] = "{$site}Pay_{$this->code}_notifyurl.html";
        $return['callbackurl'] || $return['callbackurl'] = "{$site}Pay_{$this->code}_callbackurl.html";
file_put_contents('./Data/AutoPersionPay.txt', "【" . date('Y-m-d H:i:s') . "】\r\四方1!" . json_encode($return) . "\r\n\r\n", FILE_APPEND);
        $native = array(
            "uid" => $return['mch_id'], //商户uid
            "nonceStr" => time(),   //随机字符串
            "price" => intval($return['amount'] * 100), //金额
            "type" => "alipay", //支付渠道
            "notifyUrl" => $return["notifyurl"], //通知回调网址
            "outTradeNo" => $return['orderid'],  //商户自定义订单号
            "orderuid" => $memberid,       //商户自定义客户号
            "state" => 8,       //商户自定义客户号
            "key" => $return['signkey'], //秘钥
        );
        $native['sign'] = $this->ZFBS1Sign($native);                //签名
        //拼装json
        $jsonData = '{
            "uid" : "' . $native['uid'] . '",
            "nonceStr" : "' . $native['nonceStr'] . '",
            "price" : "' . $native['price'] . '",
            "type" : "' . $native['type'] . '",
            "notifyUrl" : "' . $native['notifyUrl'] . '",
            "outTradeNo" : "' . $native['outTradeNo'] . '",
            "state" : "' . $native['state'] . '",
            "sign" : "' . $native['sign'] . '",
        }';
	
        $reInfo = json_decode($this->post_json_data('http://biu.haohan168.cn/order/api/pay', $jsonData), true);
       //$reInfo = json_decode($this->post_json_data('http://wanma.haohan168.cn:8080/order/api/pay', $jsonData), true);
        file_put_contents('./Data/AutoPersionPay.txt', "【" . date('Y-m-d H:i:s') . "】\r\转账下单返回参数1!" . json_encode($reInfo) . "\r\n\r\n", FILE_APPEND);
        if ($reInfo['errCode'] === 0) {
            $result = json_decode($reInfo['data'], true);
            $qrcodeUrl=$result['qrcodeUrl'];
            $price= $result['price'] / 100;
            $checkurl     = "{$site}Pay_{$this->code}_Check.html?id=".$return['orderid'];
            $callbackUrl = "{$site}Pay_{$this->code}_callbackurl.html?orderid=".$return['orderid'];
            
          	$url= "{$site}Pay_{$this->code}_secondPage.html?url=".urlencode($result['qrcodeUrl'])."&id=".$return['orderid']."&mark=".$result['mark'];
          	$btnUrl="alipayqr://platformapi/startapp?saId=10000007&qrcode=".urlencode($url);
            $this->assign([
                'callbackUrl'   =>$callbackUrl,
                'orderid'    => $return['orderid'],
                'checkurl'  => $checkurl,//查单
              	'btnUrl' => $btnUrl,//触发按钮
                'url'       =>urlencode($url),//第二个页面
            ]);
            $this->display('AliNewpay/firpersion');
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
        file_put_contents('./Data/AutoPersionPay.txt', "【" . date('Y-m-d H:i:s') . "】\r\n-----" . json_encode($_REQUEST) . "\r\n\r\n", FILE_APPEND);
        $out_trade_no = I('get.orderid', '', 'string,strip_tags,htmlspecialchars');
        file_put_contents('./Data/AutoPersionPay.txt', "【" . date('Y-m-d H:i:s') . "】\r\n-----" . $out_trade_no . "\r\n\r\n", FILE_APPEND);
        //$Order = M("Order");
        $pay_status = M("Order")->where(['pay_orderid' => $out_trade_no])->getField("pay_status");
        file_put_contents('./Data/AutoPersionPay.txt', "【" . date('Y-m-d H:i:s') . "】\r\n-----" . $pay_status . "\r\n\r\n", FILE_APPEND);
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
        $result = json_decode($res, true);
        if (!$result['outTradeNo']) return;
        $orderList = M('Order')->where(['pay_orderid' => $result['outTradeNo']])->find();
        if (!$orderList) return;
        $res_str = "nonceStr=" . $result["nonceStr"] . "&outTradeNo=" . $result['outTradeNo'] . "&payState=" . $result["payState"] . "&payTime=" . $result["payTime"] . "&price=" . $result["price"] . "&type=" . $result["type"] . "&uid=" . $result["uid"] . "&key=" . $orderList['key'];

        $sign = md5($res_str);
        if ($sign == $result["sign"]) {
            if ($result['payState'] == "SUCCESS") {
              $this->edit_order($result['outTradeNo'], $result['price'] / 100);
                $this->EditMoney($result['outTradeNo'], 'AutoPersionPay', 0);
                echo "SUCCESS";
                return;
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
            'code' => 'AutoPersionPay',
            'title' => '自定义个码代收',
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

        $str = 'nonceStr=' . $dat['nonceStr'] . '&notifyUrl=' . $dat['notifyUrl'] . '&outTradeNo=' . $dat['outTradeNo'] . '&price=' . $dat['price'] .'&state=' . $dat['state'] . '&type=' . $dat['type'] . '&uid=' . $dat['uid'] . '&key=' . $dat['key'];
        return md5($str);
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
     * 修改订单
     * @param $orderid  用户id
     * @param $price    实际支付金额
     */
    private function edit_order($orderid, $price)
    {
        $Order = M("Order");
        $order_info = $Order->where(['pay_orderid' => $orderid])->find(); //获取订单信息
        if (!$order_info || $order_info['pay_amount'] == $price) return;

        $userid = intval($order_info['pay_memberid']) - 10000;

        //费率
        $_userrate = M('Userrate')
            ->where(["userid" => $userid, "payapiid" => intval($order_info['pay_bankcode'])])
            ->find();
        //支付产品费率
        $product = M('Product')
            ->where(['id' => intval($order_info['pay_bankcode'])])
            ->find();

        //提款设置
        $m_Tikuanconfig = M('Tikuanconfig');
        $tikuanconfig = $m_Tikuanconfig->where(['userid' => $userid])->find();
        if (!$tikuanconfig || $tikuanconfig['tkzt'] != 1 || $tikuanconfig['systemxz'] != 1) {
            $tikuanconfig = $m_Tikuanconfig->where(['issystem' => 1])->find();
        }

        if ($tikuanconfig['t1zt'] == 0) { //T+0费率
            $feilv = $_userrate['t0feilv'] ? $_userrate['t0feilv'] : $product['t0defaultrate']; // 交易费率
            $fengding = $_userrate['t0fengding'] ? $_userrate['t0fengding'] : $product['t0fengding']; // 封顶手续费
        } else { //T+1费率
            $feilv = $_userrate['feilv'] ? $_userrate['feilv'] : $product['defaultrate']; // 交易费率
            $fengding = $_userrate['fengding'] ? $_userrate['fengding'] : $product['fengding']; // 封顶手续费
        }
        $fengding = $fengding == 0 ? 9999999 : $fengding; //如果没有设置封顶手续费自动设置为一个足够大的数字

        //金额格式化
        $pay_amount = $price;
        $pay_sxfamount = (($pay_amount * $feilv) > ($pay_amount * $fengding)) ? ($pay_amount * $fengding) : ($pay_amount * $feilv); // 手续费
        $pay_shijiamount = $pay_amount - $pay_sxfamount; // 实际到账金额

        //修改订单金额
        $data = [
            'pay_amount' => $pay_amount, // 交易金额
            'pay_poundage' => $pay_sxfamount, // 手续费
            'pay_actualamount' => $pay_shijiamount, // 到账金额
            'id' => $order_info['id'],
            'pay_orderid' => $order_info["pay_orderid"],
        ];
        $Order->save($data);
    }
    /**
     * 订单支付状态查询
     */
    public function check()
    {
        //接收传输的数据
        $getData = I('get.', '');
        //将数据解密并反序列化
        /*$mysing=md5('wmzf'.$getData['id'].'wmzf');
        if ($getData['sign'] !=  $mysing) {
          $this->ajaxreturn(array('code' =>00, 'msg'=>'签名错误!'));
          exit();
        }*/
        //file_put_contents('./Data/AutoPersionPay.txt', "【" . date('Y-m-d H:i:s') . "】\r\转账下单返回参数!" . $getData['id'] . "\r\n\r\n", FILE_APPEND);
        $pay_info = M("Order")->where(array('pay_orderid' =>$getData['id']))->field("pay_status")->find();
        //file_put_contents('./Data/AutoPersionPay.txt', "【" . date('Y-m-d H:i:s') . "】\r\转账下单返回参数!" . json_encode($pay_info) . "\r\n\r\n", FILE_APPEND);
        if ( $pay_info['pay_status'] == 0) {
            $this->ajaxreturn(array('code' =>100, 'msg'=>'等待支付'));
        } else {
            $this->ajaxreturn(array('code' =>200, 'msg'=>'订单已经支付过了'));
        }
    }

  
  	/**
     * 扫码后查单
     */
    public function secondPage()
    {
        //接收传输的数据
        $getData = I('get.', '');
        $mark=$getData['mark'];//收款人
      	$qrcodeUrl=$getData['url'];//收款码
   		$callbackUrl = $this->_site."Pay_{$this->code}_callbackurl.html?orderid=".$getData['id'];
       $checkurl     = "{$site}Pay_{$this->code}_Check.html?id=".$getData['id'];
        $pay_info = M("Order")->where(array('pay_orderid' =>$getData['id']))->field('pay_status,pay_applydate')->find();
        if ( $pay_info['pay_status'] == 0) {
            file_put_contents('./Data/AutoPersionPay.txt', "【" . date('Y-m-d H:i:s') . "】\r\进入等待支付页面!" . $getData['id'] . "\r\n\r\n", FILE_APPEND);
           $this->assign([
                'callbackUrl'   =>$callbackUrl,
             	'mark'   =>$mark,
                'orderid'    => $getData['id'],
                'checkurl'  => $checkurl,//查单
              	 'btnUrl'       =>"alipayqr://platformapi/startapp?saId=10000007&qrcode=".urlencode($qrcodeUrl),//点击
                'url'       =>$qrcodeUrl,
            ]);
            $this->display('AliNewpay/secpersionnew');
        } else  {
            file_put_contents('./Data/AutoPersionPay.txt', "【" . date('Y-m-d H:i:s') . "】\r\进入反复扫码!" . $getData['id'] . "\r\n\r\n", FILE_APPEND);
            header('Location: '.$callbackUrl);
        }
    }
  
}
