<?php
namespace Pay\Controller;
use Think\Controller;

class PayController extends Controller
{
    //商家信息
    protected $merchants;
    //网站地址
    protected $_site;
    //通道信息
    protected $channel;

    protected $_checkApiSite="";
    public $_apiSite="";

    public function __construct()
    {
        parent::__construct();

        $this->_site = ((is_https()) ? 'https' : 'http') . '://' . C("DOMAIN") . '/';
        $this->_checkApiSite = C('API_SITE');
        $this->_apiSite =  ((is_https()) ? 'https' : 'http') . '://' . C('API_SITE') . '/';

        $deny = ['exp','delete','update','insert'];
        foreach($_REQUEST as $k => $v) {
            if(in_array(strtolower($k), $deny)) {
                die;
            }
            switch (strtolower($k)) {
                case 'pay_orderid':
                case 'pay_productname':
                case 'pay_attach':
                case 'out_trade_no':
                case 'outtradeno':
                case 'orderid':
                case 'orderno':
                case 'merorderid':
                    $_REQUEST[$k] = (string)$_REQUEST[$k];
                    if(isset($_GET[$k])) {
                        $_GET[$k] = (string)$_GET[$k];
                    }
                    if(isset($_POST[$k])) {
                        $_POST[$k] = (string)$_POST[$k];
                    }
                    break;
            }
        }
    }
    /**
     * 创建订单
     * @param $parameter
     * @return array
     */
    public function orderadd($parameter)
    {
        $pay_amount = I("post.pay_amount", 0);

        //通道信息
        $this->channel = $parameter['channel'];
        //$this->merchants = $this->channel['userid'];
        //用户信息
        $usermodel       = D('Member');
        $this->merchants = $usermodel->get_Userinfo($this->channel['userid']);
        $return          = array();
        // 通道名称
        $PayName = $parameter["code"];
        // 交易金额比例
        $moneyratio = $parameter["exchange"];
        //商户编号
        $return["memberid"] = $userid = $this->merchants['id'] + 10000;
        $m_Tikuanconfig     = M('Tikuanconfig');
        $tikuanconfig       = $m_Tikuanconfig->where(['userid' => $this->merchants['id']])->find();
        if (!$tikuanconfig || $tikuanconfig['tkzt'] != 1 || $tikuanconfig['systemxz'] != 1) {
            $tikuanconfig = $m_Tikuanconfig->where(['issystem' => 1])->find();
        }
        //费率
        $_userrate = M('Userrate')
            ->where(["userid" => $this->channel['userid'], "payapiid" => intval($this->channel['pid'])])
            ->find();
        //支付产品费率
        $product = M('Product')
            ->where(['id' => intval($this->channel['pid'])])
            ->find();
        //银行通道
        $syschannel = M('Channel')
            ->where(['id' => intval($this->channel['api'])])
            ->find();

        //---------------------------子账号风控start------------------------------------
        $channel_account_list        = M('channel_account')->where(['channel_id' => $syschannel['id'], 'status' => '1'])->select();
        $account_ids                 = M('UserChannelAccount')->where(['userid' => intval($this->channel['userid']), 'status' => 1])->getField('account_ids');
        if($account_ids){
            $account_ids  = explode(',',  $account_ids );
            foreach($channel_account_list as $k => $v){
                //如果不在指定的子账号，将其删除
                if(!in_array($v['id'], $account_ids )){
                    unset($channel_account_list[$k]);
                }
            }
        }

        $l_ChannelAccountRiskcontrol = new \Pay\Logic\ChannelAccountRiskcontrolLogic($pay_amount);
        $channel_account_item        = [];
        $error_msg                   = '已下线';
        foreach ($channel_account_list as $k => $v) {
            if ($v['offline_status'] && $v['control_status']) {
                //判断是自定义还是继承渠道的风控
                $temp_info               = $v['is_defined'] ? $v : $syschannel;
                $temp_info['account_id'] = $v['id']; //用于子账号风控类继承渠道风控机制时修改数据的id
                //子账号风控
                $l_ChannelAccountRiskcontrol->setConfigInfo($temp_info);
                $error_msg = $l_ChannelAccountRiskcontrol->monitoringData();
                if ($error_msg === true) {
                    $channel_account_item[] = $v;
                }
            } else if ($v['control_status'] == 0) {
                $channel_account_item[] = $v;
            }
        }
        if (empty($channel_account_item)) {
            file_put_contents('./Data/AcocuntError.txt', "【" . date('Y-m-d H:i:s') . "】\r\错误通道信息" . json_encode($this) . "\r\n\r\n", FILE_APPEND);

            $this->showmessage('账户:' . $error_msg);
        }
        //-------------------------子账号风控end-----------------------------------------

        // 计算权重
        if (count($channel_account_item) == 1) {
            $channel_account = current($channel_account_item);
        } else {
            //轮询规则开始
            //金额轮询 金额都为0 直接权重
            $control_order=M('user_channel_control')->field('id,channel_ids,type')->where(['userid' =>$this->merchants['id'],'channel_ids'=>$syschannel['id']])->find();

            if ($control_order['type']==2) {
                //排序最小的钱
                //

                $keysvalue = $new_account_item = array();
                foreach ($channel_account_item as $k=>$v){
                    $keysvalue[$k] = $v['paying_money'];
                }
                asort($keysvalue);
                reset($keysvalue);
                foreach ($keysvalue as $k=>$v){
                    $new_account_item[$k] = $channel_account_item[$k];
                }


                reset($keysvalue);
                $min_accout=current($new_account_item);
                $max_accout=array_pop($new_account_item);

                if ($min_accout['paying_money'] >0) {
                    $channel_account =$min_accout;
                } elseif ($max_accout['paying_money'] ==0) {
                    $channel_account = getWeight($channel_account_item);
                }else {
                    $channel_account =$min_accout;
                }

            }elseif ($control_order['type']==1) {
                //顺序
                //查找些子账号的 上一个订单
                $channel_account=array();
                $channel_account_id=array_column($channel_account_item, 'id');
                $last_where['pay_memberid']=$userid;
                $last_where['account_id']=array('in',$channel_account_id);

                $last_odrder=M('order')->where($last_where)->order('id desc')->find();
                while (list($k, $v) = each($channel_account_item)) {
                    if ($v['id'] ==$last_odrder['account_id']) {
                        break;
                    }

                }
                $channel_account=current($channel_account_item);
                if (empty($channel_account)) {
                    Reset($channel_account_item);
                    $channel_account=current($channel_account_item);
                }
            } else{
                $channel_account = getWeight($channel_account_item);
            }


        }

        $syschannel['mch_id']    = $channel_account['mch_id'];
        $syschannel['signkey']   = $channel_account['signkey'];
        $syschannel['appid']     = $channel_account['appid'];
        $syschannel['appsecret'] = $channel_account['appsecret'];
        $syschannel['account']   = $channel_account['title'];

        // 定制成本费率
        if ($channel_account['custom_rate']) {
            $syschannel['rate']        = $channel_account['rate'];
        }

        //平台通道
        $platform = M('Product')
            ->where(['id' => $this->channel['pid']])
            ->find();
        if ($channel_account['unlockdomain']) {
            $unlockdomain = $channel_account['unlockdomain'] ? $channel_account['unlockdomain'] : '';
        } else {
            $unlockdomain = $syschannel['unlockdomain'] ? $syschannel['unlockdomain'] : '';
        }

        //回调参数
        $return = [
            "mch_id"       => $syschannel["mch_id"], //商户号
            "signkey"      => $syschannel["signkey"], // 签名密钥
            "appid"        => $syschannel["appid"], // APPID
            "appsecret"    => $syschannel["appsecret"], // APPSECRET
            "gateway"      => $syschannel["gateway"] ? $syschannel["gateway"] : $parameter["gateway"], // 网关
            "notifyurl"    => $syschannel["serverreturn"] ? $syschannel["serverreturn"] : $this->_site . "Pay_" .
                $PayName . "_notifyurl.html",
            "callbackurl"  => $syschannel["pagereturn"] ? $syschannel["pagereturn"] : $this->_site . "Pay_" .
                $PayName . "_callbackurl.html",
            'unlockdomain' => $unlockdomain, //防封域名
        ];

        //用户优先通道(费率计算)
        //if ($tikuanconfig['t1zt'] == 0) { //T+0费率
        //$feilv = $_userrate['t0feilv'] ? $_userrate['t0feilv'] : $product['t0defaultrate']; // 交易费率
        //$fengding = $_userrate['t0fengding'] ? $_userrate['t0fengding'] : $product['t0fengding']; // 封顶手续费
        //} else { //T+1费率
        //$feilv = $_userrate['feilv'] ? $_userrate['feilv'] : $product['defaultrate']; // 交易费率
        //$fengding = $_userrate['fengding'] ? $_userrate['fengding'] : $product['fengding']; // 封顶手续费
        //}

        //根据根据入金渠道找到对应的支付产品，用户设置的支付产品费率来计算费率
        $user_payment_product_rate = M("user_payment_product_rate")->where(["userid" => $this->merchants['id'], "payment_product_id" => $syschannel['payment_product_id']])->getField("rate");
        if ($tikuanconfig['t1zt'] == 0) { //T+0费率
            $feilv = $user_payment_product_rate ? $user_payment_product_rate : $product['t0defaultrate'];// 交易费率
            $fengding = $user_payment_product_rate ? $user_payment_product_rate : $product['t0fengding'];// 封顶手续费
        } else { //T+1费率
            $feilv = $user_payment_product_rate ? $user_payment_product_rate : $product['defaultrate'];// 交易费率
            $fengding = $user_payment_product_rate ? $user_payment_product_rate : $product['fengding'];// 封顶手续费
        }
        $fengding = $fengding == 0 ? 9999999 : $fengding; //如果没有设置封顶手续费自动设置为一个足够大的数字

        //金额格式化

        if (!$pay_amount || !is_numeric($pay_amount) || $pay_amount <= 0) {
            $this->showmessage('金额错误');
        }
        $return["amount"] = floatval($pay_amount) * $moneyratio; // 交易金额
        $pay_sxfamount    = (($pay_amount * $feilv) > ($pay_amount * $fengding)) ? ($pay_amount * $fengding) :
            ($pay_amount * $feilv); // 手续费

        $pay_shijiamount = $pay_amount - $pay_sxfamount; // 实际到账金额

        $cost = bcmul($syschannel['rate'], $pay_amount, 4); //计算成本

        //商户订单号
        $out_trade_id = $parameter['out_trade_id'];
        //生成系统订单号
        $pay_orderid = $parameter['orderid'] ? $parameter['orderid'] : get_requestord();
        //验签
        if ($this->verify()) {
            $Order                       = M("Order");
            $return['bankcode']          = $this->channel['pid'];
            $return['code']              = $platform['code']; //银行英文代码
            $return['orderid']           = $pay_orderid; // 系统订单号
            $return['out_trade_id']      = $out_trade_id; // 外部订单号
            $return['subject']           = $parameter['body']; // 商品标题
            $data['pay_memberid']        = $userid;
            $data['pay_orderid']         = $return["orderid"];
            $data['pay_amount']          = $pay_amount; // 交易金额
            $data['pay_poundage']        = $pay_sxfamount; // 手续费
            $data['pay_actualamount']    = $pay_shijiamount; // 到账金额
            $data['pay_applydate']       = time();
            $data['pay_bankcode']        = intval($this->channel['pid']);
            $data['pay_bankname']        = $platform['name'];
            $data['pay_notifyurl']       = I('post.pay_notifyurl' ,'', 'string,strip_tags,htmlspecialchars');
            $data['pay_callbackurl']     = I('post.pay_callbackurl', '', 'string,strip_tags,htmlspecialchars');
            $data['pay_status']          = 0;
            $data['pay_tongdao']         = $syschannel['code'];
            $data['pay_zh_tongdao']      = $syschannel['title'];
            $data['pay_channel_account'] = $syschannel['account'];
            $data['pay_ytongdao']        = $parameter["code"];
            $data['pay_yzh_tongdao']     = $parameter["title"];
            $data['pay_tjurl']           = substr((string)$_SERVER['HTTP_REFERER'],0,1000);
            $data['pay_productname']     = I("request.pay_productname");
            $data['attach']              = I("request.pay_attach");
            $data['out_trade_id']        = $out_trade_id;
            $data['ddlx']                = I("post.ddlx", 0, 'intval');
            $data['memberid']            = $return["mch_id"];
            $data['key']                 = $return["signkey"];
            $data['account']             = $return["appid"];
            $data['cost']                = $cost;
            $data['cost_rate']           = $tikuanconfig['t1zt'] == 0 ? $syschannel['t0rate'] : $syschannel['rate'];
            $data['channel_id']          = $this->channel['api'];
            $data['account_id']          = $channel_account['id'];
            $data['t']                   = $tikuanconfig['t1zt'] ? $tikuanconfig['t1zt'] :0;
            // $data['qr_url']              = $parameter["qr_url"];

            //添加订单
            if (M("order")->add($data)) {
                $return['datetime'] = date('Y-m-d H:i:s', $data['pay_applydate']);
                $return["status"]   = "success";
                $return["channel_code"] = $syschannel["code"];
                return $return;
            } else {
                $this->showmessage('系统错误');
            }
        } else {
            $this->showmessage('签名验证失败', $_POST);
        }
    }

    /**
     * 回调处理订单
     * @param $TransID
     * @param $PayName
     * @param int $returntype
     */
    protected function EditMoney($trans_id, $pay_name = '', $returntype = 1, $transaction_id = '')
    {
        if ($returntype!=1){
            $this->checkSuccessIP($trans_id);
        }
        $m_Order    = M("Order");
        $order_info = $m_Order->where(['pay_orderid' => $trans_id])->find(); //获取订单信息
        $userid     = intval($order_info["pay_memberid"] - 10000); // 商户ID
        $time       = time(); //当前时间

        //********************************************订单支付成功上游回调处理********************************************//
        if ($order_info["pay_status"] == 0) {
            //开启事物
            M()->startTrans();
            //查询用户信息
            $m_Member    = M('Member');
            $member_info = $m_Member->where(['id' => $userid])->lock(true)->find();
            //更新订单状态 1 已成功未返回 2 已成功已返回
            $res = $m_Order->where(['pay_orderid' => $trans_id, 'pay_status' => 0])
                ->save(['pay_status' => 1, 'pay_successdate' => $time]);
            if (!$res) {
                M()->rollback();
                return false;
            }
            //-----------------------------------------修改用户数据 商户余额、冻结余额start-----------------------------------
            //要给用户增加的实际金额（扣除投诉保证金）
            $actualAmount          = $order_info['pay_actualamount'];
            $complaintsDepositRule = $this->getComplaintsDepositRule($userid);
            if (isset($complaintsDepositRule['status']) && $complaintsDepositRule['status'] == 1) {
                if ($complaintsDepositRule['ratio'] > 100) {
                    $complaintsDepositRule['ratio'] = 100;
                }
                $depositAmount = round($complaintsDepositRule['ratio'] / 100 * $actualAmount, 4);
                $actualAmount -= $depositAmount;
            }

            //创建修改用户修改信息
            $member_data = [
                'last_paying_time'   => $time,
                'unit_paying_number' => ['exp', 'unit_paying_number+1'],
                'unit_paying_amount' => ['exp', 'unit_paying_amount+' . $actualAmount],
                'paying_money'       => ['exp', 'paying_money+' . $actualAmount],
            ];

            //判断用结算方式
            switch ($order_info['t']) {
                case '0':
                    //t+0结算
                case '7':
                    //t+7 只限制提款和代付时间，每周一允许提款
                case '30':
                    //t+30 只限制提款和代付时间，每月第一天允许提款
                    $ymoney                 = $member_info['balance']; //改动前的金额
                    $gmoney                 = bcadd($member_info['balance'], $actualAmount, 4); //改动后的金额
                    $member_data['balance'] = ['exp', 'balance+' . $actualAmount]; //防止数据库并发脏读
                    break;
                case '1':
                    //t+1结算，记录冻结资金
                    $blockedlog_data = [
                        'userid'     => $userid,
                        'orderid'    => $order_info['pay_orderid'],
                        'amount'     => $actualAmount,
                        'thawtime'   => (strtotime('tomorrow') + rand(0, 7200)),
                        'pid'        => $order_info['pay_bankcode'],
                        'createtime' => $time,
                        'status'     => 0,
                    ];
                    $blockedlog_result = M('Blockedlog')->add($blockedlog_data);
                    if (!$blockedlog_result) {
                        M()->rollback();
                        return false;
                    }
                    $ymoney                        = $member_info['blockedbalance']; //原冻结资金
                    $gmoney                        = bcadd($member_info['blockedbalance'], $actualAmount, 4); //改动后的冻结资金
                    $member_data['blockedbalance'] = ['exp', 'blockedbalance+' . $actualAmount]; //防止数据库并发脏读

                    break;
                default:
                    # code...
                    break;
            }

            $member_result = $m_Member->where(['id' => $userid])->save($member_data);
            if ($member_result != 1) {
                M()->rollback();
                return false;
            }

            // 商户充值金额变动
            $moneychange_data = [
                'userid'     => $userid,
                'ymoney'     => $ymoney, //原金额或原冻结资金
                'money'      => $actualAmount,
                'gmoney'     => $gmoney, //改动后的金额或冻结资金
                'datetime'   => date('Y-m-d H:i:s'),
                'tongdao'    => $order_info['pay_bankcode'],
                'transid'    => $trans_id,
                'orderid'    => $order_info['out_trade_id'],
                'contentstr' => $order_info['out_trade_id'] . '订单充值,结算方式：t+' . $order_info['t'],
                'lx'         => 1,
                't'          => $order_info['t'],
            ];

            $moneychange_result = $this->MoenyChange($moneychange_data); // 资金变动记录

            if ($moneychange_result == false) {
                M()->rollback();
                return false;
            }

            // 记录投诉保证金
            if (isset($depositAmount) && $depositAmount > 0) {
                $depositResult = M('ComplaintsDeposit')->add([
                    'user_id'       => $userid,
                    'pay_orderid'   => $trans_id,
                    'out_trade_id'  => $order_info['out_trade_id'],
                    'freeze_money'  => $depositAmount,
                    'unfreeze_time' => time() + $complaintsDepositRule['freeze_time'],
                    'status'        => 0,
                    'create_at'     => time(),
                    'update_at'     => time(),
                ]);
                if ($depositResult == false) {
                    M()->rollback();
                    return false;
                }
            }

            // 通道ID
            $bianliticheng_data = [
                "userid"  => $userid, // 用户ID
                "transid" => $trans_id, // 订单号
                "money"   => $order_info["pay_amount"], // 金额
                "tongdao" => $order_info['pay_bankcode'],
            ];
            $this->bianliticheng($bianliticheng_data); // 提成处理
            M()->commit();

            //-----------------------------------------修改用户数据 商户余额、冻结余额end-----------------------------------

            //-----------------------------------------修改通道风控支付数据start----------------------------------------------
            $m_Channel     = M('Channel');
            $channel_where = ['id' => $order_info['channel_id']];
            $channel_info  = $m_Channel->where($channel_where)->find();
            //判断当天交易金额并修改支付状态
            $channel_res = $this->saveOfflineStatus(
                $m_Channel,
                $order_info['channel_id'],
                $order_info['pay_amount'],
                $channel_info
            );

            //-----------------------------------------修改通道风控支付数据end------------------------------------------------

            //-----------------------------------------修改子账号风控支付数据start--------------------------------------------
            $m_ChannelAccount      = M('ChannelAccount');
            $channel_account_where = ['id' => $order_info['account_id']];
            $channel_account_info  = $m_ChannelAccount->where($channel_account_where)->find();
            if ($channel_account_info['is_defined'] == 0) {
                //继承自定义风控规则
                $channel_info['paying_money'] = $channel_account_info['paying_money']; //当天已交易金额应该为子账号的交易金额
                $channel_account_info         = $channel_info;
            }
            //判断当天交易金额并修改支付状态
            $channel_account_res = $this->saveOfflineStatus(
                $m_ChannelAccount,
                $order_info['account_id'],
                $order_info['pay_amount'],
                $channel_account_info
            );
            if ($channel_account_info['unit_interval']) {
                $m_ChannelAccount->where([
                    'id' => $order_info['account_id'],
                ])->save([
                    'unit_paying_number' => ['exp', 'unit_paying_number+1'],
                    'unit_paying_amount' => ['exp', 'unit_paying_amount+' . $order_info['pay_actualamount']],
                ]);
            }

            //-----------------------------------------修改子账号风控支付数据end----------------------------------------------

        }

        //************************************************回调，支付跳转*******************************************//
        $return_array = [ // 返回字段
            "memberid"       => $order_info["pay_memberid"], // 商户ID
            "orderid"        => $order_info['out_trade_id'], // 订单号
            'transaction_id' => $order_info["pay_orderid"], //支付流水号
            "amount"         => $order_info["pay_amount"], // 交易金额
            "datetime"       => date("YmdHis"), // 交易时间
            "returncode"     => "00", // 交易状态
        ];
        if (!isset($member_info)) {
            $member_info = M('Member')->where(['id' => $userid])->find();
        }
        $sign                   = $this->createSign($member_info['apikey'], $return_array);
        $return_array["sign"]   = $sign;
        $return_array["attach"] = "";
        switch ($returntype) {
            case 0:
                $notifystr = "";
                foreach ($return_array as $key => $val) {
                    $notifystr = $notifystr . $key . "=" . $val . "&";
                }
                $notifystr = rtrim($notifystr, '&');
                $ch        = curl_init();
                curl_setopt($ch, CURLOPT_TIMEOUT, 10);
                curl_setopt($ch, CURLOPT_CONNECTTIMEOUT, 10);
                curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
                curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, false);
                curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
                curl_setopt($ch, CURLOPT_POST, 1);
                curl_setopt($ch, CURLOPT_URL, $order_info["pay_notifyurl"]);
                curl_setopt($ch, CURLOPT_POSTFIELDS, $notifystr);
                $contents = curl_exec($ch);
                $httpCode = curl_getinfo($ch,CURLINFO_HTTP_CODE);
                curl_close($ch);
                log_server_notify($order_info["pay_orderid"], $order_info["pay_notifyurl"], $notifystr, $httpCode, $contents);
                if (strstr(strtolower($contents), "ok") != false) {
                    //更新交易状态
                    $order_where = [
                        'id'          => $order_info['id'],
                        'pay_orderid' => $order_info["pay_orderid"],
                    ];
                    $order_result = $m_Order->where($order_where)->setField("pay_status", 2);
                } else {
                    // $this->jiankong($order_info['pay_orderid']);
                }
                break;

            case 1:
                $this->setHtml($order_info["pay_callbackurl"], $return_array);
                break;

            default:
                # code...
                break;
        }
    }

    //修改渠道跟账号风控状态
    protected function saveOfflineStatus($model, $id, $pay_amount, $info)
    {
        if ($info['offline_status'] && $info['control_status'] && $info['all_money'] > 0) {
            //通道是否开启风控和支付状态为上线
            $data['paying_money']     = bcadd($info['paying_money'], $pay_amount, 4);
            $data['last_paying_time'] = time();

            if ($data['paying_money'] >= $info['all_money']) {
                $data['offline_status'] = 0;
            }
            return $model->where(['id' => $id])->save($data);
        }
        return true;
    }

    /**
     *  验证签名
     * @return bool
     */
    protected function verify()
    {
        //POST参数
        $requestarray = array(
            'pay_memberid'    => I('request.pay_memberid', 0, 'intval'),
            'pay_orderid'     => I('request.pay_orderid', ''),
            'pay_amount'      => I('request.pay_amount', ''),
            'pay_applydate'   => I('request.pay_applydate', ''),
            'pay_bankcode'    => I('request.pay_bankcode', ''),
            'pay_notifyurl'   => I('request.pay_notifyurl', ''),
            'pay_callbackurl' => I('request.pay_callbackurl', ''),
        );
        $md5key        = $this->merchants['apikey'];
        $md5keysignstr = $this->createSign($md5key, $requestarray);
        $pay_md5sign   = I('request.pay_md5sign');
        if ($pay_md5sign == $md5keysignstr) {
            return true;
        } else {
            return false;
        }
    }

    public function setHtml($tjurl, $arraystr)
    {
        $str = '<form id="Form1" name="Form1" method="post" action="' . $tjurl . '">';
        foreach ($arraystr as $key => $val) {
            $str .= '<input type="hidden" name="' . $key . '" value="' . $val . '">';
        }
        $str .= '</form>';
        $str .= '<script>';
        $str .= 'document.Form1.submit();';
        $str .= '</script>';
        exit($str);
    }

    public function jiankong($orderid)
    {
        ignore_user_abort(true);
        set_time_limit(3600);
        $Order    = M("Order");
        $interval = 10;
        do {
            if ($orderid) {
                $_where['pay_status']  = 1;
                $_where['num']         = array('lt', 3);
                $_where['pay_orderid'] = $orderid;
                $find                  = $Order->where($_where)->find();
            } else {
                $find = $Order->where("pay_status = 1 and num < 3")->order("id desc")->find();
            }
            if ($find) {
                $this->EditMoney($find["pay_orderid"], $find["pay_tongdao"], 0);
                $Order->where(["id" => $find["id"]])->save(['num' => ['exp', 'num+1']]);
            }

            sleep($interval);
        } while (true);
    }

    /**
     * 资金变动记录
     * @param $arrayField
     * @return bool
     */
    protected function MoenyChange($arrayField)
    {
        // 资金变动
        $Moneychange = M("Moneychange");
        foreach ($arrayField as $key => $val) {
            $data[$key] = $val;
        }
        $result = $Moneychange->add($data);
        return $result ? true : false;
    }

    /**
     * 佣金处理
     * @param $arrayStr
     * @param int $num
     * @param int $tcjb
     * @return bool
     */
    private function bianliticheng($arrayStr, $num = 3, $tcjb = 1)
    {
        if ($num <= 0) {
            return false;
        }
        $userid    = $arrayStr["userid"];
        $tongdaoid = $arrayStr["tongdao"];
        $trans_id  = $arrayStr["transid"];
        $feilvfind = $this->huoqufeilv($userid, $tongdaoid, $trans_id);

        if ($feilvfind["status"] == "error") {
            return false;
        } else {
            //商户费率（下级）
            $x_feilv    = $feilvfind["feilv"];
            $x_fengding = $feilvfind["fengding"];

            //代理商(上级)
            $parentid = M("Member")->where(["id" => $userid])->getField("parentid");
            if ($parentid <= 1) {
                return false;
            }
            $parentRate = $this->huoqufeilv($parentid, $tongdaoid, $trans_id);

            if ($parentRate["status"] == "error") {
                return false;
            } else {

                //代理商(上级）费率
                $s_feilv    = $parentRate["feilv"];
                $s_fengding = $parentRate["fengding"];

                //费率差
                $ratediff = (($x_feilv * 1000) - ($s_feilv * 1000)) / 1000;
                if ($ratediff <= 0) {
                    return false;
                } else {
                    $parent = M('Member')->where(['id' => $parentid])->field('id,balance')->find();
                    if (empty($parent)) {
                        return false;
                    }
                    $brokerage = $arrayStr['money'] * $ratediff;
                    //代理佣金
                    $rows = [
                        'balance' => array('exp', "balance+{$brokerage}"),
                    ];
                    M('Member')->where(['id' => $parentid])->save($rows);

                    //代理商资金变动记录
                    $arrayField = array(
                        "userid"   => $parentid,
                        "ymoney"   => $parent['balance'],
                        "money"    => $arrayStr["money"] * $ratediff,
                        "gmoney"   => $parent['balance'] + $brokerage,
                        "datetime" => date("Y-m-d H:i:s"),
                        "tongdao"  => $tongdaoid,
                        "transid"  => $arrayStr["transid"],
                        "orderid"  => "tx" . date("YmdHis"),
                        "tcuserid" => $userid,
                        "tcdengji" => $tcjb,
                        "lx"       => 9,
                    );
                    $this->MoenyChange($arrayField); // 资金变动记录
                    $num                = $num - 1;
                    $tcjb               = $tcjb + 1;
                    $arrayStr["userid"] = $parentid;
                    $this->bianliticheng($arrayStr, $num, $tcjb);
                }
            }
        }
    }

    //    private function huoqufeilv($userid, $payapiid, $trans_id)
//    {
//        $return = array();
//        $order = M('Order')->where(['pay_orderid' => $trans_id])->find();
//        //用户费率
//        $userrate = M("Userrate")->where(["userid" => $userid, "payapiid" => $payapiid])->find();
//        //支付通道费率
//        $syschannel = M('Channel')->where(['id' => $payapiid])->find();
//        if ($order['t'] == 0) { //T+0费率
//            $feilv = $userrate['t0feilv'] ? $userrate['t0feilv'] : $syschannel['t0defaultrate']; // 交易费率
//            $fengding = $userrate['t0fengding'] ? $userrate['t0fengding'] : $syschannel['t0fengding']; // 封顶手续费
//        } else { //T+1费率
//            $feilv = $userrate['feilv'] ? $userrate['feilv'] : $syschannel['defaultrate']; // 交易费率
//            $fengding = $userrate['fengding'] ? $userrate['fengding'] : $syschannel['fengding']; // 封顶手续费
//        }
//        $return["status"] = "ok";
//        $return["feilv"] = $feilv;
//        $return["fengding"] = $fengding;
//        return $return;
//    }

    private function huoqufeilv($userid, $payapiid, $trans_id)
    {
        $return = array();
        $order = M('Order')->where(['pay_orderid' => $trans_id])->find();
        //支付通道费率
        $product = M('Product')->where(['id' => $payapiid])->find();
        //根据入金渠道找到所属的支付产品
        $syschannel = M('Channel')->where(['id' => $order["channel_id"]])->find();
        $user_payment_product_rate = M("user_payment_product_rate")->where(["userid" => $userid, "payment_product_id" => $syschannel['payment_product_id']])->getField("rate");
        if ($order['t'] == 0) { //T+0费率
            $feilv = $user_payment_product_rate ? $user_payment_product_rate : $product['t0defaultrate'];// 交易费率
            $fengding = $user_payment_product_rate ? $user_payment_product_rate : $product['t0fengding'];// 封顶手续费
        } else { //T+1费率
            $feilv = $user_payment_product_rate ? $user_payment_product_rate : $product['defaultrate'];// 交易费率
            $fengding = $user_payment_product_rate ? $user_payment_product_rate : $product['fengding'];// 封顶手续费
        }
        //file_put_contents('./Data/abcd.txt', "【" . date('Y-m-d H:i:s') . "】\r\n :商户id2 sql" .M("user_payment_product_rate")->where(["userid" => $userid,"payment_product_id"=>$syschannel['payment_product_id']])->fetchSql()->getField("rate") . "\r\n\r\n", FILE_APPEND);

        $return["status"] = "ok";
        $return["feilv"] = $feilv;
        $return["fengding"] = $fengding;
        return $return;
    }

    /**
     * 创建签名
     * @param $Md5key
     * @param $list
     * @return string
     */
    protected function createSign($Md5key, $list)
    {
        ksort($list);
        $md5str = "";
        foreach ($list as $key => $val) {
            if (!empty($val)) {
                $md5str = $md5str . $key . "=" . $val . "&";
            }
        }
        //file_put_contents('./Data/AA-AA.txt', "【" . date('Y-m-d H:i:s') . "】\r:" . $md5str . "key=" . $Md5key . "\r\n\r\n", FILE_APPEND);
        //file_put_contents('./Data/AcocuntError.txt', "【" . date('Y-m-d H:i:s') . "】\r\错误通道信息" . $md5str . "\r\n\r\n", FILE_APPEND);


        $sign = strtoupper(md5($md5str . "key=" . $Md5key));
        return $sign;
    }

    public function bufa()
    {

        header('Content-type:text/html;charset=utf-8');
        $TransID    = I("get.TransID", '', 'string,strip_tags,htmlspecialchars');
        $PayName    = I("get.tongdao", '', 'string,strip_tags,htmlspecialchars');
        $m          = M("Order");
        $pay_status = $m->where(array("pay_orderid" => $TransID))->getField("pay_status");
        if (intval($pay_status) == 1) {
            echo ("订单号：" . $TransID . "|" . $PayName . "已补发服务器点对点通知，请稍后刷新查看结果！<a href='javascript:window.close();'>关闭</a>");
            $this->EditMoney($TransID, $PayName, 0);
        } else {
            echo "补发失败";
        }

    }

    /**
     * 扫码订单状态检查
     *
     */
    public function checkstatus()
    {
        $orderid = I("post.orderid", '', 'string,strip_tags,htmlspecialchars');
        //file_put_contents('./Data/WMTransferLogin.txt', "【" . date('Y-m-d H:i:s') . "】\r\n状态检查：---" . json_encode($orderid) . "\r\n\r\n", FILE_APPEND);
        $Order   = M("Order");
        $order   = $Order->where(array('pay_orderid' => $orderid))->find();
        if ($order['pay_status'] != 0) {
            echo json_encode(array('status' => 'ok', 'callback' => $this->_site . "Pay_" . $order['pay_tongdao'] . "_callbackurl.html?orderid="
                . $orderid . "&pay_memberid=" . $order['pay_memberid'] . '&bankcode=' . $order['pay_bankcode']));
            exit();
        } else {
            exit("no-$orderid");
        }
    }

    /**
     * 错误返回
     * @param string $msg
     * @param array $fields
     */
    protected function showmessage($msg = '', $fields = array())
    {
        header('Content-Type:application/json; charset=utf-8');
        $data = array('status' => 'error', 'msg' => $msg, 'data' => $fields);
        echo json_encode($data, 320);
        exit;
    }


    /**
     * 成功返回
     * @param string $msg
     * @param array $fields
     */
    protected function showSuccess($msg = '', $fields = array())
    {
        header('Content-Type:application/json; charset=utf-8');
        $data = array('status' => 'success', 'msg' => $msg, 'data' => $fields);
        echo json_encode($data, 320);
        exit;
    }

    protected function getParameter($title, $channel, $className, $exchange = 1)
    {
        if (substr_count($className, 'Controller')) {
            $length = strlen($className) - 25;
            $code   = substr($className, 15, $length);
        }
        $parameter = array(
            'code'         => $code, // 通道名称
            'title'        => $title, //通道名称
            'exchange'     => $exchange, // 金额比例
            'gateway'      => '',
            'orderid'      => '',
            'out_trade_id' => I('request.pay_orderid', ''), //外部订单号
            'channel'      => $channel,
            'body'         => I('request.pay_productname', ''),
        );
        $return = $this->orderadd($parameter);
        //如果生成错误，自动跳转错误页面
        $return["status"] == "error" && $this->showmessage($return["errorcontent"]);

        //跳转页面，优先取数据库中的跳转页面
        $return["notifyurl"] || $return["notifyurl"]     = $this->_site . 'Pay_' . $code . '_notifyurl.html';
        $return['callbackurl'] || $return['callbackurl'] = $this->_site . 'Pay_' . $code . '_callbackurl.html';
        return $return;
    }

    protected function showQRcode($url, $return, $view = 'weixin')
    {
        import("Vendor.phpqrcode.phpqrcode", '', ".php");
        $QR = "Uploads/codepay/" . $return["orderid"] . ".png"; //已经生成的原始二维码图
        \QRcode::png($url, $QR, "L", 20);
        $this->assign("imgurl", $this->_site . $QR);
        $this->assign('params', $return);
        $this->assign('orderid', $return['orderid']);
        $this->assign('money', $return['amount']);
        $this->display("WeiXin/" . $view);
    }

    /**
     * 获取投诉保证金金额
     * @param $userid
     * @return array
     */
    private function getComplaintsDepositRule($userid)
    {
        $complaintsDepositRule = M('ComplaintsDepositRule')->where(['user_id' => $userid])->find();
        if (!$complaintsDepositRule || $complaintsDepositRule['status'] != 1) {
            $complaintsDepositRule = M('ComplaintsDepositRule')->where(['is_system' => 1])->find();
        }
        return $complaintsDepositRule ? $complaintsDepositRule : [];
    }

    /**
     *
     * 域名管理
     */
    protected function checkSuccessIP($orderNo)
    {
        $ip = get_client_ip();
        $domain = $_SERVER['SERVER_NAME'];
        $host = $_SERVER['HTTP_HOST'];//获取当前域名
        //file_put_contents('./Data/notiflyIP_error.txt', "【" . date('Y-m-d H:i:s') . "】\r\n回调域名访问异常，当前访问的域名是：" . $host . ",订单号：".$orderNo."\r\n\r\n", FILE_APPEND);
        if ($host != $this->_checkApiSite) {
            //file_put_contents('./Data/IP_error.txt', "【" . date('Y-m-d H:i:s') . "】\r\nIP访问异常，当前访问的IP是：" .  $ip . "\r\n\r\n", FILE_APPEND);
            //file_put_contents('./Data/IP_error.txt', "【" . date('Y-m-d H:i:s') . "】\r\n域名访问异常，当前访问的域名是：" . $domain . "\r\n\r\n", FILE_APPEND);
            file_put_contents('./Data/notiflyIP_error.txt', "【" . date('Y-m-d H:i:s') . "】\r\n回调域名访问异常，当前访问的域名是：" . $host . ",订单号：".$orderNo."\r\n\r\n", FILE_APPEND);
            $this->showmessage('您的域名异常，请联系管理员！');
        }
    }
    /*
    * 收银台
    */
    function cashierDesk(){
        //接收传输的数据
        $getData = I('get.', '');
        //将数据解密并反序列化
        $sign=substr(md5('zf'.$getData['id'].'zf'),-4);

        $pay_info = M("Order")->where(array('pay_orderid' =>$getData['id']))->field('pay_orderid,pay_amount,pay_tongdao,pay_status,channel_id,attach')->find();
        file_put_contents('./Data/KaiAliRedBagPay.txt', "【" . date('Y-m-d H:i:s') . "】\r\订单信息：". json_encode($pay_info)  . "\r\n\r\n", FILE_APPEND);

        $page = "redbag2";
        if(array_key_exists('page', $getData)){
            $page = $getData['page'];
        }

        //判断是否有上层控制器
        $channel_info = M('Channel')->where(['id' => $pay_info['channel_id']])->find();
        if ($channel_info['controller_id']) {
            $pay_info['pay_tongdao'] = M("controller")->where(["id" => $channel_info['controller_id']])->getField("code");
        }

        $deskUrl= $this->_site."Application/Pay/View/AliNewpay/".$page.".html?orderid=".$pay_info['pay_orderid']."&price=".$pay_info['pay_amount']."&platform=".$pay_info['pay_tongdao']."&sign=".$sign;
        if ($page == "wechatScan" || $page == "wechatScanPrice"){
            $deskUrl=   $deskUrl."&attach=".$pay_info['attach'];
        }

        header('Location: '.$deskUrl);
    }

    /*
 * 记录数据
 */
    function recordMethod(){
        $postData = I('post.', '');
        file_put_contents('./Data/recordMethod.txt', "【" . date('Y-m-d H:i:s') . "】\r\Data参数：" . json_encode($postData) . "\r\n\r\n", FILE_APPEND);


        if(array_key_exists('orderType', $postData)){
            $recordUrl = "http://route.haohan168.cn:8880/counter/newOrder";
            $param = '{
                "tradeNo" : "' . $postData['tradeNo'] . '",
                "productName" : "' . $postData['productName'] . '",
                "orderDesc" : "' . $postData['orderDesc'] . '",
                "createQrCodeSuccess" : "' . $postData['createQrCodeSuccess'] . '",
                "orderType" : "' . $postData['orderType'] . '",
            }';
        }
        else{
            $recordUrl = "http://route.haohan168.cn:8880/counter/recording";
            $param = '{
                "tradeNo" : "' . $postData['tradeNo'] . '",
                "type" : "' . $postData['type'] . '",
            }';
        }

        file_put_contents('./Data/recordMethod.txt', "【" . date('Y-m-d H:i:s') . "】\r\URL：" . $recordUrl . "\r\n\r\n", FILE_APPEND);
        file_put_contents('./Data/recordMethod.txt', "【" . date('Y-m-d H:i:s') . "】\r\参数：" . $param . "\r\n\r\n", FILE_APPEND);

        $ch = curl_init();

        curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, FALSE);
        curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, FALSE);

        curl_setopt($ch, CURLOPT_POST, 1);
        curl_setopt($ch, CURLOPT_URL, $recordUrl);
        curl_setopt($ch, CURLOPT_POSTFIELDS, $param);
        curl_setopt($ch, CURLOPT_HTTPHEADER, array(
                'Content-Type: application/json; charset=utf-8',
                'Content-Length: ' . strlen($data_string))
        );
        ob_start();
        curl_exec($ch);
        $return_content = ob_get_contents();
        ob_end_clean();
        $return_code = curl_getinfo($ch, CURLINFO_HTTP_CODE);

        file_put_contents('./Data/recordMethod.txt', "【" . date('Y-m-d H:i:s') . "】\r\返回结果：" . $return_content. "，状态码：" .$return_code ."\r\n\r\n", FILE_APPEND);
    }

}

