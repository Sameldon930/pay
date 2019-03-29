<?php
namespace Pay\Controller;

class IndexController extends PayController
{
    protected $channel; //

    protected $memberid; //商户ID

    protected $pay_amount; //交易金额

    protected $bankcode; //银行码

    protected $orderid; //订单号



    public function __construct()
    {
        parent::__construct();


        if (empty($_POST)) {
            $this->showmessage('no data!');
        }

        file_put_contents('./Data/index_log.txt', "【" . date('Y-m-d H:i:s') . "】\r\下单参数!" . json_encode(I('param.')) . "\r\n\r\n", FILE_APPEND);


        $this->firstCheckParams(); //初步验证参数 ，设置memberid，pay_amount，bankcode属性

        $this->checkSuccessIP($this->memberid);//检查当前IP

        $this->judgeRepeatOrder(); //验证是否可以提交重复订单

        $this->userRiskcontrol(); //用户风控检测

        $this->productIsOpen(); //判断通道是否开启

        $this->setChannelApiControl(); //判断是否开启支付渠道 ，获取并设置支付通api的id和通道风控
    }

    public function index()
    {
        //进入支付
        if ($this->channel['api']) {
            $info = M('Channel')->where(['id' => $this->channel['api'], 'status' => 1])->find();
            //判断对应支付产品是否开启
            if (!M("payment_product")->where(["id" => $info['payment_product_id']])->getField('status')) {
                $this->showmessage('支付产品未开启', ['payment_product_id' => $info['payment_product_id']]);
            }
            //判断是否有上层控制器
            if ($info['controller_id']) {
                $info['code'] = M("controller")->where(["id" => $info['controller_id']])->getField("code");
            }

            //是否存在通道文件
            if (!is_file(APP_PATH . '/' . MODULE_NAME . '/Controller/' . $info['code'] . 'Controller.class.php')) {
                $this->showmessage('支付通道不存在,cao------', ['pay_bankcode' => $this->channel['api']]);
                //file_put_contents('./Data/AAA.txt', "【" . date('Y-m-d H:i:s') . "】\r/***********************支付通道不存在,cao------*********************/\r\n\r\n", FILE_APPEND);
            }

            /**swk的演示收银台处理 开始*/
            if(!empty($_POST['pay_channel'])){
                //file_put_contents('./Data/AaronTest.txt', "【" . date('Y-m-d H:i:s') . "】\r\channel收银台传：!" . json_encode($_POST) . "\r\n\r\n", FILE_APPEND);
                $this->channel['api'] = $_POST['pay_channel'];
            }
            /**swk的演示收银台处理 结束*/
            if (R($info['code'] . '/Pay', [$this->channel]) === false) {
                $this->showmessage('服务器开小差了...');
            }
        } else {
            $this->showmessage("抱歉......服务器飞去月球了");
        }
    }

    //======================================辅助方法===================================

    /**
     * [初步判断提交的参数是否合法并设置为属性]
     */
    protected function firstCheckParams()
    {
        $this->memberid = I("request.pay_memberid", 0, 'intval') - 10000;
        // 商户编号不能为空
        if (empty($this->memberid) || $this->memberid <= 0) {
            $this->showmessage("不存在的商户编号!");
        }

        $this->pay_amount = I('post.pay_amount', 0);
        if ($this->pay_amount == 0) {
            $this->showmessage('金额不能为空');
        }

        //银行编码
        $this->bankcode = I('request.pay_bankcode', 0, 'intval');
        if ($this->bankcode == 0) {
            $this->showmessage('不存在的银行编码!', ['pay_banckcode' => $this->bankcode]);
        }

        $this->orderid = I('post.pay_orderid', '');
        if (!$this->orderid) {
            $this->showmessage('订单号不合法！');
        }

    }

    /**
     * [用户风控]
     */
    protected function userRiskcontrol()
    {
        $l_UserRiskcontrol = new \Pay\Logic\UserRiskcontrolLogic($this->pay_amount, $this->memberid); //用户风控类
        $error_msg         = $l_UserRiskcontrol->monitoringData();
        if ($error_msg !== true) {
            $this->showmessage('商户：' . $error_msg);
        }
    }

    /**
     * [productIsOpen 判断通道是否开启，并分配]
     * @return [type] [description]
     */
    protected function productIsOpen()
    {
        $product = M('Product')->where(['id' => $this->bankcode, 'status' => 1])->field('id,polling,weight,channel')->find();
        //通道关闭
        if (empty($product)) {
            $this->showmessage('暂时无法连接支付服务器!');
        }
        $this->channel = M('ProductUser')->where(['pid' => $this->bankcode, 'userid' => $this->memberid, 'status' => 1])->find();
        //用户未分配
        if (!$this->channel) {
            $this->showmessage('该通道已关闭!');
        }
        /*
        if (!$this->channel) {
            $l_ChannelRiskcontrol = new \Pay\Logic\ChannelRiskcontrolLogic($this->pay_amount); //支付渠道风控类
            $m_Channel            = M('Channel');
            if($product['polling']) {
                $temp_weights = explode('|', $product['weight']);
                foreach ($temp_weights as $k => $v) {

                    list($pid, $weight) = explode(':', $v);
                    //检查是否开通
                    $temp_info = $m_Channel->where(['id' => $pid, 'status' => 1])->find();

                    //判断通道是否开启风控并上线
                    if ($temp_info['offline_status'] == 1 && $temp_info['control_status'] == 1) {

                        //-------------------------进行风控-----------------
                        $l_ChannelRiskcontrol->setConfigInfo($temp_info); //设置配置属性
                        $error_msg = $l_ChannelRiskcontrol->monitoringData();
                        if ($error_msg === true) {
                            $weight_item[] = ['pid' => $pid, 'weight' => $weight];

                        }
                    } else if ($temp_info['control_status'] == 0) {
                        $weight_item[] = ['pid' => $pid, 'weight' => $weight];
                    }

                }
                //如果所有通道风控，提示最后一个消息
                if ($weight_item == []) {
                    $this->showmessage('通道:' . $error_msg);
                }
                $weight_item          = getWeight($weight_item);
                $this->channel = [
                    'userid' => $this->memberid,
                    'channel' => $weight_item['pid'],
					'pid'	=> $product['id']
                ];
            } elseif($product['polling']==0 && $product['channel']>0) {
                //查询通道信息
                $pid          = $product['channel'];
                $channel_info = $m_Channel->where(['id' => $pid, 'status' => 1])->find();
                if(empty($channel_info)) {
                    $this->showmessage('暂时无法连接支付服务器!');
                }
                //通道风控
                $l_ChannelRiskcontrol->setConfigInfo($channel_info); //设置配置属性
                $error_msg = $l_ChannelRiskcontrol->monitoringData();

                if ($error_msg !== true) {
                    $this->showmessage('通道:' . $error_msg);
                }
                $this->channel = [
                    'userid' => $this->memberid,
                    'channel' => $pid,
					'pid'	=> $product['id']
                ];
            } else {
                $this->showmessage('暂时无法连接支付服务器!');
            }
        }
        */
    }

    /**
     * [判断是否开启支付渠道 ，获取并设置支付通api的id---->轮询+风控]
     */
    protected function setChannelApiControl()
    {
        $l_ChannelRiskcontrol = new \Pay\Logic\ChannelRiskcontrolLogic($this->pay_amount); //支付渠道风控类
        $m_Channel            = M('Channel');

        if (isset($this->channel['polling']) && $this->channel['polling'] == 1 && isset($this->channel['weight']) && $this->channel['weight']) {

            /***********************多渠道,轮询，权重随机*********************/
            $weight_item  = [];
            $error_msg    = '已经下线';
            $temp_weights = explode('|', $this->channel['weight']);
            foreach ($temp_weights as $k => $v) {

                list($pid, $weight) = explode(':', $v);
                //检查是否开通
                $temp_info = $m_Channel->where(['id' => $pid, 'status' => 1])->find();
                //T除已关闭的通道
                if(!$temp_info){
                    file_put_contents('./Data/BBB.txt', "【" . date('Y-m-d H:i:s') . "】\r\T除的通道id是：" .  $pid . "\r\n\r\n", FILE_APPEND);
                    continue;
                }
                //判断通道是否开启风控并上线
                if ($temp_info['offline_status'] == 1 && $temp_info['control_status'] == 1) {

                    //-------------------------进行风控-----------------
                    $l_ChannelRiskcontrol->setConfigInfo($temp_info); //设置配置属性
                    $error_msg = $l_ChannelRiskcontrol->monitoringData();
                    if ($error_msg === true) {
                        $weight_item[] = ['pid' => $pid, 'weight' => $weight];

                    }

                } else if ($temp_info['control_status'] == 0) {
                    $weight_item[] = ['pid' => $pid, 'weight' => $weight];
                }

            }

            //如果所有通道风控，提示最后一个消息
            if ($weight_item == []) {
                $this->showmessage('通道:' . $error_msg);
            }
            $weight_item          = getWeight($weight_item);
            $this->channel['api'] = $weight_item['pid'];

        } else {
            /***********************单渠道,没有轮询*********************/

            //查询通道信息
            $pid          = $this->channel['channel'];
            $channel_info = $m_Channel->where(['id' => $pid])->find();

            //通道风控
            $l_ChannelRiskcontrol->setConfigInfo($channel_info); //设置配置属性
            $error_msg = $l_ChannelRiskcontrol->monitoringData();

            if ($error_msg !== true) {
                $this->showmessage('通道:' . $error_msg);
            }
            $this->channel['api'] = $pid;
        }
    }

    /**
     * 判断是否可以重复提交订单
     * @return [type] [description]
     */
    public function judgeRepeatOrder()
    {
        $is_repeat_order = M('Websiteconfig')->getField('is_repeat_order');
        if (!$is_repeat_order) {
            //不允许同一个用户提交重复订单
            $pay_memberid = $this->memberid + 10000;
            $count = M('Order')->where(['pay_memberid' => $pay_memberid, 'out_trade_id' => $this->orderid])->find();
            if($count){
                $this->showmessage('重复订单！');
            }
        }
    }

    /**
     *
     * 域名管理
     */
    protected function checkSuccessIP($memo)
    {
        $ip = get_client_ip();
        $domain = $_SERVER['SERVER_NAME'];
        $host = $_SERVER['HTTP_HOST'];//获取当前域名

        if ($host != $this->_checkApiSite) {
            //file_put_contents('./Data/IP_error.txt', "【" . date('Y-m-d H:i:s') . "】\r\nIP访问异常，当前访问的IP是：" .  $ip . "\r\n\r\n", FILE_APPEND);
            //file_put_contents('./Data/IP_error.txt', "【" . date('Y-m-d H:i:s') . "】\r\n域名访问异常，当前访问的域名是：" . $domain . "\r\n\r\n", FILE_APPEND);
            file_put_contents('./Data/IP_error.txt', "【" . date('Y-m-d H:i:s') . "】\r\n下单域名访问异常，当前访问的域名是：" . $host . ",商户号/订单号：".$memo."\r\n\r\n", FILE_APPEND);
            $this->showmessage('您的域名异常，请联系管理员！');
        }
    }

    /**
     *
     * 输出请求头
     */
    protected function em_getallheaders()
    {
        $headers = [];
        foreach ($_SERVER as $name => $value) {
            if (substr($name, 0, 5) == 'HTTP_') {
                $headers[str_replace(' ', '-', ucwords(strtolower(str_replace('_', ' ', substr($name, 5)))))] = $value;
            }
        }
        file_put_contents('./Data/IP_error.txt', "【" . date('Y-m-d H:i:s') . "】\r\n请求头：" . json_encode($headers) . "\r\n\r\n", FILE_APPEND);
    }

}

