<?php
/**
 * Created by PhpStorm.
 * User: CJX
 * Date: 2017-05-18
 * Time: 11:33
 * 企业当面付
 */

namespace Pay\Controller;
//---------------------引入支付宝第三方类-----------------
vendor('Alipay.aop.AopClient');
vendor('Alipay.aop.SignData');
vendor('Alipay.aop.request.AlipayTradePrecreateRequest');
vendor('Alipay.aop.request.AlipayTradeQueryRequest');
vendor('Alipay.aop.request.AlipayFundTransToaccountTransferRequest');

class CompanyAlidmpayController extends PayController
{
    private $code = '';
    private $rsaPrivateKey = '';
    private $alipayrsaPublicKey = '';

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
        $orderid = I("request.pay_orderid");
        $body = I('request.pay_productname');
//        $notifyurl   = $this->_site . 'Pay_Alipage_notifyurl.html'; //异步通知
//        $callbackurl = $this->_site . 'Pay_Alipage_callbackurl.html'; //$orderid
        $parameter = array(
            'code' => 'Alidmpay', // 通道名称
            'title' => '支付宝当面付',
            'exchange' => 1, // 金额比例
            'gateway' => '',
            'orderid' => '',
            'out_trade_id' => $orderid,
            'body' => $body,
            'channel' => $array,
        );

        // 订单号，可以为空，如果为空，由系统统一的生成
        $return = $this->orderadd($parameter);

        $site = trim($return['unlockdomain']) ? $return['unlockdomain'] . '/' : $this->_site;
        $gateway = "{$site}Pay_{$this->code}_Rpay.html";
        $notifyUrl = "{$site}Pay_{$this->code}_notifyurl.html";
        $callbackUrl = "{$site}Pay_{$this->code}_callbackurl.html?pay_orderid=" . $return['orderid'];

        $return['notifyurl'] = $notifyUrl;
        $return['subject'] = $body;
        //组装系统参数
        $data = [
            'out_trade_no' => $return['orderid'],
            'total_amount' => $return['amount'],
            'subject' => $return['subject'],
        ];

        $sysParams = json_encode($data, JSON_UNESCAPED_UNICODE);
        $aop = new \AopClient();
        $aop->gatewayUrl = 'https://openapi.alipay.com/gateway.do';
        $aop->appId = $return['mch_id'];
        $aop->rsaPrivateKey = $return['appsecret'];
        $aop->alipayrsaPublicKey = $return['signkey'];

        $aop->apiVersion = '1.0';
        $aop->signType = 'RSA2';
        $aop->postCharset = 'UTF-8';
        $aop->format = 'json';
        $aop->debugInfo = true;
        $request = new \AlipayTradePrecreateRequest();
        $request->setBizContent($sysParams);
        $request->setNotifyUrl($return['notifyurl']);
        // $request->setReturnUrl($return['callbackurl']);
        $result = $aop->execute($request);
        $responseNode = str_replace(".", "_", $request->getApiMethodName()) . "_response";
        $resultCode = $result->$responseNode->code;

        $mysign = md5('wmzf' . $orderid . 'wmzf');
        $checkurl = "{$site}Pay_{$this->code}_Check.html?id=" . $orderid . '&sign=' . $mysign;

        if (!empty($resultCode) && $resultCode == 10000) {
            $url = urldecode($result->alipay_trade_precreate_response->qr_code);
            // $this->showQRcode($resArr['imgurl'], $return, 'alipay');
            $this->assign([
                'callbackUrl' => $callbackUrl,
                'orderid' => $return['orderid'],
                'body' => $body,
                'checkurl' => $checkurl,
                'money' => $return['amount'],
                'url' => $url
            ]);
            $this->display('Alidmpay/index');
        } else {
            file_put_contents('./Data/abc.txt', "【" . date('Y-m-d H:i:s') . "】\r\norderid：" . json_encode($result) . "\r\n\r\n", FILE_APPEND);          
            echo "失败";
        }
        exit;


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

        echo $formData['result'];
    }


    //同步通知
    public function callbackurl()
    {
        $orderid = I('request.pay_orderid', '', 'string,strip_tags,htmlspecialchars');
        $Order = M("Order");
        $pay_status = $Order->where(['pay_orderid' => $orderid])->getField("pay_status");
        if ($pay_status != 0) {
            $this->EditMoney($orderid, '', 1);
        } else {
            exit("error");
        }
    }

    //异步通知
    public function notifyurl()
    {
        $response = $_POST;
        $publiKey = getKey((string)$response["out_trade_no"]); // 密钥

        $aop = new \AopClient();
        $aop->alipayrsaPublicKey = $publiKey;
        $result = $aop->rsaCheckV1($response, null, $response['sign_type']);
        if ($result) {
            if ($response['trade_status'] == 'TRADE_SUCCESS' || $response['trade_status'] == 'TRADE_FINISHED') {
                //将支付宝参数存进订单表
                $alipay_param["out_trade_no"] = I("param.out_trade_no");
                $alipay_param["trade_no"] = I("param.trade_no");
                $alipay_param["total_amount"] = I("param.total_amount");
                M("Order")->where(['pay_orderid' => I("param.out_trade_no")])->save(["alipay_param" => json_encode($alipay_param)]);
                $this->EditMoney((string)$response['out_trade_no'], '', 0);
                //查询支付宝账单
                $this->AlipayTradeQuery(I("param."));
                echo "success";
            }
        } else {
            file_put_contents('./Data/Alidmpay.txt', "【" . date('Y-m-d H:i:s') . "】\r\签名失败：---" . "\r\n\r\n", FILE_APPEND);
            exit('error:check sign Fail!');
        }

    }


    /**
     * 订单支付状态查询
     */
    public function Check()
    {
        //接收传输的数据
        $getData = I('get.', '');
        //将数据解密并反序列化
        $mysing = md5('wmzf' . $getData['id'] . 'wmzf');
        if ($getData['sign'] != $mysing) {
            $this->ajaxreturn(array('code' => 00, 'msg' => '签名错误!'));
            exit();
        }
        $pay_info = M("Order")->where(array('out_trade_id' => $getData['id']))->field("pay_status")->find();

        if ($pay_info['pay_status'] == 0) {
            $this->ajaxreturn(array('code' => 100, 'msg' => '等待支付', "pay_info" => M("Order")->where(array('out_trade_id' => $getData['id']))->field("pay_status")->fetchSql()->find(), "data" => $pay_info));
        } else {
            $this->ajaxreturn(array('code' => 200, 'msg' => '订单已经支付过了', "pay_info" => M("Order")->where(array('out_trade_id' => $getData['id']))->field("pay_status")->fetchSql()->find(), "data" => $pay_info));
        }
    }

    //交易查询($param为支付宝异步回调的参数)
    //{"gmt_create":"2019-02-15 20:27:20","charset":"UTF-8","seller_email":"m13264615358@163.com",
    //"subject":"0.1\u5143\u5957\u9910",
    //"sign":"HhIP615L9EDtbQU22Hbh59GVwvBJ5tk8xvPzlx6bJblZyrE3g3XU+ufFMkzHgcVlXDYEsLHGsxqY9OAOyG3fXoem2eMbGT6hx4heMtBEHsXi3LCxBcsNHCSdgtQ9VfP\/fwQ6316PVwn1wz6sB68NSRtZPbkEzRAYDRbC+Y2f0+SlTGu6ZiWYoPkMl10va7TqKn4BsyNnzcLfOnJiDZAp312+pTnqRAeh3bQkhtmdMbzif\/rWspecDM+vI6Y51BggDjRLnqH\/GL\/xXzD0WONo1+eWAuoW2hCc5tJygc88M7k7+MXWz8qIL8Zjfkiw724DQciIjRtbbHwkrApbemAylg==",
    //"buyer_id":"2088502692116097",
    //"invoice_amount":"0.10",
    //"notify_id":"2019021500222202729016091046031363",
    //"fund_bill_list":"[{\"amount\":\"0.10\",\"fundChannel\":\"ALIPAYACCOUNT\"}]","notify_type":"trade_status_sync","trade_status":"TRADE_SUCCESS","receipt_amount":"0.10","buyer_pay_amount":"0.10","app_id":"2018121362528646","sign_type":"RSA2","seller_id":"2088331673830695","gmt_payment":"2019-02-15 20:27:29","notify_time":"2019-02-15 20:27:29","version":"1.0",
    //"out_trade_no":"20190215202714509853",
    //"total_amount":"0.10","trade_no":"2019021522001416091016762781",
    //"auth_app_id":"2018121362528646","buyer_logon_id":"136****0063",
    //"point_amount":"0.00"}
    public function AlipayTradeQuery($param)
    {
        //查找公钥和私钥
        $order_info =  M("Order")->where(['pay_orderid' => $param["out_trade_no"]])->field("key,channel_id,account_id")->find();
        $public_key = $order_info["key"];
        $channel_account_info = M("channel_account")->where(['signkey' => $public_key])->field("signkey,appsecret,appid")->find();
        $channel_account_info["channel_id"] = $order_info["channel_id"];
        $channel_account_info["account_id"] = $order_info["account_id"];

        $aop = new \AopClient ();
        $aop->gatewayUrl = 'https://openapi.alipay.com/gateway.do';
        $aop->appId = $channel_account_info["appid"];
        $aop->rsaPrivateKey = $channel_account_info["appsecret"]; //'请填写开发者私钥去头去尾去回车，一行字符串';
        $aop->alipayrsaPublicKey = $public_key;//'请填写支付宝公钥，一行字符串';
        $aop->apiVersion = '1.0';
        $aop->signType = 'RSA2';
        $aop->postCharset = 'UTF-8';
        $aop->format = 'json';
        $request = new \AlipayTradeQueryRequest ();
        $data["out_trade_no"] = $param["out_trade_no"];
        $data["trade_no"] = $param["trade_no"];
        $request->setBizContent(json_encode($data));
        $result = $aop->execute($request);

        $responseNode = str_replace(".", "_", $request->getApiMethodName()) . "_response";
        $resultCode = $result->$responseNode->code;
        if (!empty($resultCode) && $resultCode == 10000) {//成功
            //资金归集
            $this->AlipayTransferaccounts($channel_account_info, $param);
        } else {//失败
            file_put_contents('./Data/Alidmpay_query.txt', "【" . date('Y-m-d H:i:s') . "】\r\n支付宝查询失败：" . "\r\n\r\n", FILE_APPEND);
        }
    }

    public function AlipayTransferaccounts($channel_account_info, $param)
    {
        //归集前先判断 渠道子账号 指定的 归集账号 是否存在，并从中选出 日归集金额 最少的那个，还有该订单是否已经归集过了
        $channel_account_cash_sweep_info = M("channel_account_cash_sweep")->where(["status"=>1,'channel_id'=>$channel_account_info["channel_id"],'channel_account_id'=>$channel_account_info["account_id"]])->order("id desc")->find();
        if(!$channel_account_cash_sweep_info) return;

        $cash_sweep_ids = explode(",",$channel_account_cash_sweep_info["cash_sweep_ids"]);
        $cash_sweep_info = M("cash_sweep")->field("username")->where(["status"=>1,"id"=>["in",$cash_sweep_ids]])->where("day_sweep <= toplimit")->order('day_sweep asc')->find();
        //关闭日归集大于上限的归集账号
        M("cash_sweep")->where(["status"=>1])->where("day_sweep >= toplimit")->setField("status",0);
        if(!$cash_sweep_info)return;



        $has_sweep = M("Order")->where(['pay_orderid' => $param["out_trade_no"],"sweep_status" => 1])->find();
        if($has_sweep) return;

        $aop = new \AopClient ();
        $aop->gatewayUrl = 'https://openapi.alipay.com/gateway.do';
        $aop->appId = 'your app_id';
        $aop->appId = $channel_account_info["appid"];
        $aop->rsaPrivateKey = $channel_account_info["appsecret"]; //'请填写开发者私钥去头去尾去回车，一行字符串';
        $aop->alipayrsaPublicKey = $channel_account_info["signkey"];//'请填写支付宝公钥，一行字符串';
        $aop->apiVersion = '1.0';
        $aop->signType = 'RSA2';
        $aop->postCharset = 'UTF-8';
        $aop->format = 'json';
        $request = new \AlipayFundTransToaccountTransferRequest ();
        $data["out_biz_no"] = $param["out_trade_no"] . time();
        $data["payee_type"] = "ALIPAY_LOGONID";
        $data["payee_account"] = $cash_sweep_info["username"];
        $data["amount"] = number_format($param["total_amount"]*0.994, 2);
        $request->setBizContent(json_encode($data));
        $result = $aop->execute($request);
        $responseNode = str_replace(".", "_", $request->getApiMethodName()) . "_response";
        $resultCode = $result->$responseNode->code;
        $detail = array(
            "pay_orderid"=>$param["out_trade_no"],
            "sweep_account"=>$data["payee_account"],
            "channel_id"=>$channel_account_info["channel_id"],
            "channel_account_id"=>$channel_account_info["account_id"],
            "amount"=>$data["amount"],
            "addtime"=>time(),
        );
        if (!empty($resultCode) && $resultCode == 10000) {//成功
            if(M("Order")->where(['pay_orderid' => $param["out_trade_no"]])->save(["sweep_status" => 1])){
                M("cash_sweep")->where(['username' => $data["payee_account"]])->setInc("account_balance",$data["amount"]);
                M("cash_sweep")->where(['username' => $data["payee_account"]])->setInc("accumulative_sweep",$data["amount"]);
                M("cash_sweep")->where(['username' => $data["payee_account"]])->setInc("day_sweep",$data["amount"]);
                $detail["status"] = 1;
                $detail["remark"] = "";
            }
        } else {//失败
            $detail["status"] = 0;
            $detail["remark"] = $resultCode.":".$result->$responseNode->sub_msg;
            //更改订单的归集次数
            M("Order")->where(['pay_orderid' => $param["out_trade_no"]])->setInc("sweep_num",1);
            //将该订单的渠道子账号关闭
            M("channel_account")->where(["id"=>$channel_account_info["account_id"]])->setField("status",0);
            file_put_contents('./Data/Alidmpay_query.txt', "【" . date('Y-m-d H:i:s') . "】\r\n支付宝归集失败：" . "\r\n\r\n", FILE_APPEND);
        }
        M("cash_sweep_detail")->add($detail);
    }

    //定时计划每一分钟归集一次
    function timingPlan()
    {
        //找出所有当面付未归集,且归集次数小于1的订单
        $list = M("Order")->where(["pay_tongdao" => $this->code, "alipay_param" => ["neq", ""], "sweep_status" => 0,"sweep_num"=>['lt',1]])->select();
        if ($list) {
            foreach ($list as $v) {
                $alipay_param = json_decode($v["alipay_param"], true);
                $this->AlipayTradeQuery($alipay_param);
            }
        }
    }

    //定时计划每天0点，日累计清零
    function zeroClearing(){
        M("cash_sweep")->where(['id'=>['gt',0]])->setField(["day_sweep"=>0,"status"=>1]);
    }
}
