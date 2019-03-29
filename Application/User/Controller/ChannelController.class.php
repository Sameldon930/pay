<?php
namespace User\Controller;
use Org\Net\UserLogService;

/**
 * 支付通道控制器
 * Class ChannelController
 * @package User\Controller
 */
class ChannelController extends UserController
{

    public function __construct()
    {
        parent::__construct();
    }

    /**
     * 通道费率
     */
    public function index()
    {
        UserLogService::write(1, '查看通道费率', '查看通道费率');
        //结算方式：
        $tkconfig = M('Tikuanconfig')->where(['userid'=>$this->fans['uid']])->find();
        if(!$tkconfig || $tkconfig['tkzt']!=1 || $tkconfig['systemxz'] != 1){
            $tkconfig = M('Tikuanconfig')->where(['issystem'=>1])->find();
        }
        //已开通通道
        $list = M('ProductUser')
            ->join('LEFT JOIN __PRODUCT__ ON __PRODUCT__.id = __PRODUCT_USER__.pid')
            ->where(['pay_product_user.userid'=>$this->fans['uid'],'pay_product_user.status'=>1,'pay_product.isdisplay'=>1])
            ->field('pay_product.name,pay_product.id,pay_product.t0defaultrate,pay_product.t0fengding,pay_product.defaultrate,pay_product.fengding,pay_product_user.status')
            ->select();
//        if(empty($list)) {
//            $list = M('product')->where("`status`=1 AND (`channel`>0 OR (`polling`=1 AND `weight`!=''))")->select();
//        }
        if(!empty($list)) {
            foreach ($list as $key => $item) {
                $_userrate = M('Userrate')->where(['userid' => $this->fans['uid'], 'payapiid' => $item['id']])->find();
                if ($tkconfig['t1zt'] == 0) { //T+0费率
                    $feilv = $_userrate['t0feilv'] ? $_userrate['t0feilv'] : $item['t0defaultrate']; // 交易费率
                } else { //T+1费率
                    $feilv = $_userrate['feilv'] ? $_userrate['feilv'] : $item['defaultrate']; // 交易费率
                }
                if ($this->fans['groupid'] != 4) {
                    $list[$key]['t0feilv'] = $_userrate['t0feilv'] ? $_userrate['t0feilv'] : $item['t0defaultrate'];
                    $list[$key]['feilv'] = $_userrate['feilv'] ? $_userrate['feilv'] : $item['defaultrate'];
                    $list[$key]['fengding'] = $_userrate['fengding'] ? $_userrate['fengding'] : $item['fengding'];
                    $list[$key]['t0fengding'] = $_userrate['t0fengding'] ? $_userrate['t0fengding'] : $item['t0fengding'];
                } else {
                    $list[$key]['feilv'] = $feilv;
                }
            }
        }


        $this->assign('tkconfig',$tkconfig);
        $this->assign('list',$list);
        $this->display();
    }

    /**
     * 开发文档
     */
    public function apidocumnet()
    {
        if($this->fans[groupid] != 4) {
            $this->error('您没有权限访问该页面!');
        }
        UserLogService::write(1, '查看API密钥', '查看API密钥');
        $sms_is_open = smsStatus();//短信开启状态
        $info = M('Member')->where(['id'=>$this->fans['uid']])->find();
        $this->assign('sms_is_open',$sms_is_open);
        $this->assign('mobile', $this->fans['mobile']);
        $this->assign('info',$info);
        $this->display();
    }

    public function apikey()
    {
        if(!$this->fans['authorized']) {
            UserLogService::write(1, '查看APIKEY失败', '原因：未认证');
            $this->ajaxReturn(['status'=>0,'msg'=>'您未认证，不能查看密钥！']);
        }
        if($this->fans['authorized'] == 2) {
            UserLogService::write(1, '查看APIKEY失败', '原因：认证审核中');
            $this->ajaxReturn(['status'=>0,'msg'=>'您的认证信息正在审核中，暂时不能查看密钥！']);
        }
        $code = I('request.code','','string');
        $res = check_auth_error($this->fans['uid'], 6);
        if(!$res['status']) {
            UserLogService::write(1, '查看APIKEY失败', '原因：支付密码输入错误次数超限');
            $this->ajaxReturn(['status' => 0, 'msg' => $res['msg']]);
        }
        $data = M('Member')->field('paypassword')->where(['id'=>$this->fans['uid']])->find();
        if(md5($code) != $data['paypassword']){
            log_auth_error($this->fans['uid'],6);
            UserLogService::write(1, '查看APIKEY失败', '原因：支付密码错误');
            $this->ajaxReturn(['status'=>0,'msg'=>'支付密码错误']);
        } else {
            clear_auth_error($this->fans['uid'],6);
        }
        $apikey = M('Member')->where(['id'=>$this->fans['uid']])->getField('apikey');
        $this->ajaxReturn(['status' => 1, 'apikey' => $apikey]);
    }

}