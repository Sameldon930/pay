<?php
namespace User\Controller;

class UserController extends BaseController
{
    public $fans;
    public function __construct()
    {
        parent::__construct();
        //验证登录
        $user_auth = session("user_auth");
        ksort($user_auth); //排序
        $code = http_build_query($user_auth); //url编码并生成query字符串
        $sign = sha1($code);
        if($sign != session('user_auth_sign') || !$user_auth['uid']){
            $module = trim(__MODULE__, '.');
            header("Location: ".U($module.'/Login/index'));
        }
        //用户信息
        $this->fans = M('Member')->where(['id'=>$user_auth['uid']])->field('`id` as uid, `username`, `password`, `groupid`, `parentid`,`salt`,`balance`, `blockedbalance`, `email`, `realname`, `authorized`, `apidomain`, `apikey`, `status`, `mobile`, `receiver`, `agent_cate`,`df_api`,`login_ip`,`open_charge`,`google_secret_key`,`session_random`,`regdatetime`,`google_auth`')->find();
		$this->fans['memberid'] = $user_auth['uid']+10000;

		if(session('user_auth.expire_time')<= time()) {
            session('user_auth', null);
            session('user_auth_sign', null);
            session('user_google_auth', null);
            $this->error('会话超时，请重新登录！','index.html');
        } else {
            $user_auth = session('user_auth');
            $user_auth['expire_time'] = time()+1800;
            session('user_auth', $user_auth);
            ksort($user_auth);
            $code = http_build_query($user_auth);
            $sign = sha1($code);
            session('user_auth_sign', $sign);
        }

        if(session('user_auth') && $this->fans['google_auth'] && $this->fans['google_secret_key'] &&  !session('user_google_auth')) {
            if(!(CONTROLLER_NAME == 'Account' && ACTION_NAME == 'unbindGoogle')
                &&!(CONTROLLER_NAME == 'Index' && ACTION_NAME == 'google')
                &&!(CONTROLLER_NAME == 'Login' && ACTION_NAME == 'verifycode')
                &&!(CONTROLLER_NAME == 'Account' && ACTION_NAME == 'unbindGoogleSend')
            ) {
                if(IS_AJAX){
                    $this->error('请进行谷歌身份验证', 'User/Index/google');
                }else{
                    $this->redirect('User/Index/google');
                }
            }
        }
        if(!session('user_auth.session_random') && $this->fans['session_random'] && session('user_auth.session_random') !=  $this->fans['session_random']) {
            session('user_auth', null);
            session('user_auth_sign', null);
            session('user_google_auth', null);
            $this->error('您的账号在别处登录，如非本人操作，请立即修改登录密码！','index.html');
        }
        $groupId = $this->groupId =  C('GROUP_ID');
        //获取用户的代理等级信息
        foreach($groupId as $k => $v){
            if($k>=$this->fans['groupid'])
                unset($groupId[$k]);
        }
        //获取最新5条公告
        $where['status'] = 1;
        if($this->fans['groupid'] == 4) {
            $announces = M('Article')->where(['status'=>1, 'groupid'=>['in','0,1']])->limit('0,5')->order("id desc")->select();
        } else {
            $announces = M('Article')->where(['status'=>1, 'groupid'=>['in','0,1']])->limit('0,5')->order("id desc")->select();
        }
        $this->assign('announces',$announces);
        $this->assign('groupId',$groupId);
        $this->assign('fans',$this->fans);
    }
}
?>
