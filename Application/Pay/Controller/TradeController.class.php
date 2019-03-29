<?php
/**
 * Created by PhpStorm.
 * User: gaoxi
 * Date: 2017-10-30
 * Time: 21:24
 */
namespace Pay\Controller;

class TradeController extends PayController
{
    private $userid;
    private $apikey;
    public function __construct()
    {
        parent::__construct();
        $memberid = I("request.pay_memberid",0,'intval') - 10000;
        if (empty($memberid) || $memberid<=0) {
            $this->showmessage("不存在的商户编号!");
        }
        $this->userid = $memberid;
        $fans = M('Member')->where(['id'=>$this->userid])->find();
        if(!$fans){
            $this->showmessage('商户不存在');
        }
        $this->apikey = $fans['apikey'];
      
    }

    //订单查询
    public function query()
    {

        $out_trade_id = I('request.pay_orderid', '', 'string,strip_tags,htmlspecialchars');
        $sign = I('request.pay_md5sign');
        if(empty($out_trade_id)){
            $this->showmessage("不存在的交易订单号.");
        }
        $pay_memberid = I("request.pay_memberid", 0, 'intval');
        if(!$pay_memberid) {
            $this->showmessage("商户号错误.");
        }
        $request = [
            'pay_memberid'=>$pay_memberid,
            'pay_orderid'=>$out_trade_id
        ];
        $signature = $this->createSign($this->apikey,$request);
        if($signature != $sign){
            $this->showmessage('验签失败!');
        }
        $order = M('Order')->where(['pay_memberid'=>$request['pay_memberid'],
            'out_trade_id'=>$request['pay_orderid']])->select();
        if(!$order){
            $this->showmessage('不存在的交易订单.');
        }
        $order_list = [];
        foreach($order as $k => $v) {
            $order_list[$k]['orderid'] = $v['out_trade_id'];
            $order_list[$k]['amount'] = $v['pay_amount'];
            $order_list[$k]['time_end'] = date('Y-m-d H:i:s',$order['pay_successdate']);
            $order_list[$k]['transaction_id'] = $v['pay_orderid'];
            if($v['pay_status']==0){
                $msg = "NOTPAY";
            }elseif ($v['pay_status'] ==1 || $v['pay_status'] == 2){
                $msg = "SUCCESS";
            }
            $order_list[$k]['trade_state'] = $msg;
        }

         $return = [
            'memberid'=>$pay_memberid,
            'returncode'=>"00"

        ];
        $md5param = [
            'memberid'=>$pay_memberid,
            'returncode'=>"00",
            'orderid'=>$order_list[0]['orderid'],
            'amount'=>$order_list[0]['amount'],
            'time_end'=>$order_list[0]['time_end'],
            'transaction_id'=>$order_list[0]['transaction_id'],
            'trade_state'=>$order_list[0]['trade_state']

        ];
             

        $return['sign'] = $this->createSign($this->apikey,$md5param);
        $return['data'] = $order_list;
        echo json_encode($return);
    }
}