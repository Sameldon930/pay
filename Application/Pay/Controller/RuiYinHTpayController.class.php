<?php
/**
 * RuiYinwh5pay 微信支付宝免签收款
 */

namespace Pay\Controller;

use Think\Log;

class RuiYinHTpayController extends PayController
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
        //跳转页面，优先取数据库中的跳转页面
        $site = trim($return['unlockdomain']) ? $return['unlockdomain'] . '/' : $this->_site;
        $deskur="{$site}Pay_{$this->code}_cashierDesk.html?page=ruiyin&id=".$return['orderid'];

        $returnPara = array(
            "url" => $deskur, //商户uid
        );
        $this->showSuccess("成功",$returnPara);

    }
    public function secondCheck()
    {
        $getData = I('get.', '');
        $order_info = M('order')->where(['pay_orderid' => $getData['id']])->find();
        $native = array(
            "merchant_no" => M("channel_account")->where(["id"=>$order_info['account_id']])->getField("mch_id"), //商户号
            "pay_num" => $order_info['pay_orderid'],   //商户订单号
            "total_fee" => sprintf("%.2f",$order_info['pay_amount']), //金额
            "product_name" => $order_info['pay_productname']||"VIP购买", //商品名称
            "product_body" => $order_info['pay_productname']||"VIP购买",  //商品描述
            "pay_method" => "qh5pay",  //支付方式
            "clentip" => get_client_ip(),  //商户用户名
            "merchant_userid" => $order_info['pay_memberid'],  //商户用户名
            "return_url" => $order_info['pay_callbackurl'],  //同步通知地址
            "notify_url" => $order_info['pay_notifyurl'],  //异步通知地址
        );
        file_put_contents( './Data/RuiYinwh5_callback.txt', "第二次下单参数【" . json_encode($native) . "】\r\n \r\n\r\n", FILE_APPEND);
        $native['sign'] = strtoupper(MD5($native['merchant_no'] . $native['total_fee'] . date("Ymd", time()) . $order_info["key"]));                //签名
        $this->setHtml("http://pay.dblhchina.com/api/createorder_ht",$native);
    }

    public function check()
    {
        //接收传输的数据
        $getData = I('get.', '');
        $pay_info = M("Order")->where(array('pay_orderid' =>$getData['id']))->field('pay_status,pay_applydate')->find();
        //file_put_contents('./Data/FSAliPay.txt', "【" . date('Y-m-d H:i:s') . "】\r\修改金额后!" . json_encode($pay_info) . "\r\n\r\n", FILE_APPEND);
        $ctime = $pay_info['pay_applydate'];
        //file_put_contents('./Data/FSAliPay.txt', "【" . date('Y-m-d H:i:s') . "】\r\进入---订单状态-" . $pay_info['pay_status']  . "\r\n\r\n", FILE_APPEND);
        if((time() - $ctime)>300){
            $this->ajaxreturn(array('code' =>-1, 'msg'=>'订单已经过时了'));

        }
        if ( $pay_info['pay_status'] == 0) {
            $this->ajaxreturn(array('code' =>100, 'msg'=>'等待支付'));

        } else  {
            $this->ajaxreturn(array('code' =>200, 'msg'=>'订单已经支付过了'));
        }
    }


    //同步通知
    public function callbackurl()
    {
        file_put_contents( './Data/RuiYinwh5_callback.txt', "【" . date('Y-m-d H:i:s') . "】\r\n 同步回调参数" . json_encode(I('param.')) . "\r\n\r\n", FILE_APPEND);
        $out_trade_no = I('param.orderid', '', 'string,strip_tags,htmlspecialchars');
        $Order = M("Order");
        $pay_status = $Order->where(['pay_orderid' => $out_trade_no])->getField("pay_status");
        if ($pay_status <> 0) {
            //业务逻辑开始、并下发通知.
            $this->EditMoney($out_trade_no, $this->code, 1);
        } else {
            exit('error');
        }
    }

    //异步通知
    public function notifyurl()
    {
        file_put_contents( './Data/RuiYinwh5_callback.txt', "【" . date('Y-m-d H:i:s') . "】\r\n 异步回调参数" . json_encode(I('param.')) . "\r\n\r\n", FILE_APPEND);
        $result = I("param.");
        if (!$result['pay_num']) return;
        $orderList = M('Order')->where(['pay_orderid' => $result['pay_num']])->find();
        if (!$orderList) return;
        $sign = strtoupper(MD5($result['merchant_no'] . $result['pay_num'] . $result['pay_amount'] . date("Ymd", time()) . $orderList["key"]));
        file_put_contents( './Data/RuiYinwh5_callback.txt', "【" . date('Y-m-d H:i:s') . "】\r\n 我的签名" . $sign . "\r\n\r\n", FILE_APPEND);
        if ($sign == $result["sign"]) {
            file_put_contents( './Data/RuiYinwh5_callback.txt', "【" . date('Y-m-d H:i:s') . "】\r\n 签名成功" .  "\r\n\r\n", FILE_APPEND);
            if ($result['pay_result'] == 1) {
                $this->EditMoney($result['pay_num'], $this->code, 0);
                echo "success";
                return;
            }
        } else {
            echo "签名错误!" ;
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
            'title' => '瑞银HT快捷支付',
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

}
