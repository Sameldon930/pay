<?php
/**
 * Created by PhpStorm.
 * User: gaoxi
 * Date: 2017-08-15
 * Time: 22:27
 */
namespace Admin\Controller;

use Think\Controller;
use Think\Verify;

class LoginController extends Controller
{
    public function __construct()
    {
        parent::__construct();
        $this->assign('siteurl', $this->_site);
        $this->assign('sitename', C('WEB_TITLE'));
    }

    //登录页
    public function index()
    {
        $csrf_token = gen_token();
        session('admin_csrf_token', $csrf_token);//验证码token
        session('admin_csrf_token_times', 0);//token使用次数
        $this->assign('csrf_token', $csrf_token);
        $this->display();
    }

    //登录检查
    public function checkLogin()
    {
        if (IS_POST) {
            $username      = I("post.username", '', 'trim');
            $loginpassword = I("post.password", '', 'trim');
            $verification  = I("post.verify", '', 'trim');
            $verify        = new Verify();
            if (empty($username) || empty($loginpassword)) {
                $this->ajaxReturn(['errorno' => 1, 'msg' => '账号和密码不能为空！', 'url' => '']);
            }
            //验证码校验
            if (!$verify->check($verification)) {
                 $this->ajaxReturn(['errorno' => 1, 'msg' => '验证码输入错误！', 'url' => '']);
            }
            $admin = M("admin");
            $info  = $admin->where(array("username" => $username))->find();
            
            if ($info) {
                //登录错误次数检查
                $res = check_auth_error($info['id'], 1);
                if(!$res['status']) {
                    $this->ajaxReturn(['errorno' => 1, 'msg' => $res['msg'], 'url' => '']);
                }
                if($info['password'] != md5( $loginpassword. C('DATA_AUTH_KEY'))) {
                    log_auth_error($info['id'],1);
                    $this->ajaxReturn(['errorno' => 1, 'msg' => '你的帐号或密码不正确！', 'url' => '']);
                } else {
                    clear_auth_error($info['id'],1);
                }
                // 登录记录
                $rows['userid']        = $info['id'];
                $rows['logindatetime'] = date("Y-m-d H:i:s");
                $IpLocation                   = new \Org\Net\IpLocation('UTFWry.dat'); // 实例化类 参数表示IP地址库文件
                if(isset($_SERVER['REMOTE_ADDR']) && $_SERVER['REMOTE_ADDR']) {
                    $ip = $_SERVER['REMOTE_ADDR'];
                } else {
                    $ip = get_client_ip();
                }
                $location              = $IpLocation->getlocation($ip); // 获取某个IP地址所在的位置
                $Websiteconfig = M('Websiteconfig');
                $loginIp = $Websiteconfig->where(['id'=>1])->getField('login_ip');   

                if (trim($loginIp)) {
                    $arrayip = explode("\r\n", $loginIp);
                    $ipregexp = implode('|', str_replace( array('*','.'), array('\d+','\.') ,$arrayip) );
                    if(!preg_match("/^(".$ipregexp.")$/", $ip)) {
                        $this->ajaxReturn(['errorno' => 1, 'msg' => '登录失败，IP ERROR', 'url' => '']);
                    }
                }
                $rows['loginip']      = $location['ip'];
                $rows['loginaddress'] = $location['country'];
                $rows['type'] = 1;
                M("Loginrecord")->add($rows);
                $session_random = randpw(32);
                $admin->where(array("username" => $username))->setField('session_random', $session_random);
                $admin_indo = [
                    'uid'      => $info['id'],
                    'username' => $info['username'],
                    'groupid'  => $info['groupid'],
                    'password' => $info['password'],
                    'session_random' => $session_random,
                    'expire_time' => time()+1800,//半个小时不操作登录失效
                ];

                //登录后重置session_id
                session_regenerate_id(true);
                session('admin_auth', $admin_indo);
                //session auth
                ksort($admin_indo); //排序
                $code = http_build_query($admin_indo); //url编码并生成query字符串
                $sign = sha1($code);
                session('admin_auth_sign', $sign);
                //常用地址
                $localCountry = [];
                //获取最近登录地址
                $latestLoginData = M("Loginrecord")->where(['userid' => $info['id'], 'type'=>1])->order('id desc')->limit(3)->select();
                $address         = @array_column((array) $latestLoginData, 'loginaddress', 'id');
                $address = @array_values($address);
                $country         = @array_map(function ($item) {
                    $adress = explode('-', $item);
                    $count = 0;
                    foreach ($adress as $v) {
                        if($v) {$count++;}
                    }
                    if($count>1) {
                        return $adress[1];
                    } else {
                        return $adress[0];
                    }
                }, $address);
                //获取数组中的重复数据
                $repeatItem = @array_unique($country);
                if ($repeatItem) {
                    //获取最近三次登录重复的地址
                    $localCountry = array_diff_assoc($country, $repeatItem);
                }
                //如果异地登录就发送通知信息
                $sms_is_open = smsStatus();
                $product     = ['time' => date('Y-m-d H:i:s'), 'address' => $location[1] . $location[2]];
                if ($localCountry && !in_array($location['country'], $localCountry) && $info['mobile'] && $sms_is_open) {
                    $this->sendStr('loginWarning', $info['mobile'], $product);
                }
                $siteconfig = M("Websiteconfig")->find();
				if($siteconfig['google_auth'] && !session('google_auth')) {
					$this->ajaxReturn(['errorno' => 0, 'msg' => '登录成功，进行二次身份验证', 'url' => U('Auth/google')]);
				} else {
					$this->ajaxReturn(['errorno' => 0, 'msg' => '登录成功!', 'url' => U('Index/index')]);
				}
            } else {
                $this->ajaxReturn(['errorno' => 1, 'msg' => '你的帐号或密码不正确！', 'url' => '']);
            }

        }
    }
    //退出登录
    public function loginout()
    {
        session('admin_auth', null);
        session('google_auth', null);
        $this->success('正在退出...', '/' . C("LOGINNAME"));
    }

    //验证码
    public function verifycode()
    {
        $csrf_token = I('get.csrf_token','');
        if(!$csrf_token || !session('admin_csrf_token')) {
            exit('error');
        }
        if(session('admin_csrf_token') != $csrf_token) {
            exit('error');
        }
        $admin_csrf_token_times = session('admin_csrf_token_times');
        if(is_null($admin_csrf_token_times) || $admin_csrf_token_times>20) {//token最大使用次数20
            exit('error');
        }
        session('admin_csrf_token_times', $admin_csrf_token_times+1);
        $config = array(
            'length'   => 4, // 验证码位数
            'useNoise' => true, // 是否添加杂点
            'useImgBg' => false, // 使用背景图片
            'useZh'    => false, // 使用中文验证码
            'useCurve' => false, // 是否画混淆曲线
        );
        ob_clean();
        $verify = new Verify($config);
        $verify->entry();
    }

    /**
     * 发送文本信息
     * @param  [type] $callIndex [description]
     * @param  [type] $mobile    [description]
     * @param  [type] $product   [description]
     * @return [type]            [description]
     */
    protected function sendStr($callIndex, $mobile, $product)
    {
        $templeData    = getSmsTemplateCode($callIndex);
        $templateCode  = $templeData['template_code'];
        $templeContent = ['time' => $product['time'], 'address' => $product['address']];
        //发送
        $res = sendSMS($mobile, $templateCode, $templeContent);
        if ($res === true) {
            return ['code' => 1, 'message' => '发送成功'];
        } else {
            return ['code' => 0, 'message' => $res];
        }
    }
}
