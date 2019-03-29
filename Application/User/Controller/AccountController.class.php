<?php
/**
 * Created by PhpStorm.
 * User: gaoxi
 * Date: 2017-08-22
 * Time: 14:34
 */
namespace User\Controller;

use Intervention\Image\ImageManagerStatic;
use Think\Page;
use Think\Upload;
use Org\Net\UserLogService;


/**
 *  商家账号相关控制器
 * Class AccountController
 * @package User\Controller
 */

class AccountController extends UserController
{
    public function __construct()
    {
        parent::__construct();
    }

    /**
     * 编辑个人资料
     */
    public function profile()
    {
        UserLogService::write(1, '访问编辑个人资料页面', '访问编辑个人资料页面');
        $list = M("Member")->where(['id' => $this->fans['uid']])->find();
        $verifysms = 0;
        //查询是否开启短信验证
        $sms_is_open = smsStatus();
        if ($sms_is_open) {
            $verifysms = 1;
            $this->assign('sendUrl', U('User/Account/profileSend'));
        }
        $verifyGoogle = 0;
        if($this->fans['google_secret_key'] && $this->fans['google_auth']) {
            $verifyGoogle = 1;
        }
        $this->assign('sms_is_open', $sms_is_open);
        $this->assign('verifysms', $verifysms);
        $this->assign('verifyGoogle', $verifyGoogle);
        $this->assign('auth_type', $verifyGoogle ? 1 : 0);
        //查询是否开启代付API
        $df_api = M('websiteconfig')->getField('df_api');
        $this->assign('df_api', $df_api);
        $this->assign('sms_is_open', $sms_is_open);
        $list['agentname'] = '';
        if($this->fans['parentid']>0) {
            $list['agentname'] = M('Member')->where(['id' => $this->fans['parentid']])->getField('username');
        }
        $this->assign("p", $list);
        $this->display();
    }

    /**
     * 发送编辑个人资料验证码信息
     */
    public function profileSend()
    {
        $res = $this->send('saveProfile', $this->fans['mobile'], '编辑个人资料验');
        $this->ajaxReturn(['status' => $res['code']]);
    }

    /**
     * 保存个人资料
     */
    public function saveProfile()
    {
        if (IS_POST) {
            //用户的ID
            $userid = session('user_auth.uid');
            //查询是否开启短信验证
            $sms_is_open = smsStatus();
            $verifysms = 0;
            if ($sms_is_open) {
                $verifysms = 1;
            }
            //查询是否开通谷歌验证
            $verifyGoogle = 0;
            if($this->fans['google_secret_key'] && $this->fans['google_auth']) {
                $verifyGoogle = 1;
            }
            $auth_type = I('post.auth_type', 0, 'intval');
            if($verifyGoogle && $verifysms) {
                if(!in_array($auth_type,[0,1])) {
                    UserLogService::write(3, '保存个人资料失败', '原因：参数错误');
                    $this->ajaxReturn(['status' => 0, 'msg' => "参数错误！"]);
                }
            } elseif($verifyGoogle && !$verifysms) {
                if($auth_type != 1) {
                    UserLogService::write(3, '保存个人资料失败', '原因：参数错误');
                    $this->ajaxReturn(['status' => 0, 'msg' => "参数错误！"]);
                }
            } elseif(!$verifyGoogle && $verifysms) {
                if($auth_type != 0) {
                    UserLogService::write(3, '保存个人资料失败', '原因：参数错误');
                    $this->ajaxReturn(['status' => 0, 'msg' => "参数错误！"]);
                }
            }
            if ($verifyGoogle && $auth_type == 1) {//谷歌安全码验证
                $res = check_auth_error($userid, 4);
                if(!$res['status']) {
                    UserLogService::write(3, '保存个人资料失败', '原因：谷歌安全码输入错误次数超限');
                    $this->ajaxReturn(['status' => 0, 'msg' => $res['msg']]);
                }
                $google_code   = I('post.google_code');
                if(!$google_code) {
                    UserLogService::write(3, '保存个人资料失败', '原因：谷歌安全码不能为空');
                    $this->ajaxReturn(['status' => 0, 'msg' => "谷歌安全码不能为空！"]);
                } else {
                    $ga = new \Org\Util\GoogleAuthenticator();
                    if(false === $ga->verifyCode($this->fans['google_secret_key'], $google_code, C('google_discrepancy'))) {
                        log_auth_error($userid,4);
                        UserLogService::write(3, '保存个人资料失败', '原因：谷歌安全码错误');
                        $this->ajaxReturn(['status' => 0, 'msg' => "谷歌安全码错误！"]);
                    } else {
                        clear_auth_error($userid,4);
                    }
                }
            } elseif($verifysms && $auth_type == 0){//短信验证码
                $res = check_auth_error($userid, 2);
                if(!$res['status']) {
                    UserLogService::write(3, '保存个人资料失败', '原因：短信验证码输入错误次数超限');
                    $this->ajaxReturn(['status' => 0, 'msg' => $res['msg']]);
                }
                $code   = I('post.code');
                if(!$code) {
                    UserLogService::write(3, '保存个人资料失败', '原因：短信验证码不能为空');
                    $this->ajaxReturn(['status' => 0, 'msg'=>"短信验证码不能为空！"]);
                } else {
                    if (session('send.saveProfile') != $code || !$this->checkSessionTime('saveProfile', $code)) {
                        log_auth_error($userid,2);
                        UserLogService::write(3, '保存个人资料失败', '原因：短信验证码错误');
                        $this->ajaxReturn(['status' => 0, 'msg' => '短信验证码错误']);
                    } else {
                        clear_auth_error($userid,2);
                        session('send', null);
                    }
                }
            }
            $p             = I('post.p');
            $p['parentid'] = $this->fans['parentid'];
            if($p['agentname'] != '') {
                $agent_name = M('Member')->where(['id' => $this->fans['parentid']])->getField('username');
                $new_agent_id = M('Member')->where(['username' => $p['agentname']])->getField('id');
                if(!$new_agent_id) {
                    UserLogService::write(3, '保存个人资料失败', '原因：代理商不存在');
                    $this->ajaxReturn(['status' => 0, 'msg' => '代理商不存在']);
                }
                if($new_agent_id>0 && $agent_name != $p['agentname']) {
                    $p['parentid'] = $new_agent_id;
                }
            } else {
                $p['parentid'] = 1;
            }
            unset($p['agentname']);
            $p['birthday'] = strtotime($p['birthday']);
            $allowField = ['agentname', 'realname', 'sfznumber','mobile', 'qq', 'birthday', 'sex', 'address', 'login_ip', 'df_api', 'df_auto_check', 'df_domain', 'df_ip'];//允许修改的字段
            foreach($p as $k => $v) {
                if(!in_array($k,$allowField)) {
                    unset($p[$k]);
                }
            }
            $res           = M('Member')->where(['id' => $this->fans['uid']])->save($p);
            if(FALSE !== $res) {
                UserLogService::write(3, '保存个人资料成功', '保存个人资料成功');
                $this->ajaxReturn(['status' => 1, 'msg' => '编辑成功']);
            } else {
                UserLogService::write(3, '保存个人资料失败', '保存个人资料失败');
                $this->ajaxReturn(['status' => 0, 'msg' => '编辑失败']);
            }

        }
    }

    /**
     *  银行卡列表
     */
    public function bankcard()
    {
        UserLogService::write(1, '访问银行卡列表页面', '访问银行卡列表页面');
        $list = M('Bankcard')
            ->where(['userid' => $this->fans['uid']])
            ->order('id desc')
            ->select();
        $this->assign("list", $list);
        $this->display();
    }

    /**
     *  添加银行卡
     */
    public function addBankcard()
    {

        $banklist = M("Systembank")->select();
        $this->assign("banklist", $banklist);

        if (IS_POST) {
            $id   = I('post.id', 0, 'intval');
            if($id > 0) {
                $handle = '编辑';
                $type = 3;
            } else {
                $handle = '添加';
                $type = 2;
            }
            $rows = I('post.b/a','','trim');
            //验证验证码
            $code        = I('post.code', '', 'string,strip_tags,htmlspecialchars');
            $sms_is_open = smsStatus(); //短信开启状态
            if ($sms_is_open) {
                $res = check_auth_error($this->fans['uid'], 2);
                if(!$res['status']) {
                    UserLogService::write($type, $handle.'银行卡失败', $handle.'原因：短信验证码输入错误次数超限');
                    $this->ajaxReturn(['status' => 0, 'msg' => $res['msg']]);
                }
                if (session('send.addBankcardSend') == $code && $this->checkSessionTime('addBankcardSend', $code)) {
                    clear_auth_error($this->fans['uid'],2);
                    session('send',null);
                } else {
                    log_auth_error($this->fans['uid'],2);
                    UserLogService::write($type, $handle.'银行卡失败', $handle.'原因：验证码错误');
                    $this->ajaxReturn(['status' => 0, 'msg' => '验证码错误']);
                }
            }
            if(!$rows['province_code']) {
                UserLogService::write($type, $handle.'银行卡失败', $handle.'原因：未选择省份');
                $this->ajaxReturn(['status' => 0, 'msg' => '请选择省份']);
            }
            if(!$rows['city_code']) {
                UserLogService::write($type, $handle.'银行卡失败', $handle.'原因：未选择城市');
                $this->ajaxReturn(['status' => 0, 'msg' => '请选择城市']);
            }
            $rows['province'] = M('areaProvince')->where(['code'=>$rows['province_code']])->getField('name');
            if(!$rows['province']) {
                UserLogService::write($type, $handle.'银行卡失败', $handle.'原因：省份错误');
                $this->ajaxReturn(['status' => 0, 'msg' => '省份错误']);
            }
            $rows['city'] = M('areaCity')->where(['code'=>$rows['city_code']])->getField('name');
            if(!$rows['city']) {
                UserLogService::write($type, $handle.'银行卡失败', $handle.'原因：城市错误');
                $this->ajaxReturn(['status' => 0, 'msg' => '城市错误']);
            }
            if ($id) {
                $res = M('Bankcard')->where(['id' => $id, 'userid' => $this->fans['uid']])->save($rows);
            } else {
                $rows['userid'] = $this->fans['uid'];
                $res            = M('Bankcard')->add($rows);
            }
            if(FALSE !== $res) {
                UserLogService::write($type, $handle.'银行卡成功', $handle.'银行卡成功');
                $this->ajaxReturn(['status' => 1, 'msg' => $handle.'银行卡成功']);
            } else {
                UserLogService::write($type, $handle.'银行卡失败', $handle.'银行卡失败');
                $this->ajaxReturn(['status' => 0, 'msg' => $handle.'银行卡失败']);
            }

        } else {
            $id = I('get.id', 0, 'intval');
            if($id > 0) {
                $handle = '编辑';
            } else {
                $handle = '添加';
            }
            UserLogService::write(1, '访问'.$handle.'银行卡页面', id>0 ? 'ID：'.$id :'访问'.$handle.'银行卡页面');
            //查询是否开启短信验证
            $sms_is_open = smsStatus();
            if ($sms_is_open) {
                $this->assign('sendUrl', U('User/Account/addBankcardSend'));
            }
            $this->assign('sms_is_open', $sms_is_open);
            if ($id) {
                $data = M('Bankcard')->where(['id' => $id, 'userid' => $this->fans['uid']])->find();
                $this->assign('b', $data);
                $cityList = [];
                if($data['province_code']) {
                    $cityList = M('areaCity')->where(['province_code' => $data['province_code']])->select();
                }
                $this->assign("cityList", $cityList);
            }
            $provinceList = M('areaProvince')->select();
            $this->assign("provinceList", $provinceList);
            $this->display();
        }

    }

    /**
     * 发送申请结算验证码信息
     */
    public function addBankcardSend()
    {
        $res = $this->send('addBankcardSend', $this->fans['mobile'], '申请结算');
        $this->ajaxReturn(['status' => $res['code']]);
    }

    /**
     *绑定手机
     */
    public function bindMobileShow()
    {
        if (IS_POST) {
            //验证验证码
            $code   = I('request.code', '', 'string,strip_tags,htmlspecialchars');
            $mobile = I('request.mobile', '', 'string,strip_tags,htmlspecialchars');
            $res = check_auth_error($this->fans['uid'], 2);
            if(!$res['status']) {
                UserLogService::write(3, '绑定手机失败', '原因：输入短信验证码错误次数超限');
                $this->ajaxReturn(['status' => 0, 'msg' => $res['msg']]);
            }
            if (session('send.bindMobile') == $code && $this->checkSessionTime('bindMobile', $code)) {
                session('send', null);
                clear_auth_error($this->fans['uid'],2);
                $res = M('Member')->where(['id' => $this->fans['uid']])->save(['mobile' => $mobile]);
                if(FALSE !== $res) {
                    UserLogService::write(3, '绑定手机成功', '绑定手机成功');
                    $this->ajaxReturn(['status' => 1]);
                } else {
                    UserLogService::write(3, '绑定手机失败', '绑定手机失败');
                    $this->ajaxReturn(['status' => 0]);
                }
            } else {
                log_auth_error($this->fans['uid'],2);
                UserLogService::write(3, '绑定手机失败', '原因：短信验证码错误');
                $this->ajaxReturn(['status' => 0]);
            }
        } else {
            UserLogService::write(1, '访问绑定手机页面', '访问绑定手机页面');
            $sms_is_open = smsStatus();
            if ($sms_is_open) {
                $id = I('request.id', '');
                $this->assign('sendUrl', U('User/Account/bindMobile'));
                $this->assign('first_bind_mobile', 1);
                $this->assign('sms_is_open', $sms_is_open);
                $this->display();
            }
        }
    }

    /**
     *修改手机新手机
     */
    public function editMobileShow()
    {
        $sms_is_open = smsStatus();
        if (IS_POST) {
            $code = I('request.code', '', 'string,strip_tags,htmlspecialchars');
            $res = check_auth_error($this->fans['uid'], 2);
            if(!$res['status']) {
                UserLogService::write(3, '修改手机号码失败', '原因：短信验证码输入错误次数超限');
                $this->ajaxReturn(['status' => 0, 'msg' => $res['msg']]);
            }
            if (session('send.editMobile') == $code && $this->checkSessionTime('editMobile', $code)) {
                session('send.editMobile', null);
                //判断是验证码新手机还是旧手机后的处理
                if (session('editmobile') == '1') {
                    $mobile           = I('request.mobile', '', 'string,strip_tags,htmlspecialchars');
                    $return['status'] = M('Member')->where(['id' => $this->fans['uid']])->save(['mobile' => $mobile]);
                    $return['data']   = 'editNewMobile';
                    session('editmobile', null);
                } else {
                    session('editmobile', 1);
                    $return['status'] = 1;
                }
                clear_auth_error($this->fans['uid'],2);
                session('send', null);
                $this->ajaxReturn($return);
            } else {
                log_auth_error($this->fans['uid'],2);
                UserLogService::write(3, '修改手机号码失败', '原因：短信验证码错误');
                $this->ajaxReturn(['status' => 0, 'msg' => '验证码错误']);
            }
        } else {
            UserLogService::write(1, '访问修改手机号码页面', '访问修改手机号码页面');
            if ($sms_is_open) {
                //判断是否是获取新手机验证码还是旧手机验证码的视图
                !I('request.editnewmobile', 0) && session('editmobile', 0);
                $this->assign('editmobile', session('editmobile'));
                $this->assign('sms_is_open', $sms_is_open);
                $this->assign('sendUrl', U('User/Account/editMobile'));
                $this->assign('mobile', $this->fans['mobile']);
                $this->display();
            }
        }
    }

    /**
     *  修改默认
     */
    public function editBankStatus()
    {
        if (IS_POST) {
            $id        = I('post.id', 0, 'intval');
            $isdefault = I('post.isopen', 0, 'intval');
            if ($id) {
                if ($isdefault) {
                    M('Bankcard')->where(['userid' => $this->fans['uid']])->save(['isdefault' => 0]);
                }
                $res = M('Bankcard')->where(['id' => $id, 'userid' => $this->fans['uid']])->save(['isdefault' => $isdefault]);
                if(FALSE !== $res) {
                    UserLogService::write(3, '修改默认银行卡成功', 'ID：'.$id);
                    $this->ajaxReturn(['status' => 1]);
                } else {
                    UserLogService::write(3, '修改默认银行卡失败', 'ID：'.$id);
                    $this->ajaxReturn(['status' => 0]);
                }

            }
        }
    }
    /**
     *  删除银行卡
     */
    public function delBankcard()
    {
        if (IS_POST) {
            $id = I('post.id', 0, 'intval');
            if ($id) {
                $res = M('Bankcard')->where(['id' => $id, 'userid' => $this->fans['uid']])->delete();
                if(FALSE !== $res) {
                    $this->ajaxReturn(['status' => 1]);
                    UserLogService::write(4, '删除银行卡成功', 'ID：'.$id);
                } else {
                    $this->ajaxReturn(['status' => 0]);
                    UserLogService::write(4, '删除银行卡失败', 'ID：'.$id);
                }

            }
        }
    }
    public function bankcardedit()
    {
        if (IS_POST) {
            $id       = I('post.id', 0, 'intval');
            $Ip       = new \Org\Net\IpLocation('UTFWry.dat'); // 实例化类 参数表示IP地址库文件
            $location = $Ip->getlocation(); // 获取某个IP地址所在的位置

            $Bankcard  = M("Bankcard");
            $_formdata = array(
                'userid'       => session("userid"),
                'bankname'     => I('post.bankname'),
                'bankfenname'  => I('post.bankfenname'),
                'bankzhiname'  => I('post.bankzhiname'),
                'banknumber'   => I('post.banknumber'),
                'bankfullname' => I('post.bankfullname'),
                'sheng'        => I('post.sheng'),
                'shi'          => I('post.shi'),
                'kdatetime'    => date("Y-m-d H:i:s"),
                'jdatetime'    => date("Y-m-d H:i:s", time() + 40 * 3600 * 24),
                'ip'           => $location['ip'],
                'ipaddress'    => $location['country'] . "-" . $location['area'],
                'disabled'     => 1,
            );
            if ($id) {
                $type = 3;
                $handle = '修改';
                $result = $Bankcard->where(array('id' => $id, 'userid' => $this->fans['uid']))->save($_formdata);
            } else {
                $type = 2;
                $handle = '添加';
                $result = $Bankcard->add($_formdata);
            }
            if ($result) {
                UserLogService::write($type, $handle.'银行卡成功', $id > 0 ? 'ID：'.$id : $handle.'银行卡成功');
                $this->success($handle."银行卡信息成功！");
            } else {
                UserLogService::write($type, $handle.'银行卡失败', $id > 0 ? 'ID：'.$id : $handle.'银行卡成功');
                $this->error($handle."银行卡息失败！");
            }
        }
    }

    public function loginrecord()
    {
        UserLogService::write(1, '访问登录记录页面', '访问登录记录页面');
        $maps['userid'] = $this->fans['uid'];
        $maps['type']   = 0;
        $count          = M('Loginrecord')->where($maps)->count();
        $size  = 15;
        $rows  = I('get.rows', $size, 'intval');
        if (!$rows) {
            $rows = $size;
        }
        $page           = new Page($count, $rows);
        $list           = M('Loginrecord')
            ->where($maps)
            ->limit($page->firstRow . ',' . $page->listRows)
            ->order('id desc')
            ->select();
        $this->assign("list", $list);
        $this->assign('page', $page->show());
        $this->display();
    }

    /**
     *  商户认证
     */
    public function authorized()
    {
        UserLogService::write(1, '访问商户认证页面', '访问商户认证页面');
        $authorized = M('Member')->where(['id' => $this->fans['uid']])->getField('authorized');
        $list       = [];
        $list       = M('Attachment')->where(['userid' => $this->fans['uid']])->select();
        $this->assign('list', $list);
        $this->assign('authorized', $authorized);
        $this->display();
    }

    public function upload()
    {
        if (IS_POST) {
            $upload           = new Upload();
            $upload->maxSize  = 2097152;
            $upload->exts     = array('jpg', 'gif', 'png');
            $upload->savePath = '/verifyinfo/';
            $info             = $upload->uploadOne($_FILES['auth']);
            if (!$info) {
                // 上传错误提示错误信息
                $this->error($upload->getError());
            } else {
                $data = [
                    'userid'   => $this->fans['uid'],
                    'filename' => $info['name'],
                    'path'     => 'Uploads' . $info['savepath'] . $info['savename'],
                ];
                $res = M("Attachment")->add($data);
                $this->ajaxReturn($res);
            }
        }
    }

    public function certification()
    {
        M('Member')->where(['id' => $this->fans['uid']])->save(['authorized' => 2]);
        $this->success('已申请认证，请等待审核！');
    }

    /**
     *  修改支付密码
     */
    public function editPaypassword()
    {
        $data = M('Member')->where(['id' => $this->fans['uid']])->find();
        $this->assign('p', $data);
        //查询是否开启短信验证
        $sms_is_open = smsStatus();

        if (IS_POST) {
            //验证验证码
            $code = I('request.code', '', 'string,strip_tags,htmlspecialchars');
            if ($sms_is_open) {
                $res = check_auth_error($this->fans['uid'], 2);
                if(!$res['status']) {
                    UserLogService::write(3, '修改支付密码失败', '原因：短信验证码输入错误次数超限');
                    $this->ajaxReturn(['status' => 0, 'msg' => $res['msg']]);
                }
                if (session('send.editPayPassword') == $code && $this->checkSessionTime('editPayPassword', $code)) {
                    clear_auth_error($this->fans['uid'],2);
                    session('send', null);
                } else {
                    log_auth_error($this->fans['uid'],2);
                    UserLogService::write(3, '修改支付密码失败', '原因：短信验证码错误');
                    $this->ajaxReturn(['status' => 0, 'msg' => '验证码错误']);
                }
            }

            $p  = I('post.p/a', '', 'trim');
            if (!$p['oldpwd'] || !$p['newpwd'] || !$p['secondpwd'] || $p['newpwd'] != $p['secondpwd'] ||
                $data['paypassword'] != md5($p['oldpwd'])) {
                UserLogService::write(3, '修改支付密码失败', '原因：输入错误');
                $this->ajaxReturn(['status' => 0, 'msg' => '输入错误']);
            }
            $res = M('Member')->where(['id' => $this->fans['uid']])->save(['paypassword' => md5($p['newpwd'])]);
            if(FALSE !== $res) {
                UserLogService::write(3, '修改支付密码成功', '修改支付密码成功');
                $this->ajaxReturn(['status' => 1]);
            } else {
                UserLogService::write(3, '修改支付密码失败', '修改支付密码失败');
                $this->ajaxReturn(['status' => 0]);
            }
        } else {
            UserLogService::write(1, '访问修改支付密码页面', '访问修改支付密码页面');
            if ($sms_is_open) {
                $this->assign('sendUrl', U('User/Account/editPayPasswordSend'));
            }
            $this->assign('sms_is_open', $sms_is_open);
            $this->display();
        }
    }

    /**
     * 修改密码
     */
    public function editPassword()
    {
        $data = M('Member')->where(['id' => $this->fans['uid']])->find();
        $this->assign('p', $data);
        //查询是否开启短信验证
        $sms_is_open = smsStatus();

        if (IS_POST) {
            //验证验证码
            $code = I('request.code', '', 'string,strip_tags,htmlspecialchars');
            if ($sms_is_open) {
                $res = check_auth_error($this->fans['uid'], 2);
                if(!$res['status']) {
                    UserLogService::write(3, '修改登录密码失败', '原因：短信验证码输入错误次数超限');
                    $this->ajaxReturn(['status' => 0, 'msg' => $res['msg']]);
                }
                if (session('send.editPassword') == $code && $this->checkSessionTime('editPassword', $code)) {
                    clear_auth_error($this->fans['uid'],2);
                    session('send', null);
                } else {
                    log_auth_error($this->fans['uid'],2);
                    UserLogService::write(3, '修改登录密码失败', '原因：短信验证码错误');
                    $this->ajaxReturn(['status' => 0, 'msg' => '验证码错误']);
                }
            }

            $salt = $data['salt'];
            $p    = I('post.p/a','','trim');
            if (!$p['oldpwd'] || !$p['newpwd'] || !$p['secondpwd'] || $p['newpwd'] != $p['secondpwd'] || $data['password'] != md5
                ($p['oldpwd'] . $salt)) {
                UserLogService::write(3, '修改登录密码失败', '原因：输入错误');
                $this->ajaxReturn(['status' => 0, 'msg' => '输入错误']);
            }
            $res = M('Member')->where(['id' => $this->fans['uid']])->save(['password' => md5($p['newpwd'] . $salt)]);
            if($res !== false) {
                if(!$res) {
                    UserLogService::write(3, '修改登录密码失败', '原因：请勿使用旧密码');
                    $this->ajaxReturn(['status' => 0, 'msg' => '请勿使用旧密码']);
                } else {
                    UserLogService::write(3, '修改登录密码成功', '修改登录密码成功');
                    $this->ajaxReturn(['status' => 1, 'msg' => '修改密码成功']);
                }
            } else {
                UserLogService::write(3, '修改登录密码失败', '修改登录密码失败');
                $this->ajaxReturn(['status' => 0, 'msg' => '修改密码失败']);
            }
        } else {
            UserLogService::write(1, '访问修改登录密码页面', '访问修改登录密码页面');
            if ($sms_is_open) {
                $this->assign('sendUrl', U('User/Account/editPasswordSend'));
            }
            $this->assign('sms_is_open', $sms_is_open);
            $this->display();
        }
    }

    /**
     *  资金变动记录
     */
    public function changeRecord()
    {
        UserLogService::write(1, '访问资金变动记录页面', '访问资金变动记录页面');
        //商户支付通道
        $products = M('ProductUser')
            ->join('LEFT JOIN __PRODUCT__ ON __PRODUCT__.id = __PRODUCT_USER__.pid')
            ->where(['pay_product_user.status' => 1, 'pay_product_user.userid' => $this->fans['uid']])
            ->field('pay_product.name,pay_product.id,pay_product.code')
            ->select();
        $this->assign("products", $products);

        $where   = array();
        $orderid = I("get.orderid", '' , 'string,strip_tags,htmlspecialchars');
        if ($orderid) {
            $where['transid'] = array('eq', $orderid);
        }
        $this->assign('orderid', $orderid);
        $tongdao = I("request.tongdao", '' , 'string,strip_tags,htmlspecialchars');
        if ($tongdao) {
            $where['tongdao'] = array('eq', $tongdao);
        }
        $this->assign('tongdao', $tongdao);
        $bank = I("request.bank", '' , 'string,strip_tags,htmlspecialchars');
        if ($bank) {
            $where['lx'] = array('eq', $bank);
        }
        $this->assign('bank', $bank);
        $createtime = urldecode(I("request.createtime", '' , 'string,strip_tags,htmlspecialchars'));
        if ($createtime) {
            list($cstime, $cetime) = explode('|', $createtime);
            $where['datetime']     = ['between', [$cstime, $cetime ? $cetime : date('Y-m-d')]];
        }
        $this->assign('createtime', $createtime);
        $where['userid'] = $this->fans['uid'];
        $count           = M('Moneychange')->where($where)->count();
        $size            = 15;
        $rows            = I('get.rows', $size, 'intval');
        if (!$rows) {
            $rows = $size;
        }
        $page = new Page($count, $rows);
        $list = M('Moneychange')
            ->where($where)
            ->limit($page->firstRow . ',' . $page->listRows)
            ->order('id desc')
            ->select();
        $this->assign('rows', $rows);
        $this->assign('list', $list);
        $this->assign('page', $page->show());
        C('TOKEN_ON', false);
        $this->display();
    }

    /**
     * 资金变动记录导出
     */
    public function exceldownload()
    {
        UserLogService::write(5, '导出资金变动记录', '导出资金变动记录');
        $where = array();

        $orderid = I("request.orderid", '' , 'string,strip_tags,htmlspecialchars');
        if ($orderid) {
            $where['orderid'] = $orderid;
        }
        $tongdao = I("request.tongdao", '' , 'string,strip_tags,htmlspecialchars');
        if ($tongdao) {
            $where['tongdao'] = array('eq', $tongdao);
        }
        $bank = I("request.bank", '' , 'string,strip_tags,htmlspecialchars');
        if ($bank) {
            $where['lx'] = array('eq', $bank);
        }
        $createtime = urldecode(I("request.createtime", '' , 'string,strip_tags,htmlspecialchars'));
        if ($createtime) {
            list($cstime, $cetime) = explode('|', $createtime);
            $where['datetime']     = ['between', [$cstime, $cetime ? $cetime : date('Y-m-d')]];
        }
        $where['userid'] = $this->fans['uid'];
        $list            = M("Moneychange")->where($where)->select();
        $title           = array('订单号', '用户名', '类型', '提成用户名', '提成级别', '原金额', '变动金额', '变动后金额', '变动时间', '通道', '备注');

        foreach ($list as $key => $value) {
            $data[$key]['transid']    = "\t" . $value["transid"];
            $data[$key]['parentname'] = getParentName($value["tcuserid"], 1);
            switch ($value["lx"]) {
                case 1:
                    $data[$key]['lxstr'] = "付款";
                    break;
                case 3:
                    $data[$key]['lxstr'] = "手动增加";
                    break;
                case 4:
                    $data[$key]['lxstr'] = "手动减少";
                    break;
                case 6:
                    $data[$key]['lxstr'] = "结算";
                    break;
                case 7:
                    $data[$key]['lxstr'] = "冻结";
                    break;
                case 8:
                    $data[$key]['lxstr'] = "解冻";
                    break;
                case 9:
                    $data[$key]['lxstr'] = "提成";
                    break;
                case 10:
                    $data[$key]['lxstr'] = "委托结算";
                    break;
                case 11:
                    $data[$key]['lxstr'] = "提款驳回";
                    break;
                case 12:
                    $data[$key]['lxstr'] = "代付驳回";
                    break;
                case 13:
                    $data[$key]['lxstr'] = "投诉保证金解冻";
                    break;
                case 14:
                    $data[$key]['lxstr'] = "扣除代付结算手续费";
                    break;
                case 15:
                    $data[$key]['lxstr'] = "代付结算驳回退回手续费";
                    break;
                case 16:
                    $data[$key]['lxstr'] = "扣除手动结算手续费";
                    break;
                case 17:
                    $data[$key]['lxstr'] = "手动结算驳回退回手续费";
                    break;
                default:
                    $data[$key]['lxstr'] = "未知";
            }
            $data[$key]['tcuserid']   = getParentName($value["tcuserid"], 1);
            $data[$key]['tcdengji']   = $value["tcdengji"];
            $data[$key]['ymoney']     = $value["ymoney"];
            $data[$key]['money']      = $value["money"];
            $data[$key]['gmoney']     = $value["gmoney"];
            $data[$key]['datetime']   = "\t" . $value["datetime"];
            $data[$key]['tongdao']    = getProduct($value["tongdao"]);
            $data[$key]['contentstr'] = $value["contentstr"];
        }
        exportCsv($data, $title);
    }

    /**
     * 收款二维码
     */
    public function qrcode()
    {
        UserLogService::write(1, '访问收款二维码页面', '访问收款二维码页面');
        $list = M("Member")->where(['id' => $this->fans['uid']])->find();
        $this->assign("p", $list);

        //生成二维码
        import("Vendor.phpqrcode.phpqrcode", '', ".php");
        $site = ((is_https()) ? 'https' : 'http') . '://' . C("DOMAIN");
        $url  = U('Pay/Charges/index', array('mid' => ($this->fans['uid'] + 10000)));

        $url = urldecode($site . $url);
        $QR  = "Uploads/charges/" . ($this->fans['uid'] + 10000) . ".png"; //已经生成的原始二维码图

        \QRcode::png($url, $QR, "L", 20, 1);

        //生成背景图
        vendor('image.autoLoad');
        ImageManagerStatic::configure(array('driver' => C('imageDriver')));
        $imageQr = ImageManagerStatic::make($QR)->resize(244, 244);
        $image   = ImageManagerStatic::make("Public/images/qrcode_bg.png");
        $image->text($this->fans['receiver'], 320, 560, function ($font) {
            $font->file('Public/Front/fonts/msyh.ttf');
            $font->size(24);
            $font->color('#333');
            $font->align('center');
            $font->valign('top');
        });
        $image->insert($imageQr, "left-top", 198, 300);
        $image->save($QR);

        $this->assign("imageurl", $QR);

        $this->display();
    }

    /**
     * 收款链接
     */
    public function link()
    {
        UserLogService::write(1, '访问收款链接页面', '访问收款链接页面');
        $site = ((is_https()) ? 'https' : 'http') . '://' . C("DOMAIN");
        $url  = U('Pay/Charges/index', array('mid' => ($this->fans['uid'] + 10000)));
        $url  = urldecode($site . $url);
        $this->assign("url", $url);
        $this->display();
    }

    /**
     * 下载二维码
     */
    public function downQrcode()
    {
        UserLogService::write(1, '下载收款二维码', '下载收款二维码');
        $QR       = "Uploads/charges/" . ($this->fans['uid'] + 10000) . ".png";
        $filename = ($this->fans['uid'] + 10000) . ".png";
        header("Content-type: octet/stream");
        header("Content-disposition:attachment;filename=" . $filename . ";");
        header("Content-Length:" . filesize($QR));
        readfile($QR);
    }
    /**
     * 保存二维码背景
     */
    public function uploadQrcode()
    {
        $config = array(
            'maxSize'  => 3145728,
            'rootPath' => 'Public/images/',
            'savePath' => '',
            'saveName' => 'qrcode_bg',
            'replace'  => true,
            'exts'     => array('jpg', 'gif', 'png', 'jpeg'),
        );
        $upload = new \Think\Upload($config); // 实例化上传类
        // 上传文件
        $info = $upload->upload();
        if (!$info) {
// 上传错误提示错误信息
            UserLogService::write(3, '上传成功收款二维码背景失败', '原因：'.$upload->getError());
            $response = ['code' => 1, 'msg' => $upload->getError(), 'data' => ['url' => '']];
            $this->ajaxReturn($response);
        } else {
// 上传成功
            UserLogService::write(3, '上传成功收款二维码背景成功', '上传成功收款二维码背景成功');
            $response = ['code' => 0, 'msg' => '上传成功', 'data' => ['url' => '']];
            $this->ajaxReturn($response);
        }
    }

    /**
     * 保存台卡收款人
     */
    public function saveReceiver()
    {
        $p = I('request.p/a', '' , 'trim,strip_tags,htmlspecialchars');
        $res = M("Member")->where(['id' => $this->fans['uid']])->save($p);
        if(FALSE !== $res) {
            UserLogService::write(3, '保存台卡收款人成功', '保存台卡收款人成功');
        } else {
            UserLogService::write(3, '保存台卡收款人失败', '保存台卡收款人失败');
        }
        $this->redirect('User/Account/qrcode');
    }

    /**
     * 发送修改登录密码的验证码信息
     */
    public function editPasswordSend()
    {
        $res = $this->send('editPassword', $this->fans['mobile'], '登录密码');
        $this->ajaxReturn(['status' => $res['code']]);
    }
    /**
     * 发送修改支付密码的验证码信息
     */
    public function editPayPasswordSend()
    {
        $res = $this->send('editPayPassword', $this->fans['mobile'], '支付密码');
        $this->ajaxReturn(['status' => $res['code']]);
    }

    /**
     * 绑定手机验证码
     */
    public function bindMobile()
    {
        $mobile = I('request.mobile', '' , 'string,strip_tags,htmlspecialchars');
        $res    = $this->send('bindMobile', $mobile, '绑定手机');
        $this->ajaxReturn(['status' => $res['code']]);
    }

    public function editMobile()
    {
        if (session('editmobile') == '1') {
            $mobile = I('request.mobile', '' , 'string,strip_tags,htmlspecialchars');
            if(!$mobile) {
                $this->ajaxReturn(['status' => 0, 'msg' => '手机号码不能为空！']);
            }
        } else {
            $mobile = $this->fans['mobile'];
            if (!$mobile) {
                $this->ajaxReturn(['status' => 0, 'msg' => '您未绑定手机号码！']);
            }
        }
        $res = $this->send('editMobile', $mobile, '修改手机');
        $this->ajaxReturn(['status' => $res['code']]);
    }

    public function channelFinance()
    {
        UserLogService::write(1, '访问通道分析页面', '访问通道分析页面');
        $createtime = urldecode(I("request.createtime", '', 'string,strip_tags,htmlspecialchars'));
        if ($createtime) {
            list($cstime,$cetime) = explode('|',$createtime);
            $where['pay_applydate'] = ['between',[strtotime($cstime),strtotime($cetime)?strtotime($cetime):time()]];
        }
        $Product = M('Product');

        $count = $Product->count();
        $Page  = new Page($count, 15);
        $show  = $Page->show();

        $productList = $Product
            ->field(['id', 'name', 'code'])
            ->limit($Page->firstRow . ',' . $Page->listRows)
            ->select();

        $payMemberid = session('user_auth.uid') + 10000;
        $Order      = M('Order');
        $where['pay_memberid'] = $payMemberid;
        $orderCount = $Order->where($where)->count();
        $orderList  = [];
        $limit      = 100000;
        for ($i = 0; $i < $orderCount; $i += $limit) {


            $tempList = $Order
                ->field(['pay_bankcode', 'pay_amount', 'pay_poundage', 'pay_actualamount', 'pay_status'])
                ->where($where)
                ->limit($i, $limit)
                ->select();

            $orderList = array_merge($orderList, $tempList);
        }

        // dump($orderList);exit;
        //处理查询的数据
        foreach ($productList as $k => $v) {

            $productList[$k]['count']            = 0;
            $productList[$k]['fail_count']       = 0;
            $productList[$k]['success_count']    = 0;
            $productList[$k]['success_rate']     = 0;
            $productList[$k]['pay_amount']       = 0.00;
            $productList[$k]['pay_poundage']     = 0.00;
            $productList[$k]['pay_actualamount'] = 0.00;


            foreach ($orderList as $k1 => $v1) {
                if ($v['id'] == $v1['pay_bankcode']) {
                    $productList[$k]['count']++;
                    if ($v1['pay_status'] != 0) {
                        $productList[$k]['success_count']++;
                        $productList[$k]['pay_amount']       = bcadd($productList[$k]['pay_amount'], $v1['pay_amount'], 4);
                        $productList[$k]['pay_poundage']     = bcadd($productList[$k]['pay_poundage'], $v1['pay_poundage'], 4);
                        $productList[$k]['pay_actualamount'] = bcadd($productList[$k]['pay_actualamount'], $v1['pay_actualamount'], 4);
                    }
                }
            }
            $productList[$k]['fail_count'] = $productList[$k]['count'] - $productList[$k]['success_count'];
            $productList[$k]['success_rate'] = bcdiv($productList[$k]['success_count'],$productList[$k]['count'],4) * 100;
        }
        
        $this->assign('list', $productList);
        $this->assign('createtime', $createtime);
        $this->display();
    }

    /**
     * 绑定谷歌身份认证
     */
    public function google()
    {
        $ga = new \Org\Util\GoogleAuthenticator();
        if (!IS_POST) {
            UserLogService::write(1, '访问绑定谷歌身份认证页面', '访问绑定谷歌身份认证页面');
            $google_token = M('Member')->where(['id'=>$this->fans['uid']])->getField('google_secret_key');
            if($google_token == '') {
                $secret = session('user_google_secret_key') ? session('user_google_secret_key') : $ga->createSecret();
                $qrCodeUrl = $ga->getQRCodeGoogleUrl($_SERVER["REQUEST_SCHEME"].'://'.$_SERVER["HTTP_HOST"].'@'.$this->fans['username'], $secret);
                session('user_google_secret_key', $secret);
                $this->assign('secret', $secret);
                $this->assign('qrCodeUrl', $qrCodeUrl);
            }
            //查询是否开启短信验证
            $sms_is_open = smsStatus();
            if ($sms_is_open) {
                $this->assign('sendUrl', U('User/Account/profileSend'));
            }
            $this->assign('google_token', $google_token);
            $this->assign('sms_is_open', $sms_is_open);
            $this->assign('google_auth', $this->fans['google_auth']);
            $this->display();
        } else {
            //验证短信验证码
            $code        = I('request.code', '' , 'string,strip_tags,htmlspecialchars');
            $sms_is_open = smsStatus();
            if ($sms_is_open) {
                $res = check_auth_error($this->fans['uid'], 2);
                if(!$res['status']) {
                    UserLogService::write(3, '绑定谷歌身份认证失败', '原因：输入短信验证码错误次数超限');
                    $this->ajaxReturn(['status' => 0, 'msg' => $res['msg']]);
                }
                if (session('send.saveProfile') == $code && $this->checkSessionTime('saveProfile', $code)) {
                    clear_auth_error($this->fans['uid'],2);
                    session('send', null);
                } else {
                    log_auth_error($this->fans['uid'],2);
                    UserLogService::write(3, '绑定谷歌身份认证失败', '原因：短信验证码错误');
                    $this->ajaxReturn(['status' => 0, 'msg' => '短信验证码错误']);
                }
            }
            $res = check_auth_error($this->fans['uid'], 4);
            if(!$res['status']) {
                UserLogService::write(3, '绑定谷歌身份认证失败', '原因：输入谷歌验证码错误次数超限');
                $this->ajaxReturn(['status' => 0, 'msg' => $res['msg']]);
            }
            $googlecode = I('googlecode', '' , 'string,strip_tags,htmlspecialchars');
            if($googlecode == '') {
                UserLogService::write(3, '绑定谷歌身份认证失败', '原因：谷歌验证码不能为空');
                $this->ajaxReturn(["status"=>0, "msg"=>"请输入验证码"]);
            }
            $google_secret_key = session('user_google_secret_key');
            if(!$google_secret_key) {
                UserLogService::write(3, '绑定谷歌身份认证失败', '原因：谷歌密钥session不存在');
                $this->error("绑定失败，请刷新页面重试");
            }
            if(false === $ga->verifyCode($google_secret_key, $googlecode, C('google_discrepancy'))) {
                log_auth_error($this->fans['uid'],4);
                UserLogService::write(3, '绑定谷歌身份认证失败', '原因：谷歌验证码错误');
                $this->ajaxReturn(["status"=>0, "msg"=>"谷歌安全码错误"]);
            } else {
                clear_auth_error($this->fans['uid'],4);
                $re = M('Member')->where(array('id'=>$this->fans['uid'],'google_secret_key'=>array('eq','')))->save(['google_auth' =>1, 'google_secret_key'=>$google_secret_key]);
                if(FALSE !== $re) {
                    session('user_google_auth', $googlecode);
                    UserLogService::write(3, '绑定谷歌身份认证成功', '绑定谷歌身份认证成功');
                    $this->ajaxReturn(["status"=>1, "msg"=>"绑定成功"]);
                } else {
                    UserLogService::write(3, '绑定谷歌身份认证失败', '绑定谷歌身份认证失败');
                    $this->ajaxReturn(["status"=>0, "msg"=>"绑定失败，请稍后重试"]);
                }
            }
        }
    }

    /**
     * 解绑谷歌身份验证
     */
    public function unbindGoogle()
    {
        if(IS_POST) {
            //验证短信验证码
            $code        = I('request.code', '' , 'string,strip_tags,htmlspecialchars');
            $sms_is_open = smsStatus();
            if ($sms_is_open) {
                $res = check_auth_error($this->fans['uid'], 2);
                if(!$res['status']) {
                    UserLogService::write(3, '解绑谷歌身份认证失败', '原因：输入短信验证码错误次数超限');
                    $this->ajaxReturn(['status' => 0, 'msg' => $res['msg']]);
                }
                if (session('send.unbindGoogle') == $code && $this->checkSessionTime('unbindGoogle', $code)) {
                    clear_auth_error($this->fans['uid'],2);
                    session('send', null);
                } else {
                    log_auth_error($this->fans['uid'],2);
                    UserLogService::write(3, '解绑谷歌身份认证失败', '原因：短信验证码错误');
                    $this->ajaxReturn(['status' => 0, 'msg' => '短信验证码错误']);
                }
            }
            $re = M('Member')->where(array('id'=>$this->fans['uid']))->save(['google_auth' =>0, 'google_secret_key'=>'']);
            if(FALSE !== $re) {
                session('user_google_auth', null);
                UserLogService::write(3, '解绑谷歌身份认证成功', '解绑谷歌身份认证成功');
                $this->ajaxReturn(["status"=>1, "msg"=>"解绑成功"]);
            } else {
                UserLogService::write(3, '解绑谷歌身份认证失败', '解绑谷歌身份认证失败');
                $this->ajaxReturn(["status"=>0, "msg"=>"解绑失败，请售后重试"]);
            }
        } else {
            UserLogService::write(1, '访问解绑谷歌身份验证页面', '访问解绑谷歌身份验证页面');
            //查询是否开启短信验证
            $sms_is_open = smsStatus();
            if ($sms_is_open) {
                $this->assign('sendUrl', U('User/Account/unbindGoogleSend'));
            }
            $this->assign('user', $this->fans);
            $this->assign('sms_is_open', $sms_is_open);
            $this->display();
        }
    }

    /**
     * 解绑谷歌身份验证器验证码
     */
    public function unbindGoogleSend()
    {
        $user = M('Member')->where(['id'=>$this->fans['uid']])->find();
        $mobile = $user['mobile'];
        if (!$mobile) {
            $this->ajaxReturn(['status' => 0, 'msg' => '您未绑定手机号码！']);
        }
        $res = $this->send('unbindGoogle', $mobile, '解绑谷歌身份验证器');
        $this->ajaxReturn(['status' => $res['code']]);
    }

    /**
     * 保证金明细
     */
    public function complaintsDeposit()
    {
        UserLogService::write(1, '访问保证金明细页面', '访问保证金明细页面');
        $where   = array();
        $orderid = I("get.orderid", '' , 'string,strip_tags,htmlspecialchars');
        if ($orderid) {
            $where['out_trade_id'] = array('eq', $orderid);
        }
        $this->assign('orderid', $orderid);
        $status = I("request.status", '' , 'string,strip_tags,htmlspecialchars');
        if ($status !='') {
            $where['status'] = array('eq', $status);
        }
        $this->assign('status', $status);
        $createtime = urldecode(I("request.createtime", '' , 'string,strip_tags,htmlspecialchars'));
        if ($createtime) {
            list($cstime, $cetime) = explode('|', $createtime);
            $map['create_at'] = $where['create_at']     = ['between', [strtotime($cstime), strtotime($cetime) ? strtotime($cetime) : time()]];
        }
        $this->assign('createtime', $createtime);
        $map['user_id'] = $where['user_id'] = $this->fans['uid'];
        $count           = M('complaints_deposit')->where($where)->count();
        $size            = 15;
        $rows            = I('get.rows', $size, 'intval');
        if (!$rows) {
            $rows = $size;
        }
        $page = new Page($count, $rows);
        $list = M('complaints_deposit')
            ->where($where)
            ->limit($page->firstRow . ',' . $page->listRows)
            ->order('id desc')
            ->select();
        /* 统计 */
        //总保证金金额
        $stats['all'] = M('complaints_deposit')->where($map)->sum('freeze_money');
        //总已解冻金额
        $map['status'] = 1;
        $stats['freezed'] = M('complaints_deposit')->where($map)->sum('freeze_money');
        //总待解冻金额
        $map['status'] = 0;
        $stats['unfreezed'] = M('complaints_deposit')->where($map)->sum('freeze_money');
        foreach($stats as $k => $v) {
            $stats[$k] = $v+0;
        }
        $this->assign('stats', $stats);
        $this->assign('rows', $rows);
        $this->assign('list', $list);
        $this->assign('page', $page->show());
        C('TOKEN_ON', false);
        $this->display();
    }

    /**
     * 资金冻结明细
     */
    public function frozenMoney()
    {
        UserLogService::write(1, '访问资金冻结明细页面', '访问资金冻结明细页面');
        $where   = array();
        $status = I("request.status", '' , 'string,strip_tags,htmlspecialchars');
        if ($status !='') {
            $where['status'] = array('eq', $status);
        }
        $this->assign('status', $status);
        $createtime = urldecode(I("request.createtime", '' , 'string,strip_tags,htmlspecialchars'));
        if ($createtime) {
            list($cstime, $cetime) = explode('|', $createtime);
            $map['create_at'] = $where['create_at']     = ['between', [strtotime($cstime), strtotime($cetime) ? strtotime($cetime) : time()]];
        }
        $this->assign('createtime', $createtime);
        $map['user_id'] = $where['user_id'] = $this->fans['uid'];
        $count           = M('autoUnfrozenOrder')->where($where)->count();
        $size            = 15;
        $rows            = I('get.rows', $size, 'intval');
        if (!$rows) {
            $rows = $size;
        }
        $page = new Page($count, $rows);
        $list = M('autoUnfrozenOrder')
            ->where($where)
            ->limit($page->firstRow . ',' . $page->listRows)
            ->order('id desc')
            ->select();
        /* 统计 */
        //待解冻金额
        $map['status'] = 0;
        $stats['unfreezed'] = M('autoUnfrozenOrder')->where($map)->sum('freeze_money');
        foreach($stats as $k => $v) {
            $stats[$k] = $v+0;
        }
        $this->assign('stats', $stats);
        $this->assign('rows', $rows);
        $this->assign('list', $list);
        $this->assign('page', $page->show());
        C('TOKEN_ON', false);
        $this->display();
    }

    /**
     * 对账单
     */
    public function reconciliation()
    {
        UserLogService::write(1, '访问对账单页面', '访问对账单页面');
        if($this->fans[groupid] != 4) {
            $this->error('您没有权限访问该页面!');
        }
        $date = urldecode(I("request.date", '' , 'string,strip_tags,htmlspecialchars'));
        if(!$date) {//默认今日
            $date = date('Y-m-d');
        }
        $this->assign('date', $date);
        if ($memberid = I('get.memberid', '')) {
            $where['id'] = $memberid - 10000;
        }
        $this->assign('memberid', $memberid);
        if($date>date('Y-m-d') || strtotime($date)<strtotime(date('Y-m-d',$this->fans['regdatetime']))) {
            $this->error('日期错误');
        }

        $time = M('Member')->where(['id'=>$this->fans['uid']])->getField('regdatetime');
        $time = strtotime(date('Y-m-d', $time));
        $timestamp = strtotime($date);
        $count      = ceil(($timestamp-$time)/86400)+1;
        $p = I('get.p', 1, 'intval');
        $page       = new Page($count, 10);
        $xh = $count < 10 ? $count : 10;
        $start_time = $date;
        $offset = ($p-1) * $page->listRows-1;
        if($offset>0) {
            $max_date = strtotime("$start_time -$offset day") - 1;
        } else {
            $max_date = strtotime($date);
        }
        $list = array();
        for($i=0; $i<$xh; $i++) {
            $start_time = $max_date-$i*86400;
            if($start_time<$time) {
                break;
            }
            $begin = date('Y-m-d',$start_time).' 00:00:00';
            $end = date('Y-m-d H:i:s',strtotime(date('Y-m-d',$start_time))+86400-1);
            $list[$i] = $this->getDayReconciliation($begin, $end);
        }
        $this->assign('list', $list);
        $this->assign('page', $page->show());
        $this->assign('time',date('Y-m-d',$time));
        C('TOKEN_ON', false);
        $this->display();
    }

    //获取某天对账单
    private function getDayReconciliation($begin, $end) {

        $date = date('Y-m-d', strtotime($begin));
        $data = M('reconciliation')->where(['userid'=>$this->fans['uid'],'date'=>$date])->find();
        if(empty($data)) {
            $insertFlag = true;
        } else {
            $insertFlag = false;
        }
        if(empty($data) || (!empty($data) && (diffBetweenTwoDays(date('Y-m-d'),$date)<=3) || $data['ctime'] < (strtotime($date)+86400))) {//3天内账单实时更新数据
            $data['date'] = $date;
            $data['order_total_count'] = M('Order')->where(['pay_memberid'=>$this->fans['memberid'],'pay_applydate' => ['between', [strtotime($begin), strtotime($end)]]])->count();
            //成功订单数
            $data['order_success_count'] = M('Order')->where(['pay_memberid'=>$this->fans['memberid'],'pay_applydate' => ['between', [strtotime($begin), strtotime($end)]], 'pay_status' => ['in', '1,2']])->count();
            //未支付订单数
            $data['order_fail_count'] = M('Order')->where(['pay_memberid'=>$this->fans['memberid'],'pay_applydate' => ['between', [strtotime($begin), strtotime($end)]], 'pay_status' => 0])->count();
            //订单总额
            $data['order_total_amount'] = M('Order')->where(['pay_memberid'=>$this->fans['memberid'],'pay_applydate' => ['between', [strtotime($begin), strtotime($end)]]])->sum('pay_amount');
            //订单实付总额
            $data['order_success_amount'] = M('Order')->where(['pay_memberid'=>$this->fans['memberid'],'pay_successdate' => ['between', [strtotime($begin), strtotime($end)]], 'pay_status' => ['in', '1,2']])->sum('pay_actualamount');
            if($insertFlag) {
                $data['userid'] = $this->fans['uid'];
                $data['ctime'] = time();
                M('reconciliation')->add($data);
            } else {
                M('reconciliation')->where(['id'=>$data['id']])->save($data);
            }
        }
        unset($data['userid']);
        unset($data['ctime']);
        unset($data['id']);
        foreach($data as $k => $v) {
            if($k != 'date') {
                $data[$k] += 0;
                if($k == 'order_total_amount' || $k == 'order_success_amount') {
                    $data[$k] = number_format($data[$k], 2, '.', ',');
                }
            }
        }
        return $data;
    }

    //关闭/开启谷歌验证码
    public function editGoogleStatus() {

        if (IS_POST) {
            $isstatus = I('post.isopen', 0, 'intval');
            if($isstatus != 0 && $isstatus != 1) {
                $this->ajaxReturn(['status' => 0, 'msg' => '参数错误']);
            }
            if($isstatus == 0) {
                $res = check_auth_error($this->fans['uid'], 4);
                if(!$res['status']) {
                    UserLogService::write(3, '关闭谷歌验证失败', '原因：谷歌验证码输入错误次数超限');
                    $this->ajaxReturn(['status' => 0, 'msg' => $res['msg']]);
                }
                $googlecode = I('googlecode', '' , 'string,strip_tags,htmlspecialchars');
                if($googlecode == '') {
                    UserLogService::write(3, '关闭谷歌验证失败', '原因：谷歌验证码不能为空');
                    $this->ajaxReturn(["status"=>0, "msg"=>"请输入验证码"]);
                }
                $ga = new \Org\Util\GoogleAuthenticator();
                if(false === $ga->verifyCode($this->fans['google_secret_key'], $googlecode, C('google_discrepancy'))) {
                    clear_auth_error($this->fans['uid'],4);
                    UserLogService::write(3, '关闭谷歌验证失败', '原因：谷歌验证码错误');
                    $this->ajaxReturn(["status"=>0, "msg"=>"谷歌安全码错误"]);
                }
                $op = '关闭谷歌验证';
            } else {
                $op = '开启谷歌验证';
            }
            $res      = M('Member')->where(['id' => $this->fans['uid']])->save(['google_auth' => $isstatus]);
            if(FALSE !== $res) {
                UserLogService::write(3, $op.'成功', $op.'成功');
                $this->ajaxReturn(['status' => 1 ,'msg' => $op.'成功']);
            } else {
                UserLogService::write(3, $op.'失败', $op.'失败');
                $this->ajaxReturn(['status' => 0 ,'msg' => $op.'失败']);
            }
        }
    }

    /*
   * 获取地区
   */
    public function getCity(){
        $info = [
            'status' => 0,
            'msg' => 'fail',
            'data' => null,
        ];
        if(IS_AJAX){
            $province_code= I('get.province_code', 0, 'intval');
            if($province_code) {
                try{
                    $data = M('area_city')->where(["province_code"=>$province_code])->select();
                    $info = [
                        'status' => 1,
                        'msg' => 'ok',
                        'data' => $data,
                    ];
                } catch(\Exception $e) {

                }
            }
        }
        $this->ajaxReturn($info);
    }
}
