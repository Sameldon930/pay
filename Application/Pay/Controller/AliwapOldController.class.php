<?php
/**
 * Created by PhpStorm.
 * User: mapeijian
 * Date: 2018-05-31
 * Time: 10:19
 */
namespace Pay\Controller;


class AliwapOldController extends PayController
{
    public function __construct()
    {
        parent::__construct();
    }

    //支付
    public function Pay($array)
    {
        $orderid = I("request.pay_orderid");
        $body = I('request.pay_productname');
        $parameter = [
            'code' => 'AliwapOld', // 通道名称
            'title' => '支付宝官方（老版WAP）',
            'exchange' => 1, // 金额比例
            'gateway' => '',
            'orderid' => '',
            'out_trade_id' => $orderid,
            'body'=>$body,
            'channel'=>$array
        ];
        // 订单号，可以为空，如果为空，由系统统一的生成
        $return = $this->orderadd($parameter);
        if($return) {
            $url = $this->_site . 'Pay_AliwapOld_topay_orderid_'.$return["orderid"].'.html';
            echo '<script type="text/javascript">window.location.href="'.$url.'"</script>';
            exit;
        } else {
            $this->showmessage("下单失败");
        }
    }

    public function topay() {
        $orderid = $_REQUEST["orderid"];
        if(!$orderid) {
            $this->showmessage("参数错误");
        }
        $order = M('order')->where(array('pay_orderid'=>$orderid))->find();
        if(empty($order)) {
            $this->showmessage("订单不存在");
        }
        if($order['pay_status'] != 0) {
            $this->showmessage("订单已支付");
        }
        $notifyurl = $this->_site . 'Pay_AliwapOld_notifyurl.html'; //异步通知
        $callbackurl = $this->_site . 'Pay_AliwapOld_callbackurl.html'; //返回通知

        //---------------------引入支付宝第三方类-----------------
        Vendor("AlipayOld.Alipay#class");
        $config = array(
            // 即时到账方式
            'payment_type' => 1,
            // 传输协议
            'transport' => 'http',
            // 编码方式
            'input_charset' => 'utf-8',
            // 签名方法
            'sign_type' => 'MD5',
            // 支付完成异步通知调用地址
            'notify_url' => $notifyurl,
            // 支付完成同步返回地址
            'return_url' => $callbackurl,
            // 证书路径
            'cacert' => '',
            // 支付宝商家 ID
            'partner' => $order['memberid'],
            // 支付宝商家 KEY
            'key' => $order['key'],
            // 支付宝商家注册邮箱
            'seller_email' => $order['account']
        );
        $alipay = new \Alipay($config, TRUE);

        $params = $alipay->prepareMobileTradeData(array(
            'out_trade_no' => $orderid,
            'subject' => $orderid,
            'body' => $orderid,
            'total_fee' => $order['pay_amount'],
            'merchant_url' => $callbackurl,
            'req_id' => date('Ymdhis').mt_rand(1000,9999)
        ));

        // 移动网页版接口只支持 GET 方式提交
        $url = $alipay->buildRequestFormHTML($params, 'get');
        $this->assign("url", $url);
        $this->display('AliwapOld/pay');
    }

    //同步通知
    public function callbackurl()
    {
        $response = $_GET;
        $Order = M("Order");
        $pay_status = $Order->where(['pay_orderid' => $response['out_trade_no']])->getField("pay_status");
        if ($pay_status <> 0) {
            //业务逻辑开始、并下发通知.
            $this->EditMoney($response['out_trade_no'], '', 1);
        }else{
            exit('error');
        }
    }

    //异步通知
    public function notifyurl()
    {
        $response = $this->simplest_xml_to_array($_POST['notify_data']);
        if(!isset($response['out_trade_no']) || !$response['out_trade_no']) {
            exit('fail');
        }
        $order = M('Order')->where(['pay_orderid' => $response['out_trade_no']])->find();
        if(empty($order)) {
            exit('fail');
        }
        Vendor("AlipayOld.Alipay#class");
        $config = array(
            // 即时到账方式
            'payment_type' => 1,
            // 传输协议
            'transport' => 'http',
            // 编码方式
            'input_charset' => 'utf-8',
            // 签名方法
            'sign_type' => 'MD5',
            // 支付完成异步通知调用地址
            'notify_url' => $this->_site . 'Pay_AliwapOld_notifyurl.html',
            // 支付完成同步返回地址
            'return_url' => $this->_site . 'Pay_AliwapOld_callbackurl.html',
            // 证书路径
            'cacert' => '',
            // 支付宝商家 ID
            'partner' => $order['memberid'],
            // 支付宝商家 KEY
            'key' => $order['key'],
            // 支付宝商家注册邮箱
            'seller_email' => $order['account']
        );
        //计算得出通知验证结果
        $alipay = new \Alipay($config, TRUE);
        $verify_result = $alipay->verifyCallback(TRUE);

        if ($verify_result) {
           if ($response['trade_status'] == 'TRADE_SUCCESS') {
               $this->EditMoney($response['out_trade_no'], 'AliwapOld', 0);
               exit("success");
            } else {
               exit("fail");
           }
        } else {
            exit("error:check sign Fail!");

        }
    }

    private function simplest_xml_to_array($xmlstring)
    {
        return json_decode(json_encode((array)simplexml_load_string($xmlstring)), true);
    }
}