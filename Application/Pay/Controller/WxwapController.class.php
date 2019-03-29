<?php
namespace Pay\Controller;

use Org\Util\WxH5Pay;

class WxwapController extends PayController
{
    public function __construct()
    {
        parent::__construct();
    }

    public function Pay($array)
    {
        $parameter = array(
            'code' => 'Wxwap', // 通道名称
            'title' => '微信H5支付-官方',
            'exchange' => 100, // 金额比例
            'gateway' => '',
            'orderid' => '',
            'out_trade_id' => I("request.pay_orderid"),
            'body'=>I('request.pay_productname'),
            'channel'=>$array
        );
       
        // 订单号，可以为空，如果为空，由系统统一的生成
        $return = $this->orderadd($parameter);
		if($return) {
            $encryp  = encryptDecrypt(serialize($return), md5(md5(C('DB_PWD'))));
            if($return['unlockdomain']) {
                echo createForm($return['unlockdomain'].'/Pay_Wxwap_Gopay', ['encryp' => $encryp]);
            } else {
                $url = $this->_site . 'Pay_Wxwap_topay_orderid_'.$return["orderid"].'.html';
                echo '<script type="text/javascript">window.location.href="'.$url.'"</script>';
                exit;
            }
		} else {
			$this->showmessage("下单失败");
		}
    }

    public function Gopay() {
        //接收传输的数据
        $postData = I('post.', '');
        $encryp = $postData['encryp'];
        //将数据解密并反序列化
        $data = unserialize(encryptDecrypt($encryp, md5(md5(C('DB_PWD'))), 1));
        if($data['unlockdomain']) {
            $this->_site = $data['unlockdomain'];
        }
        $url = $this->_site . 'Pay_Wxwap_topay_orderid_'.$data["orderid"].'.html';
        echo '<script type="text/javascript">window.location.href="'.$url.'"</script>';
        exit;
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
        $notifyurl = $_SERVER["REQUEST_SCHEME"].'://'.$_SERVER["HTTP_HOST"].'/Pay_Wxwap_notifyurl.html'; //异步通知
        $redirect_uri = $_SERVER["REQUEST_SCHEME"].'://'.$_SERVER["HTTP_HOST"].'/Pay_Wxwap_callbackurl.html?orderid='.$orderid;
        $wxwapPay = new WxH5Pay($order["account"], $order["memberid"], $notifyurl, $order["key"]);
        $params['body'] = "商城订单";                    //商品描述
        $params['out_trade_no'] = $orderid;    //自定义的订单号
        $params['total_fee'] = $order['pay_amount']*100;        //订单金额 只能为整数 单位为分
        $params['trade_type'] = 'MWEB';                  //交易类型 JSAPI | NATIVE | APP | WAP
        $params['scene_info'] = '{"h5_info": {"type":"Wap","wap_url": "h'.$this->site.'","wap_name": "'."商城订单".'"}}';
        $result = $wxwapPay->unifiedOrder( $params );
        $url = $result['mweb_url'].'&redirect_url='.$redirect_uri;
        redirect($url);
        exit();
    }
	
    public function callbackurl()
    {
        $orderid = I('request.orderid', '', 'string,strip_tags,htmlspecialchars');
        $Order = M("Order");
        $pay_status = $Order->where(['pay_orderid' => $orderid])->getField("pay_status");
        if($pay_status == 0) {
            sleep(3);//等待3秒
            $pay_status = M('Order')->where(['pay_orderid' => $orderid])->getField("pay_status");
        }
        if ($pay_status <> 0) {
            $this->EditMoney($orderid, 'Wxwap', 1);
        } else {
            exit('页面已过期请刷新');
        }
    }

    // 服务器点对点返回
    public function notifyurl()
    {
        //file_put_contents('./Data/notify.txt',"【".date('Y-m-d H:i:s')."】\r\n".file_get_contents("php://input")."\r\n\r\n",FILE_APPEND);
        $xml = isset($GLOBALS['HTTP_RAW_POST_DATA'])? $GLOBALS['HTTP_RAW_POST_DATA'] : '';
        if(empty($xml)){
            $xml = file_get_contents('php://input');
        }
        libxml_disable_entity_loader(true);
        $arraystr = json_decode(json_encode(simplexml_load_string($xml, 'SimpleXMLElement', LIBXML_NOCDATA)), true);
        logResult($xml);
        ksort($arraystr);
        $buff = "";
        foreach ($arraystr as $k => $v) {
            if ($k != "sign" && $v != "" && !is_array($v)) {
                $buff .= $k . "=" . $v . "&";
            }
        }
        $buff = trim($buff, "&");
        $pkey = getKey((string)$arraystr["out_trade_no"]);
        $string = $buff . "&key=" . $pkey;
        $string = md5($string);
        $sign = strtoupper($string);
        if ($sign == $arraystr["sign"]) {
            $this->EditMoney((string)$arraystr["out_trade_no"], 'Wxwap', 0);
            exit("success");
        } else {
            echo 'fail!';
        }
    }
}

?>
