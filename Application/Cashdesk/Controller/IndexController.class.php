<?php
namespace Cashdesk\Controller;
use Pay\Controller\PayController;
use Think\Controller;

class IndexController extends PayController {

    public function index(){
        $pay_way = M('payment_product')->select();
        foreach ($pay_way as $k => $v){
            $channelId = M('channel')->where(['payment_product_id'=>$v['id']])->field('id')->find();
            $pay_way[$k]['channel'] = $channelId['id'];
        }
        $product = M('product')->select();
        $this->assign('product',$product);
        $this->assign('info',$pay_way);
        $this->display();
    }

    public function pay(){
        if (IS_POST) {
            $param = I('post.');
            $strData = explode('|',$param['pay_bankcode']);
            $bankcode = $strData[0];
            $channel = $strData[1];
            $str = date('YmdHis').substr(implode(NULL, array_map('ord', str_split(substr(uniqid('',true), 7, 17), 1))), 0, 6);
            //创建订单
            $native = array(
                "pay_memberid" => 10137, //商户id
                'pay_orderid'=>$str,
                'pay_applydate'=> date("Y-m-d h:i:sa",time()),
                "pay_bankcode" =>$bankcode,
                "pay_notifyurl" => "http://boom.haohan168.cn:8086/cashdesk_Index_notifyurl.html",
                "pay_callbackurl" => 'http://boom.haohan168.cn:8086/cashdesk_Index_callbackurl.html',
                "pay_amount" => $param['pay_amount'],
                "key" => "gx8zumqtnv4qol0cxg82sb1r73zeintl",
            );
            $native['pay_md5sign'] = $this->getSign($native);                //签名

            $jsonData = array(
                "pay_memberid" => 10137, //商户id
                'pay_orderid'=>$str,
                'pay_applydate'=> date("Y-m-d h:i:sa",time()),
                "pay_bankcode" => $bankcode,
                "pay_notifyurl" => "http://boom.haohan168.cn:8086/cashdesk_Index_notifyurl.html",
                "pay_callbackurl" => 'http://boom.haohan168.cn:8086/cashdesk_Index_callbackurl.html',
                "pay_amount" => $param['pay_amount'],
                "pay_channel" => $channel,
                'pay_md5sign' => $native['pay_md5sign'],
                'pay_channel' => $channel,
                'pay_productname' => $param['pay_amount'].'元套餐',
            );
            $res = $this->post_json_data("http://boom.haohan168.cn:8086/Pay_Index.html",$jsonData);
            //$res = $this->post_json_data("http://boom.haohan168.cn:8086/Cashdesk_CashPay.html",$jsonData);
            echo $res;
        }



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



    function getSign($data)
    {
        $stringSignTemp="pay_amount=".$data['pay_amount']."&pay_applydate=".$data['pay_applydate']."&pay_bankcode=".$data['pay_bankcode']."&pay_callbackurl=".$data['pay_callbackurl']."&pay_memberid=".$data['pay_memberid']."&pay_notifyurl=".$data['pay_notifyurl']."&pay_orderid=".$data['pay_orderid']."&key={$data['key']}";
        return strtoupper(MD5($stringSignTemp));
    }


    public function callbackurl()
    {
        $post = I('post.');
        $orderid = I('post.transaction_id', '', 'string,strip_tags,htmlspecialchars');//系统订单号
        $Order = M("Order");
        $pay_status = $Order->where(['pay_orderid' => $orderid])->getField("pay_status");
        $returncode = $post['returncode'];
        if ($returncode == '00'){
            $this->assign('info',$post);
            $this->display('Index/pay');
        }
        if ($pay_status <> 0) {
            //业务逻辑开始、并下发通知.
            //$this->EditMoney($orderid, '', 1);
        } else {
            exit('error');
        }
    }


    //异步通知
    public function notifyurl()
    {
        $param = I('param.');
        if ($param['returncode'] == '00') {
            echo 'ok';
            return;
        } else {
            exit('error');
        }
    }
}