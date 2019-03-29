<?php
/**
 * Created by PhpStorm.
 * User: gaoxi
 * Date: 2017-04-02
 * Time: 23:01
 */
namespace Admin\Controller;

use Think\Page;

/**
 * 提现控制器
 * Class WithdrawalController
 * @package Admin\Controller
 */
class WithdrawalController extends BaseController
{

    public function __construct()
    {
        parent::__construct();
    }

    /**
     * 提款记录
     */
    public function index()
    {
        //通道
        $banklist = M("Product")->field('id,name,code')->select();
        $this->assign("banklist", $banklist);

        $where    = array();
        $memberid = I("get.memberid", 0, 'intval');
        if ((intval($memberid) - 10000) > 0) {
            $where['userid'] = array('eq', $memberid - 10000);
        }
        $this->assign("memberid", $memberid);
        $tongdao = I("request.tongdao", '', 'trim,string,strip_tags,htmlspecialchars');
        if ($tongdao) {
            $where['payapiid'] = array('eq', $tongdao);
        }
        $this->assign("tongdao", $tongdao);
        $T = I("request.T");
        if ($T != "") {
            $where['t'] = array('eq', $T);
        }
        $this->assign("T", $T);
        $status = I("request.status", 0, 'intval');
        if ($status) {
            $where['status'] = array('eq', $status);
        }
        $this->assign("status", $status);
        $createtime = urldecode(I("request.createtime", '', 'trim,string,strip_tags,htmlspecialchars'));
        if ($createtime) {
            list($cstime, $cetime) = explode('|', $createtime);
            $where['sqdatetime']   = ['between', [$cstime, $cetime ? $cetime : date('Y-m-d')]];
        }
        $this->assign("createtime", $createtime);
        $successtime = urldecode(I("request.successtime", '', 'trim,string,strip_tags,htmlspecialchars'));
        if ($successtime) {
            list($sstime, $setime) = explode('|', $successtime);
            $where['cldatetime']   = ['between', [$sstime, $setime ? $setime : date('Y-m-d')]];
        }
        $this->assign("successtime", $successtime);
        //统计总结算信息
        $totalMap           = $where;
        $totalMap['status'] = 2;
        //结算金额
        $stat['total'] = round(M('tklist')->where($totalMap)->sum('money'), 2);
        //待结算
        $totalMap['status'] = ['in', '0,1'];
        $stat['total_wait'] = round(M('tklist')->where($totalMap)->sum('money'), 2);
        //完成笔数
        $totalMap['status']          = 2;
        $stat['total_success_count'] = M('tklist')->where($totalMap)->count();
        //驳回笔数
        $totalMap['status']       = 3;
        $stat['total_fail_count'] = M('tklist')->where($totalMap)->count();

        //统计今日结算信息
        $beginToday = mktime(0, 0, 0, date('m'), date('d'), date('Y'));
        $endToday   = mktime(0, 0, 0, date('m'), date('d') + 1, date('Y')) - 1;
        if($successtime) {//如果搜索条件是打款时间
            $map['cldatetime']   = array('between', array(date('Y-m-d H:i:s', $beginToday), date('Y-m-d H:i:s', $endToday)));
            if($createtime) {
                $map['sqdatetime']   = array('between', array(date('Y-m-d H:i:s', $beginToday), date('Y-m-d H:i:s', $endToday)));
            }
        } else {
            $map['sqdatetime']   = array('between', array(date('Y-m-d H:i:s', $beginToday), date('Y-m-d H:i:s', $endToday)));
        }
        //今日结算总金额
        $map['status']       = 2;
        $stat['totay_total'] = round(M('tklist')->where($map)->sum('money'), 2);
        //今日完成笔数
        $stat['totay_success_count'] = M('tklist')->where($map)->count();
        if(isset($map['cldatetime'])) {
            unset($map['cldatetime']);
            if(!isset( $map['sqdatetime'])) {
                $map['sqdatetime'] = array('between', array(date('Y-m-d H:i:s', $beginToday), date('Y-m-d H:i:s', $endToday)));
            }
        }
        //今日待结算
        $map['status']      = ['in', '0,1'];
        $stat['totay_wait'] = round(M('tklist')->where($map)->sum('money'), 2);
        //今日驳回笔数
        $map['status']            = 3;
        $stat['totay_fail_count'] = M('tklist')->where($map)->count();
        //统计本月结算信息
        $monthBegin = date('Y-m-01') . ' 00:00:00';
        if($successtime) {//如果搜索条件是打款时间
            $map['cldatetime']   = array('egt', $monthBegin);
            if($createtime) {
                $map['sqdatetime']   = array('egt', $monthBegin);
            }
        } else {
            $map['sqdatetime']   = array('egt', $monthBegin);
        }
        //本月结算总金额
        $map['status']       = 2;
        $stat['month_total'] = round(M('tklist')->where($map)->sum('money'), 2);
        //本月完成笔数
        $stat['month_success_count'] = M('tklist')->where($map)->count();
        if(isset($map['cldatetime'])) {
            unset($map['cldatetime']);
            if(!isset($map['sqdatetime'])) {
                $map['sqdatetime']  = array('egt',  $monthBegin);
            }
        }
        //本月待结算
        $map['status']      = ['in', '0,1'];
        $stat['month_wait'] = round(M('tklist')->where($map)->sum('money'), 2);
        //本月驳回笔数
        $map['status']            = 3;
        $stat['month_fail_count'] = M('tklist')->where($map)->count();
        foreach ($stat as $k => $v) {
            $stat[$k] += 0;
        }
        $this->assign('stat', $stat);
        $count = M('Tklist')->where($where)->count();
        $size  = 15;
        $rows  = I('get.rows', $size, 'intval');
        if (!$rows) {
            $rows = $size;
        }
        $page = new Page($count, $rows);
        $list = M('Tklist')
            ->where($where)
            ->limit($page->firstRow . ',' . $page->listRows)
            ->order('id desc')
            ->select();
        $this->assign('rows', $rows);
        $this->assign("list", $list);
        $this->assign("page", $page->show());
        C('TOKEN_ON', false);
        $this->display();
    }

    /**
     * 提款设置
     */
    public function setting()
    {
        $tab = I('tab', 1, 'intval');
        $configs = M("Tikuanconfig")->where("issystem=1")->find();
        $this->assign("tikuanconfiglist", $configs);
        $uid               = session('admin_auth')['uid'];
        $verifysms = 0;//是否可以短信验证
        $sms_is_open = smsStatus();
        if($sms_is_open) {
            $adminMobileBind = adminMobileBind($uid);
            if($adminMobileBind) {
                $verifysms = 1;
            }
        }
        //是否可以谷歌安全码验证
        $verifyGoogle = adminGoogleBind($uid);
        $user        = M('Admin')->where(['id' => $uid])->find();
        $this->assign('mobile', $user['mobile']);
        $this->assign('verifysms', $verifysms);
        $this->assign('verifyGoogle', $verifyGoogle);
        $this->assign('auth_type', $verifyGoogle ? 1 : 0);

        //排除日期
        $holiday = M('Tikuanholiday')->select();
        $this->assign("configs", $configs);
        $this->assign("holidays", $holiday);
        $this->assign("tab", $tab);
        $this->display();
    }
  	/**
     * 上传图片
     */
    public function uploadImg()
    {

        if (IS_POST) {
            $id = I('id');
            $upload           = new \Think\Upload();
            $upload->maxSize  = 5097152;
            $upload->exts     = array('jpg', 'gif', 'png');
            $upload->savePath = '/withdrawal/';
            $info             = $upload->uploadOne($_FILES['file']);

            if (!$info) {
                // 上传错误提示错误信息
                $this->error($upload->getError());
            } else {
                $data = [
                    'image' => 'Uploads' . $info['savepath'] . $info['savename'],//上传图片
                    'upload_time'=>time()//上传时间
                ];

                $res = M("Tklist")->where(['id' =>$id])->save($data);
                if($res) {
                    $this->ajaxReturn(['status' => $res, 'msg' => '上传成功', 'data' => $data['image']]);
                } else {
                    $this->ajaxReturn(['status' => 0, 'msg' => '上传失败', 'data' => '']);
                }
            }
        }
    }
    /**
     * 保存系统提款设置
     */
    public function saveWithdrawal()
    {
        if (IS_POST) {
            $id  = I('post.id', 0, 'intval') ? I('post.id', 0, 'intval') : 0;
            $tab = I('tab', 1, 'intval');

            $_rows           = I('post.u');
            $_rows['userid'] = 1;
            $auth_type = I('request.auth_type',0,'intval');
            $uid               = session('admin_auth')['uid'];
            $verifysms = 0;//是否可以短信验证
            $sms_is_open = smsStatus();
            if($sms_is_open) {
                $adminMobileBind = adminMobileBind($uid);
                if($adminMobileBind) {
                    $verifysms = 1;
                }
            }
            //是否可以谷歌安全码验证
            $verifyGoogle = adminGoogleBind($uid);
            if($verifyGoogle && $verifysms) {
                if(!in_array($auth_type,[0,1])) {
                    $this->ajaxReturn(['status' => 0, 'msg' => "参数错误！", 'tab' => $tab]);
                }
            } elseif($verifyGoogle && !$verifysms) {
                if($auth_type != 1) {
                    $this->ajaxReturn(['status' => 0, 'msg' => "参数错误！", 'tab' => $tab]);
                }
            } elseif(!$verifyGoogle && $verifysms) {
                if($auth_type != 0) {
                    $this->ajaxReturn(['status' => 0, 'msg' => "参数错误！", 'tab' => $tab]);
                }
            }
            if ($verifyGoogle && $auth_type == 1) {//谷歌安全码验证
                $google_code   = I('request.google_code');
                if(!$google_code) {
                    $this->ajaxReturn(['status' => 0, 'msg' => "谷歌安全码不能为空！", 'tab' => $tab]);
                } else {
                    $res = check_auth_error($uid, 5);
                    if(!$res['status']) {
                        $this->ajaxReturn(['status' => 0, 'msg' => $res['msg'], 'tab' => $tab]);
                    }
                    $ga = new \Org\Util\GoogleAuthenticator();
                    $google_secret_key = M('Admin')->where(['id'=>$uid])->getField('google_secret_key');
                    if(!$google_secret_key) {
                        $this->ajaxReturn(['status' => 0, 'msg' => "您未绑定谷歌身份验证器！", 'tab' => $tab]);
                    }
                    if(false === $ga->verifyCode($google_secret_key, $google_code, C('google_discrepancy'))) {
                        log_auth_error($uid,5);
                        $this->ajaxReturn(['status' => 0, 'msg' => "谷歌安全码错误！", 'tab' => $tab]);
                    } else {
                        clear_auth_error($uid,5);
                    }
                }
            } elseif($verifysms && $auth_type == 0) {//短信验证码
                $res = check_auth_error($uid, 3);
                if (!$res['status']) {
                    $this->ajaxReturn(['status' => 0, 'msg' => $res['msg'], 'tab' => $tab]);
                }
                $code = I('request.code');
                if (!$code) {
                    $this->ajaxReturn(['status' => 0, 'msg' => "短信验证码不能为空！", 'tab' => $tab]);
                } else {
                    if (session('send.tkconfig') != $code || !$this->checkSessionTime('tkconfig', $code)) {
                        log_auth_error($uid, 3);
                        $this->ajaxReturn(['status' => 0, 'msg' => '验证码错误', 'tab' => $tab]);
                    } else {
                        clear_auth_error($uid, 3);
                        session('send', null);
                    }
                }
            }
            if ($id) {
                $res = M("Tikuanconfig")->where(['id' => $id])->save($_rows);
            } else {
                $res = M("Tikuanconfig")->add($_rows);

            }
            $this->ajaxReturn(['status' => $res,'tab' => $tab]);
        }
    }

    /**
     * 编辑提款时间
     */
    public function settimeEdit()
    {
        if (IS_POST) {
            $id   = I('post.id', 0, 'intval');
            $tab = I('tab', 1, 'intval');
            $rows = I('post.u');
            $auth_type = I('request.auth_type',0,'intval');
            $uid               = session('admin_auth')['uid'];
            $verifysms = 0;//是否可以短信验证
            $sms_is_open = smsStatus();
            if($sms_is_open) {
                $adminMobileBind = adminMobileBind($uid);
                if($adminMobileBind) {
                    $verifysms = 1;
                }
            }
            //是否可以谷歌安全码验证
            $verifyGoogle = adminGoogleBind($uid);
            if($verifyGoogle && $verifysms) {
                if(!in_array($auth_type,[0,1])) {
                    $this->ajaxReturn(['status' => 0, 'msg' => "参数错误！", 'tab' => $tab]);
                }
            } elseif($verifyGoogle && !$verifysms) {
                if($auth_type != 1) {
                    $this->ajaxReturn(['status' => 0, 'msg' => "参数错误！", 'tab' => $tab]);
                }
            } elseif(!$verifyGoogle && $verifysms) {
                if($auth_type != 0) {
                    $this->ajaxReturn(['status' => 0, 'msg' => "参数错误！", 'tab' => $tab]);
                }
            }
            if ($verifyGoogle && $auth_type == 1) {//谷歌安全码验证
                $google_code   = I('request.google_code');
                if(!$google_code) {
                    $this->ajaxReturn(['status' => 0, 'msg' => "谷歌安全码不能为空！", 'tab' => $tab]);
                } else {
                    $res = check_auth_error($uid, 5);
                    if(!$res['status']) {
                        $this->ajaxReturn(['status' => 0, 'msg' => $res['msg']]);
                    }
                    $ga = new \Org\Util\GoogleAuthenticator();
                    $google_secret_key = M('Admin')->where(['id'=>$uid])->getField('google_secret_key');
                    if(!$google_secret_key) {
                        $this->ajaxReturn(['status' => 0, 'msg' => "您未绑定谷歌身份验证器！", 'tab' => $tab]);
                    }
                    if(false === $ga->verifyCode($google_secret_key, $google_code, C('google_discrepancy'))) {
                        log_auth_error($uid,5);
                        $this->ajaxReturn(['status' => 0, 'msg' => "谷歌安全码错误！", 'tab' => $tab]);
                    } else {
                        clear_auth_error($uid,5);
                    }
                }
            } elseif($verifysms && $auth_type == 0) {//短信验证码
                $res = check_auth_error($uid, 3);
                if (!$res['status']) {
                    $this->ajaxReturn(['status' => 0, 'msg' => $res['msg'], 'tab' => $tab]);
                }
                $code = I('request.code');
                if (!$code) {
                    $this->ajaxReturn(['status' => 0, 'msg' => "短信验证码不能为空！", 'tab' => $tab]);
                } else {
                    if (session('send.tkconfig') != $code || !$this->checkSessionTime('tkconfig', $code)) {
                        log_auth_error($uid, 3);
                        $this->ajaxReturn(['status' => 0, 'msg' => '验证码错误', 'tab' => $tab]);
                    } else {
                        clear_auth_error($uid, 3);
                        session('send', null);
                    }
                }
            }
            if ($id) {
                $res = M('Tikuanconfig')->where(['id' => $id, 'issystem' => 1])->save($rows);
            }
            $this->ajaxReturn(['status' => $res, 'tab'=>$tab]);
        }
    }

    public function addHoliday()
    {
        if (IS_POST) {
            $datetime = I("post.datetime");
            $tab = I('tab', 1, 'intval');
            if ($datetime) {
                $count = M('Tikuanholiday')->where(['datetime' => strtotime($datetime)])->count();
                if ($count) {
                    $this->ajaxReturn(['status' => 0, 'msg' => $datetime . '已存在!', 'tab' => $tab]);
                }
                $res = M('Tikuanholiday')->add(['datetime' => strtotime($datetime)]);
                $this->ajaxReturn(['status' => $res, 'tab' => $tab]);
            }
        }
    }

    public function delHoliday()
    {
        if (IS_POST) {
            $id = I("post.id", 0, 'intval');
            if ($id) {
                $res = M('Tikuanholiday')->where(["id" => $id])->delete();
                $this->ajaxReturn(['status' => $res]);
            }
        }
    }

    /**
     * 编辑自动代付设置
     */
    public function autoDfEdit()
    {
        if (IS_POST) {
            $id   = I('post.id', 0, 'intval');
            $tab = I('tab', 1, 'intval');
            $rows = I('post.u');
            $auth_type = I('request.auth_type',0,'intval');
            $uid               = session('admin_auth')['uid'];
            $verifysms = 0;//是否可以短信验证
            $sms_is_open = smsStatus();
            if($sms_is_open) {
                $adminMobileBind = adminMobileBind($uid);
                if($adminMobileBind) {
                    $verifysms = 1;
                }
            }
            //是否可以谷歌安全码验证
            $verifyGoogle = adminGoogleBind($uid);
            if($verifyGoogle && $verifysms) {
                if(!in_array($auth_type,[0,1])) {
                    $this->ajaxReturn(['status' => 0, 'msg' => "参数错误！", 'tab' => $tab]);
                }
            } elseif($verifyGoogle && !$verifysms) {
                if($auth_type != 1) {
                    $this->ajaxReturn(['status' => 0, 'msg' => "参数错误！", 'tab' => $tab]);
                }
            } elseif(!$verifyGoogle && $verifysms) {
                if($auth_type != 0) {
                    $this->ajaxReturn(['status' => 0, 'msg' => "参数错误！", 'tab' => $tab]);
                }
            }
            if ($verifyGoogle && $auth_type == 1) {//谷歌安全码验证
                $google_code   = I('request.google_code');
                if(!$google_code) {
                    $this->ajaxReturn(['status' => 0, 'msg' => "谷歌安全码不能为空！", 'tab' => $tab]);
                } else {
                    $res = check_auth_error($uid, 5);
                    if(!$res['status']) {
                        $this->ajaxReturn(['status' => 0, 'msg' => $res['msg']]);
                    }
                    $ga = new \Org\Util\GoogleAuthenticator();
                    $google_secret_key = M('Admin')->where(['id'=>$uid])->getField('google_secret_key');
                    if(!$google_secret_key) {
                        $this->ajaxReturn(['status' => 0, 'msg' => "您未绑定谷歌身份验证器！", 'tab' => $tab]);
                    }
                    if(false === $ga->verifyCode($google_secret_key, $google_code, C('google_discrepancy'))) {
                        log_auth_error($uid,5);
                        $this->ajaxReturn(['status' => 0, 'msg' => "谷歌安全码错误！", 'tab' => $tab]);
                    } else {
                        clear_auth_error($uid,5);
                    }
                }
            } elseif($verifysms && $auth_type == 0) {//短信验证码
                $res = check_auth_error($uid, 3);
                if (!$res['status']) {
                    $this->ajaxReturn(['status' => 0, 'msg' => $res['msg'], 'tab' => $tab]);
                }
                $code = I('request.code');
                if (!$code) {
                    $this->ajaxReturn(['status' => 0, 'msg' => "短信验证码不能为空！", 'tab' => $tab]);
                } else {
                    if (session('send.tkconfig') != $code || !$this->checkSessionTime('tkconfig', $code)) {
                        log_auth_error($uid, 3);
                        $this->ajaxReturn(['status' => 0, 'msg' => '验证码错误', 'tab' => $tab]);
                    } else {
                        clear_auth_error($uid, 3);
                        session('send', null);
                    }
                }
            }
            if ($id) {
                $res = M('Tikuanconfig')->where(['id' => $id, 'issystem' => 1])->save($rows);
            }
            $this->ajaxReturn(['status' => $res, 'tab' => $tab]);
        }
    }

    /**
     * 导出提款记录
     */
    public function exportorder()
    {
        $where    = array();
        $memberid = I("get.memberid", 0, 'intval');
        if ($memberid) {
            $where['userid'] = array('eq', $memberid - 10000);
        }
        $tongdao = I("request.tongdao", '', 'trim,string,strip_tags,htmlspecialchars');
        if ($tongdao) {
            $where['payapiid'] = array('eq', $tongdao);
        }
        $T = I("request.T", '', 'trim,string,strip_tags,htmlspecialchars');
        if ($T != "") {
            $where['t'] = array('eq', $T);
        }
        $status = I("request.status", 0, 'intval');
        if ($status) {
            $where['status'] = array('eq', $status);
        }
        $createtime = urldecode(I("request.createtime", '', 'trim,string,strip_tags,htmlspecialchars'));
        if ($createtime) {
            list($cstime, $cetime) = explode('|', $createtime);
            $where['sqdatetime']   = ['between', [$cstime, $cetime ? $cetime : date('Y-m-d')]];
        }
        $successtime = urldecode(I("request.successtime", '', 'trim,string,strip_tags,htmlspecialchars'));
        if ($successtime) {
            list($sstime, $setime) = explode('|', $successtime);
            $where['cldatetime']   = ['between', [$sstime, $setime ? $setime : date('Y-m-d')]];
        }

        $title = array('类型', '商户编号', '结算金额', '手续费', '到账金额', '银行名称', '支行名称', '银行卡号', '开户名', '所属省', '所属市', '申请时间', '处理时间', '状态', "备注");
        $data  = M('Tklist')->where($where)->select();
        foreach ($data as $item) {
            switch ($item['status']) {
                case 0:
                    $status = '未处理';
                    break;
                case 1:
                    $status = '处理中';
                    break;
                case 2:
                    $status = '已打款';
                    break;
                case 3:
                    $status = "已驳回";
                    break;
                case 4:
                    $status = "待确认";
                    break;
            }
            switch ($item['t']) {
                case 0:
                    $tstr = 'T + 0';
                    break;
                case 1:
                    $tstr = 'T + 1';
                    break;
            }

            $list[] = array(
                't'            => $tstr,
                'memberid'     => $item['userid'] + 10000,
                'tkmoney'      => $item['tkmoney'],
                'sxfmoney'     => $item['sxfmoney'],
                'money'        => $item['money'],
                'bankname'     => $item['bankname'],
                'bankzhiname'  => $item['bankzhiname'],
                'banknumber'   => $item['banknumber'],
                'bankfullname' => $item['bankfullname'],
                'sheng'        => $item['sheng'],
                'shi'          => $item['shi'],
                'sqdatetime'   => $item['sqdatetime'],
                'cldatetime'   => $item['cldatetime'],
                'status'       => $status,
                "memo"         => $item["memo"],
            );
        }
        $numberField = ['tkmoney', 'sxfmoney', 'money'];
        exportexcel($list, $title, $numberField);
    }

    /**
     * 代付记录
     */
    public function payment()
    {
        //通道
        $banklist = M("Product")->field('id,name,code')->select();
        $this->assign("banklist", $banklist);

        $where    = array();
        $memberid = I("get.memberid", 0, 'intval');
        if ((intval($memberid) - 10000) > 0) {
            $where['userid'] = array('eq', $memberid - 10000);
        }
        $this->assign("memberid", $memberid);
        $orderid = I("request.orderid", '', 'string,strip_tags,htmlspecialchars');
        if ($orderid) {
            $where['orderid'] = array('eq', $orderid);
        }
        $this->assign("orderid", $orderid);
		$out_trade_no = I("request.outtradeno", '', 'string,strip_tags,htmlspecialchars');
        if ($out_trade_no) {
            $where['out_trade_no'] = array('eq', $out_trade_no);
        }
        $this->assign("out_trade_no", $out_trade_no);
        $bankfullname = I("request.bankfullname", '', 'string,strip_tags,htmlspecialchars');
        if ($bankfullname) {
            $where['bankfullname'] = array('eq', $bankfullname);
        }
        $this->assign("bankfullname", $bankfullname);
        $tongdao = I("request.tongdao", '', 'string,strip_tags,htmlspecialchars');
        if ($tongdao) {
            $where['payapiid'] = array('eq', $tongdao);
        }
        $this->assign("tongdao", $tongdao);
        $T = I("request.T", '', 'string,strip_tags,htmlspecialchars');
        if ($T != "") {
            $where['t'] = array('eq', $T);
        }
        $this->assign("T", $T);
        $status = I("get.status", '');

        if ($status != '') {
            $where['status'] = array('eq', $status);
        }
        $this->assign("status", $status);
        $dfid = I("get.dfid", '', 'string,strip_tags,htmlspecialchars');

        if ($dfid != '') {
            $where['df_id'] = array('eq', $dfid);
        }
        $this->assign("dfid", $dfid);
        $createtime = urldecode(I("request.createtime", '', 'string,strip_tags,htmlspecialchars'));
        if ($createtime) {
            list($cstime, $cetime) = explode('|', $createtime);
            $where['sqdatetime']   = ['between', [$cstime, $cetime ? $cetime : date('Y-m-d')]];
        }
        $this->assign("createtime", $createtime);
        $successtime = urldecode(I("request.successtime", '', 'string,strip_tags,htmlspecialchars'));
        if ($successtime) {
            list($sstime, $setime) = explode('|', $successtime);
            $where['cldatetime']   = ['between', [$sstime, $setime ? $setime : date('Y-m-d')]];
        }
        $this->assign("successtime", $successtime);
        $count = M('Wttklist')->where($where)->count();
        $size  = 15;
        $rows  = I('get.rows', $size, 'intval');
        if (!$rows) {
            $rows = $size;
        }
        $page = new Page($count, $rows);
        $list = M('Wttklist')
            ->where($where)
            ->limit($page->firstRow . ',' . $page->listRows)
            ->order('id desc')
            ->select();

        $pfa_lists = M('PayForAnother')->where(['status' => 1])->select();

        $df_list = M('PayForAnother')->select();
        //统计总结算信息
        $totalMap           = $where;
        $totalMap['status'] = 2;
        //结算金额
        $stat['total'] = round(M('Wttklist')->where($totalMap)->sum('money'), 2);
        //待结算
        $totalMap['status'] = ['in', '0,1'];
        $stat['total_wait'] = round(M('Wttklist')->where($totalMap)->sum('money'), 2);
        //完成笔数
        $totalMap['status']          = 2;
        $stat['total_success_count'] = M('Wttklist')->where($totalMap)->count();
        //驳回笔数
        $totalMap['status']       = 3;
        $stat['total_fail_count'] = M('Wttklist')->where($totalMap)->count();
        //平台手续费利润
        $totalMap['status']   = 2;
        $stat['total_profit'] = M('Wttklist')->where($totalMap)->sum('sxfmoney-cost');

        //统计今日代付信息
        $beginToday = mktime(0, 0, 0, date('m'), date('d'), date('Y'));
        $endToday   = mktime(0, 0, 0, date('m'), date('d') + 1, date('Y')) - 1;
        if ($dfid != '') {
            $map['df_id'] = array('eq', $dfid);
        }
        if($successtime) {//如果搜索条件是打款时间
            $map['cldatetime']   = array('between', array(date('Y-m-d H:i:s', $beginToday), date('Y-m-d H:i:s', $endToday)));
            if($createtime) {
                $map['sqdatetime']   = array('between', array(date('Y-m-d H:i:s', $beginToday), date('Y-m-d H:i:s', $endToday)));
            }
        } else {
            $map['sqdatetime']   = array('between', array(date('Y-m-d H:i:s', $beginToday), date('Y-m-d H:i:s', $endToday)));
        }
        //今日代付总金额
        $map['status']       = 2;
        $stat['totay_total'] = round(M('Wttklist')->where($map)->sum('money'), 2);
        //今日代付成功笔数
        $stat['totay_success_count'] = M('Wttklist')->where($map)->count();
        //今日平台手续费利润
        $stat['totay_profit'] = M('Wttklist')->where($map)->sum('sxfmoney-cost');
        if(isset($map['cldatetime'])) {
            unset($map['cldatetime']);
            if(!isset( $map['sqdatetime'])) {
                $map['sqdatetime'] = array('between', array(date('Y-m-d H:i:s', $beginToday), date('Y-m-d H:i:s', $endToday)));
            }
        }
        //今日代付待结算
        $map['status']      = ['in', '0,1'];
        $stat['totay_wait'] = round(M('Wttklist')->where($map)->sum('money'), 2);
        //今日代付失败笔数
        $map['status']            = ['in', '3,4'];
        $stat['totay_fail_count'] = M('Wttklist')->where($map)->count();
        //统计本月代付信息
        $monthBegin = date('Y-m-01') . ' 00:00:00';
        if($successtime) {//如果搜索条件是打款时间
            $map['cldatetime']   = array('egt', $monthBegin);
            if($createtime) {
                $map['sqdatetime']   = array('egt', $monthBegin);
            }
        } else {
            $map['sqdatetime']   = array('egt', $monthBegin);
        }
        //本月代付总金额
        $map['status']       = 2;
        $stat['month_total'] = round(M('Wttklist')->where($map)->sum('money'), 2);
        //本月代付成功笔数
        $stat['month_success_count'] = M('Wttklist')->where($map)->count();
        //本月平台手续费利润
        $stat['month_profit'] = M('Wttklist')->where($map)->sum('sxfmoney-cost');
        if(isset($map['cldatetime'])) {
            unset($map['cldatetime']);
            if(!isset($map['sqdatetime'])) {
                $map['sqdatetime']  = array('egt',  $monthBegin);
            }
        }
        //本月代付待结算
        $map['status']      = ['in', '0,1'];
        $stat['month_wait'] = round(M('Wttklist')->where($map)->sum('money'), 2);
        //本月代付失败笔数
        $map['status']            = ['in', '3,4'];
        $stat['month_fail_count'] = M('Wttklist')->where($map)->count();
        foreach ($stat as $k => $v) {
            $stat[$k] += 0;
        }
        $this->assign('stat', $stat);
        $this->assign('rows', $rows);
        $this->assign("pfa_lists", $pfa_lists);
        $this->assign("df_list", $df_list);
        $this->assign("list", $list);
        $this->assign("page", $page->show());
        C('TOKEN_ON', false);
        $this->display();
    }

    //导出委托提款记录
    public function exportweituo()
    {
        $where    = array();
        $memberid = I("get.memberid", 0, 'intval');
        if ($memberid) {
            $where['userid'] = array('eq', $memberid - 10000);
        }
        $tongdao = I("request.tongdao", '', 'string,strip_tags,htmlspecialchars');
        if ($tongdao) {
            $where['payapiid'] = array('eq', $tongdao);
        }
        $T = I("request.T", '', 'string,strip_tags,htmlspecialchars');
        if ($T != "") {
            $where['t'] = array('eq', $T);
        }
        $status = I("request.status", 0, 'intval');
        if ($status) {
            $where['status'] = array('eq', $status);
        }
        $createtime = urldecode(I("request.createtime", '', 'string,strip_tags,htmlspecialchars'));
        if ($createtime) {
            list($cstime, $cetime) = explode('|', $createtime);
            $where['sqdatetime']   = ['between', [$cstime, $cetime ? $cetime : date('Y-m-d')]];
        }
        $successtime = urldecode(I("request.successtime", '', 'string,strip_tags,htmlspecialchars'));
        if ($successtime) {
            list($sstime, $setime) = explode('|', $successtime);
            $where['cldatetime']   = ['between', [$sstime, $setime ? $setime : date('Y-m-d')]];
        }

        $title = array('类型', '商户编号', '通道名称', '通道商户号', '系统订单号', '结算金额', '手续费', '到账金额', '银行名称', '支行名称', '银行卡号', '开户名', '所属省', '所属市', '申请时间', '处理时间', '状态', "备注");
        $data  = M('Wttklist')->where($where)->select();
        foreach ($data as $item) {
            switch ($item['status']) {
                case 0:
                    $status = '未处理';
                    break;
                case 1:
                    $status = '处理中';
                    break;
                case 2:
                    $status = '已打款';
                    break;
                case 3:
                    $status = "已驳回";
                    break;
                case 4:
                    $status = "转账失败";
                    break;
            }
            switch ($item['t']) {
                case 0:
                    $tstr = 'T + 0';
                    break;
                case 1:
                    $tstr = 'T + 1';
                    break;
            }

            $list[] = array(
                't'              => $tstr,
                'memberid'       => $item['userid'] + 10000,
                'df_name'        => $item['df_name'],
                'channel_mch_id' => $item['channel_mch_id'],
                'orderid'        => $item['orderid'],
                'tkmoney'        => $item['tkmoney'],
                'sxfmoney'       => $item['sxfmoney'],
                'money'          => $item['money'],
                'bankname'       => $item['bankname'],
                'bankzhiname'    => $item['bankzhiname'],
                'banknumber'     => $item['banknumber'],
                'bankfullname'   => $item['bankfullname'],
                'sheng'          => $item['sheng'],
                'shi'            => $item['shi'],
                'sqdatetime'     => $item['sqdatetime'],
                'cldatetime'     => $item['cldatetime'],
                'status'         => $status,
                "memo"           => $item["memo"],
            );
        }
        $numberField = ['tkmoney', 'sxfmoney', 'money'];
        exportexcel($list, $title, $numberField);
    }

    public function dftikuanlist()
    {
        $Payapi      = M("Payapi");
        $tongdaolist = $Payapi->select();
        $this->assign("tongdaolist", $tongdaolist); // 通道列表

        $Systembank = M("Systembank");
        $banklist   = $Systembank->select();
        $this->assign("banklist", $banklist); // 银行列表

        $where    = array();
        $memberid = I("get.memberid", 0, 'intval');
        $i        = 0;
        if ($memberid) {
            $where[$i] = "userid = " . ($memberid - 10000);
            $i++;
        }

        $tongdao = I("get.tongdao", '', 'string,strip_tags,htmlspecialchars');
        if ($tongdao) {
            $where[$i] = "payapiid = " . $tongdao;
            $i++;
        }

        $bank = I("get.bank", '', 'string,strip_tags,htmlspecialchars');
        if ($bank) {
            $where[$i] = "bankname = '" . $bank . "'";
            $i++;
        }

        $T = I("get.T", '', 'string,strip_tags,htmlspecialchars');
        if ($T != "") {
            $where[$i] = "t = " . $T;
            $i++;
        }

        $status = I("get.status",'0','intval');
        if ($status) {
            $where[$i] = "status = " . $status;
            $i++;
        }

        $tjdate_ks = I("get.tjdate_ks", '', 'string,strip_tags,htmlspecialchars');
        if ($tjdate_ks) {
            $where[$i] = " DATEDIFF('" . $tjdate_ks . "',sqdatetime) <= 0";

            $i++;
        }

        $tjdate_js = I("get.tjdate_js", '', 'string,strip_tags,htmlspecialchars');
        if ($tjdate_js) {
            $where[$i] = " DATEDIFF('" . $tjdate_js . "',sqdatetime) >= 0";

            $i++;
        }

        $cgdate_ks = I("get.cgdate_ks", '', 'string,strip_tags,htmlspecialchars');
        if ($cgdate_ks) {
            $where[$i] = " DATEDIFF('" . $cgdate_ks . "',cldatetime) <= 0";

            $i++;
        }

        $cgdate_js = I("get.cgdate_js", '', 'string,strip_tags,htmlspecialchars');
        if ($cgdate_js) {
            $where[$i] = " DATEDIFF('" . $cgdate_js . "',cldatetime) >= 0";

            $i++;
        }

        $list = $this->lists("dflist", $where);
        $this->assign("list", $list);
        $this->display();
    }

    //代付结算
    //代付结算
    public function editStatus()
    {
        $id = I("request.id", 0, 'intval');
        if (IS_POST) {
            $status  = I("post.status", 0, 'intval');
            $userid  = I('post.userid', 0, 'intval');
            $image  = I('image');
            $tkmoney = I('post.tkmoney');
            if (!$id) {
                $this->ajaxReturn(['status' => 0, 'msg' => '操作失败']);
            }
            if($status == 2 && $image == null){
                $this->ajaxReturn(['status' => 0, 'msg' => '处理状态为已处理时候，必须上传凭证！']);
            }
            $map['id'] = $id;
            //开启事务
            M()->startTrans();
            $Tklist    = M("Tklist");
            $map['id'] = $id;
            $withdraw  = $Tklist->where($map)->lock(true)->find();
            if (empty($withdraw)) {
                $this->ajaxReturn(['status' => 0, 'msg' => '提款申请不存在']);
            }
            $data           = [];
            $data["status"] = $status;

            //判断状态
            switch ($status) {
                case '2':
                    $data["cldatetime"] = date("Y-m-d H:i:s");
                    break;
                case '3':
					if ($withdraw['status'] == 2) {
                        $this->ajaxReturn(['status' => 0, 'msg' => '提款申请已打款，不能驳回']);
                    } elseif ($withdraw['status'] == 3) {
                        $this->ajaxReturn(['status' => 0, 'msg' => '提款申请已驳回，不能驳回']);
                    }
					$map['_string'] = 'status=0 OR status=1';
                    //驳回操作
                    //1,将金额返回给商户
                    $Member     = M('Member');
                    $memberInfo = $Member->where(['id' => $userid])->lock(true)->find();
                    $res        = $Member->where(['id' => $userid])->save(['balance' => array('exp', "balance+{$tkmoney}")]);
                    if (!$res) {
                        M()->rollback();
                        $this->ajaxReturn(['status' => 0]);
                    }
                    //2,记录流水订单号
                    $arrayField = array(
                        "userid"     => $userid,
                        "ymoney"     => $memberInfo['balance'],
                        "money"      => $tkmoney,
                        "gmoney"     => $memberInfo['balance'] + $tkmoney,
                        "datetime"   => date("Y-m-d H:i:s"),
                        "tongdao"    => 0,
                        "transid"    => $id,
                        "orderid"    => $id,
                        "lx"         => 11,
                        'contentstr' => '结算驳回',
                    );
                    $res = M('Moneychange')->add($arrayField);
                    if (!$res) {
                        M()->rollback();
                        $this->ajaxReturn(['status' => 0]);
                    }
                    //结算驳回退回手续费
                    if ($withdraw['tk_charge_type'] && $withdraw['sxfmoney']>0) {
                        $res = $Member->where(['id' => $withdraw['userid']])->save(['balance' => array('exp', "balance+{$withdraw['sxfmoney']}")]);
                        if (!$res) {
                            M()->rollback();
                            $this->ajaxReturn(['status' => 0]);
                        }
                        $chargeField = array(
                            "userid"     => $withdraw['userid'],
                            "ymoney"     => $memberInfo['balance'] + $withdraw['tkmoney'],
                            "money"      => $withdraw['sxfmoney'],
                            "gmoney"     => $memberInfo['balance'] + $withdraw['tkmoney'] + $withdraw['sxfmoney'],
                            "datetime"   => date("Y-m-d H:i:s"),
                            "tongdao"    => 0,
                            "transid"    => $id,
                            "orderid"    => $id,
                            "lx"         => 17,
                            'contentstr' => '手动结算驳回退回手续费',
                        );
                        $res = M('Moneychange')->add($chargeField);
                        if (!$res) {
                            M()->rollback();
                            $this->ajaxReturn(['status' => 0]);
                        }
                    }
                    $data["cldatetime"] = date("Y-m-d H:i:s");
                    break;
                default:
                    # code...
                    break;
            }
            //修改结算的数据
            if(I('post.memo')) {
                $data["memo"] = I('post.memo').' - '.date('Y-m-d H:i:s').'<br>'.$withdraw['memo'];

            }

            $res = $Tklist->where($map)->save($data);
            if ($res) {
                M()->commit();
                $this->ajaxReturn(['status' => $res]);
            }

            M()->rollback();
            $this->ajaxReturn(['status' => 0]);

        } else {
            $info = M('Tklist')->where(['id' => $id])->find();
            $this->assign('info', $info);
            $this->display();
        }
    }
	/**
     *  单条数据查看
     */
    public function look(){
        $id = I('get.id', 0, 'intval');
        $info = M('Tklist')->where(['id' => $id])->find();
        $info['upload_time'] = $info['image'] ?date('Y-m-d H:i:s', $info['upload_time']):'暂无上传时间';
        $this->assign('info', $info);
        $this->display();
    }
    /**
     *  委托提现
     */
    public function editwtStatus()
    {
        $id = I("request.id", 0, 'intval');
        if (IS_POST) {
            $status  = I("post.status", 0, 'intval');
            $userid  = I('post.userid', 0, 'intval');
            $tkmoney = I('post.tkmoney');

            if (!$id) {
                $this->ajaxReturn(['status' => 0, 'msg' => '操作失败']);
            }
            //开启事物
            M()->startTrans();
            $Wttklist  = M("Wttklist");
            $map['id'] = $id;
            $withdraw  = $Wttklist->where($map)->lock(true)->find();
            if (empty($withdraw)) {
                $this->ajaxReturn(['status' => 0, 'msg' => '提款申请不存在']);
            }
            $data           = [];
            $data["status"] = $status;
            $wtStatus       = $Wttklist->where(['id' => $id])->getField('status');
            if ($wtStatus == 2 || $wtStatus == 3) {
                M()->rollback();
                $this->ajaxReturn(['status' => 0]);
            }
            //判断状态
            switch ($status) {
                case '2':
                    $data["cldatetime"] = date("Y-m-d H:i:s");
                    break;
                case '3':
                    if ($withdraw['status'] == 2) {
                        $this->ajaxReturn(['status' => 0, 'msg' => '提款申请已打款，不能驳回']);
                    } elseif ($withdraw['status'] == 3) {
                        $this->ajaxReturn(['status' => 0, 'msg' => '提款申请已驳回，不能驳回']);
                    }
                    $map['_string'] = 'status=0 OR status=1 OR status=4';
                    //驳回操作
                    //1,将金额返回给商户
                    $Member     = M('Member');
                    $memberInfo = $Member->where(['id' => $userid])->lock(true)->find();
                    $res        = $Member->where(['id' => $userid])->save(['balance' => array('exp', "balance+{$tkmoney}")]);

                    if (!$res) {
                        M()->rollback();
                        $this->ajaxReturn(['status' => 0]);
                    }

                    //2,记录流水订单号
                    $arrayField = array(
                        "userid"     => $userid,
                        "ymoney"     => $memberInfo['balance'],
                        "money"      => $tkmoney,
                        "gmoney"     => $memberInfo['balance'] + $tkmoney,
                        "datetime"   => date("Y-m-d H:i:s"),
                        "tongdao"    => 0,
                        "transid"    => $id,
                        "orderid"    => $id,
                        "lx"         => 12,
                        'contentstr' => '代付驳回',
                    );
                    $res = M('Moneychange')->add($arrayField);

                    if (!$res) {
                        M()->rollback();
                        $this->ajaxReturn(['status' => 0]);
                    }
                    //代付驳回退回手续费
                    if ($withdraw['df_charge_type'] && $withdraw['sxfmoney']>0) {
                        $res = $Member->where(['id' => $withdraw['userid']])->save(['balance' => array('exp', "balance+{$withdraw['sxfmoney']}")]);
                        if (!$res) {
                            M()->rollback();
                            $this->ajaxReturn(['status' => 0]);
                        }
                        $chargeField = array(
                            "userid"     => $withdraw['userid'],
                            "ymoney"     => $memberInfo['balance'] + $tkmoney,
                            "money"      => $withdraw['sxfmoney'],
                            "gmoney"     => $memberInfo['balance'] + $tkmoney + $withdraw['sxfmoney'],
                            "datetime"   => date("Y-m-d H:i:s"),
                            "tongdao"    => 0,
                            "transid"    => $id,
                            "orderid"    => $id,
                            "lx"         => 15,
                            'contentstr' => '代付结算驳回退回手续费',
                        );
                        $res = M('Moneychange')->add($chargeField);
                        if (!$res) {
                            M()->rollback();
                            $this->ajaxReturn(['status' => 0]);
                        }
                    }
                    $data["cldatetime"] = date("Y-m-d H:i:s");
                    break;
                default:
                    # code...
                    break;
            }
            if(I('post.memo')) {
                $data["memo"] = I('post.memo') . ' - ' . date('Y-m-d H:i:s') . '<br>' . $withdraw['memo'];
            }
            $res = $Wttklist->where($map)->save($data);

            if ($res) {
                M()->commit();
                $this->ajaxReturn(['status' => $res]);
            }

            M()->rollback();
            $this->ajaxReturn(['status' => 0]);

        } else {
            $info = M('Wttklist')->where(['id' => $id])->find();
            $this->assign('info', $info);
            $this->display();
        }
    }
    /**
     *  批量委托提现
     */
    public function editwtAllStatus()
    {

        $ids    = I('post.id', '');
        $ids    = explode(',', trim($ids, ','));
        $status = I('post.status', 0, 'intval');
        if($status != 3 && $status !=2) {
            $this->ajaxReturn(['status' => 0, 'msg' => '参数错误']);
        }
        $Tklist  = M("Tklist");
        $success = $fail = 0;
        if ($status == 3) {
//一键驳回
            foreach ($ids as $k => $v) {
                try {
                    M()->startTrans();
                    if (intval($v)) {
                        $withdraw = $Tklist->where(['id' => $v])->find();
                        if (empty($withdraw)) {
                            M()->rollback();
                            $fail++;
                            continue;
                        }
                        if ($withdraw['status'] == 1) {
//提款申请处理中，不能驳回
                            M()->rollback();
                            $fail++;
                            continue;
                        } elseif ($withdraw['status'] == 2) {
//提款申请已打款，不能驳回
                            M()->rollback();
                            $fail++;
                            continue;
                        } elseif ($withdraw['status'] == 3) {
//提款申请已驳回，不能驳回
                            M()->rollback();
                            $fail++;
                            continue;
                        }
                        $map['status'] = 0;
                        //驳回操作
                        //1,将金额返回给商户
                        $Member     = M('Member');
                        $memberInfo = $Member->where(['id' => $withdraw['userid']])->lock(true)->find();
                        $res        = $Member->where(['id' => $withdraw['userid']])->save(['balance' => array('exp', "balance+{$withdraw['tkmoney']}")]);
                        if (!$res) {
                            M()->rollback();
                            $fail++;
                            continue;
                        }
                        //2,记录流水订单号
                        $arrayField = array(
                            "userid"     => $withdraw['userid'],
                            "ymoney"     => $memberInfo['balance'],
                            "money"      => $withdraw['tkmoney'],
                            "gmoney"     => $memberInfo['balance'] + $withdraw['tkmoney'],
                            "datetime"   => date("Y-m-d H:i:s"),
                            "tongdao"    => 0,
                            "transid"    => $v,
                            "orderid"    => $v,
                            "lx"         => 11,
                            'contentstr' => '结算驳回',
                        );
                        $res = M('Moneychange')->add($arrayField);
                        if (!$res) {
                            M()->rollback();
                            $fail++;
                            continue;
                        }
                        //结算驳回退回手续费
                        if ($withdraw['tk_charge_type'] && $withdraw['sxfmoney']>0) {
                            $res = $Member->where(['id' => $withdraw['userid']])->save(['balance' => array('exp', "balance+{$withdraw['sxfmoney']}")]);
                            if (!$res) {
                                M()->rollback();
                                $fail++;
                                continue;
                            }
                            $chargeField = array(
                                "userid"     => $withdraw['userid'],
                                "ymoney"     => $memberInfo['balance'] + $withdraw['tkmoney'],
                                "money"      => $withdraw['sxfmoney'],
                                "gmoney"     => $memberInfo['balance'] + $withdraw['tkmoney'] + $withdraw['sxfmoney'],
                                "datetime"   => date("Y-m-d H:i:s"),
                                "tongdao"    => 0,
                                "transid"    => $v,
                                "orderid"    => $v,
                                "lx"         => 17,
                                'contentstr' => '手动结算驳回退回手续费',
                            );
                            $res = M('Moneychange')->add($chargeField);
                            if (!$res) {
                                M()->rollback();
                                $fail++;
                                continue;
                            }
                        }
                        $data['status']     = 3;
                        $data["cldatetime"] = date("Y-m-d H:i:s");
                        $res                = $Tklist->where(['id' => $v, 'status' => 0])->save($data);
                        if ($res === false) {
                            M()->rollback();
                            $fail++;
                            continue;
                        } else {
                            M()->commit();
                            $success++;
                        }
                    } else {
                        M()->rollback();
                        $fail++;
                        continue;
                    }
                } catch (\Exception $e) {
                    M()->rollback();
                    $fail++;
                    continue;
                }
            }
            if ($success > 0) {
                $this->ajaxReturn(['status' => 1, 'msg' => '成功驳回：' . $success . '，失败：' . $fail]);
            } else {
                $this->ajaxReturn(['status' => 0, 'msg' => '驳回失败!']);
            }
        } else {
            foreach ($ids as $k => $v) {
                try {
                    M()->startTrans();
                    if (intval($v)) {
                        $withdraw = $Tklist->where(['id' => $v])->find();
                        if (empty($withdraw)) {
                            M()->rollback();
                            $fail++;
                            continue;
                        }
                        if ($withdraw['status'] == 3) {
                            M()->rollback();
                            $fail++;
                            continue;
                        }
                        $data = [
                            "status"     => $status,
                            'cldatetime' => date("Y-m-d H:i:s"),
                        ];

                        $res = $Tklist->where(['id' => $v, 'status'=>['neq', 3]])->save($data);
                        if ($res === false) {
                            M()->rollback();
                            $fail++;
                            continue;
                        } else {
                            M()->commit();
                            $success++;
                        }
                    } else {
                        M()->rollback();
                        $fail++;
                        continue;
                    }
                } catch (\Exception $e) {
                    M()->rollback();
                    $fail++;
                    continue;
                }
            }
            if ($success > 0) {
                $this->ajaxReturn(['status' => 1, 'msg' => '成功完成：' . $success . '，失败：' . $fail]);
            } else {
                $this->ajaxReturn(['status' => 0, 'msg' => '完成操作失败!']);
            }
        }
    }
    //提现语音提现
    public function checkNotice()
    {
        //提款记录
        $tikuan = M('Tklist')->where(['status' => 0])->count();
        //委托提款
        $wttikuan = M('Wttklist')->where(['status' => 0])->count();
        $this->ajaxReturn(['errorno' => 0, 'num' => ($tikuan + $wttikuan)]);
    }

    //提交代申请
    public function submitDf()
    {
        $uid         = session('admin_auth')['uid'];
        $verifysms   = 0; //是否可以短信验证
        $sms_is_open = smsStatus();
        if ($sms_is_open) {
            $adminMobileBind = adminMobileBind($uid);
            if ($adminMobileBind) {
                $verifysms = 1;
            }
        }
        //是否可以谷歌安全码验证
        $verifyGoogle = 0;
        $googleAuth   = M('Websiteconfig')->getField('google_auth');
        if ($googleAuth) {
            $verifyGoogle = adminGoogleBind($uid);
        }

        if (IS_POST) {
            $uid               = session('admin_auth')['uid'];
            $ids = I('request.ids');
            if (!$ids) {
                $this->ajaxReturn(['status' => 0, 'msg' => "请选择代付申请！"]);
            }
            $ids_array = explode(',', $ids);
            if (empty($ids_array)) {
                $this->ajaxReturn(['status' => 0, 'msg' => "参数错误！"]);
            } else {
                if (count($ids_array) > 1) {
                    $channe_code = 'default'; //默认代付渠道;
                } else {
                    $channe_code = I('request.channe_code', '');
                }
            }
            if (!$channe_code) {
                $channe_code = 'default';
            }
            $auth_type = I('request.auth_type', 0, 'intval');

            if($verifyGoogle && $verifysms) {
                if(!in_array($auth_type,[0,1])) {
                    $this->ajaxReturn(['status' => 0, 'msg' => "参数错误！"]);
                }
            } elseif($verifyGoogle && !$verifysms) {
                if($auth_type != 1) {
                    $this->ajaxReturn(['status' => 0, 'msg' => "参数错误！"]);
                }
            } elseif(!$verifyGoogle && $verifysms) {
                if($auth_type != 0) {
                    $this->ajaxReturn(['status' => 0, 'msg' => "参数错误！"]);
                }
            }
            if ($verifyGoogle && $auth_type == 1) {
                $res = check_auth_error($uid, 5);
                if(!$res['status']) {
                    $this->ajaxReturn(['status' => 0, 'msg' => $res['msg']]);
                }
                //谷歌安全码验证
                $google_code = I('request.google_code');
                if (!$google_code) {
                    $this->ajaxReturn(['status' => 0, 'msg' => "谷歌安全码不能为空！"]);
                } else {
                    $ga                = new \Org\Util\GoogleAuthenticator();
                    $google_secret_key = M('Admin')->where(['id' => $uid])->getField('google_secret_key');
                    if (!$google_secret_key) {
                        $this->ajaxReturn(['status' => 0, 'msg' => "您未绑定谷歌身份验证器！"]);
                    }
                    if(false === $ga->verifyCode($google_secret_key, $google_code, C('google_discrepancy'))) {
                        log_auth_error($uid,5);
                        $this->ajaxReturn(['status' => 0, 'msg' => "谷歌安全码错误！"]);
                    } else {
                        clear_auth_error($uid,5);
                    }
                }
            } elseif ($verifysms && $auth_type == 0) {
                $res = check_auth_error($uid, 3);
                if(!$res['status']) {
                    $this->ajaxReturn(['status' => 0, 'msg' => $res['msg']]);
                }
                //短信验证码
                $code = I('request.code');
                if (!$code) {
                    $this->ajaxReturn(['status' => 0, 'msg' => "短信验证码不能为空！"]);
                } else {
                    if (session('send.submitDfSend') != $code || !$this->checkSessionTime('submitDfSend', $code)) {
                        log_auth_error($uid,3);
                        $this->ajaxReturn(['status' => 0, 'msg' => '短信验证码错误']);
                    } else {
                        clear_auth_error($uid,3);
                        session('send', null);
                    }
                }
            }
            session('admin_submit_df', 1);
            $_REQUEST = [
                'code' => $channe_code,
                'id'   => $ids,
                'opt'  => 'exec',
            ];
            return R('Payment/Index/index');
        } else {
            $ids = I('request.ids');
            if (!$ids) {
                $this->error('缺少参数');
            }
            $channe_code = I('request.channe_code', '');
            $uid         = session('admin_auth')['uid'];
            $user        = M('Admin')->where(['id' => $uid])->find();
            $this->assign('mobile', $user['mobile']);
            $this->assign('ids', $ids);
            $this->assign('channe_code', $channe_code);
            $this->assign('verifysms', $verifysms);
            $this->assign('verifyGoogle', $verifyGoogle);
            $this->assign('auth_type', $verifyGoogle ? 1 : 0);
            $this->display();
        }
    }

    /**
     * 发送提交代付验证码信息
     */
    public function submitDfSend()
    {
        $uid               = session('admin_auth')['uid'];
        $user = M('Admin')->where(['id'=>$uid])->find();
        $res    = $this->send('submitDfSend', $user['mobile'], '提交代付');
        $this->ajaxReturn(['status' => $res['code']]);
    }

    /**
     *  批量驳回代付申请
     */
    public function rejectAllDf()
    {

        $ids     = I('post.id', '');
        $ids     = explode(',', trim($ids, ','));
        $Tklist  = M("wttklist");
        $success = $fail = 0;
        foreach ($ids as $k => $v) {
            try {
                M()->startTrans();
                if (intval($v)) {
                    $withdraw = $Tklist->where(['id' => $v])->find();
                    if (empty($withdraw)) {
                        M()->rollback();
                        $fail++;
                        continue;
                    }
                    if ($withdraw['status'] == 1) {
                        M()->rollback();
                        $fail++;
                        continue;
                    } elseif ($withdraw['status'] == 2) {
                        M()->rollback();
                        $fail++;
                        continue;
                    } elseif ($withdraw['status'] == 3) {
                        M()->rollback();
                        $fail++;
                        continue;
                    }
                    $map['_string'] = 'status=0 OR status=4';
                    //驳回操作
                    //1,将金额返回给商户
                    $Member     = M('Member');
                    $memberInfo = $Member->where(['id' => $withdraw['userid']])->lock(true)->find();
                    $res        = $Member->where(['id' => $withdraw['userid']])->save(['balance' => array('exp', "balance+{$withdraw['tkmoney']}")]);

                    if (!$res) {
                        M()->rollback();
                        $fail++;
                        continue;
                    }

                    //2,记录流水订单号
                    $arrayField = array(
                        "userid"     => $withdraw['userid'],
                        "ymoney"     => $memberInfo['balance'],
                        "money"      => $withdraw['tkmoney'],
                        "gmoney"     => $memberInfo['balance'] + $withdraw['tkmoney'],
                        "datetime"   => date("Y-m-d H:i:s"),
                        "tongdao"    => 0,
                        "transid"    => $v,
                        "orderid"    => $v,
                        "lx"         => 12,
                        'contentstr' => '代付驳回',
                    );
                    $res = M('Moneychange')->add($arrayField);

                    if (!$res) {
                        M()->rollback();
                        $fail++;
                        continue;
                    }
                    //代付驳回退回手续费
                    if ($withdraw['df_charge_type'] && $withdraw['sxfmoney']>0) {
                        $res = $Member->where(['id' => $withdraw['userid']])->save(['balance' => array('exp', "balance+{$withdraw['sxfmoney']}")]);
                        if (!$res) {
                            M()->rollback();
                            $fail++;
                            continue;
                        }
                        $chargeField = array(
                            "userid"     => $withdraw['userid'],
                            "ymoney"     => $memberInfo['balance'] + $withdraw['tkmoney'],
                            "money"      => $withdraw['sxfmoney'],
                            "gmoney"     => $memberInfo['balance'] + $withdraw['tkmoney'] + $withdraw['sxfmoney'],
                            "datetime"   => date("Y-m-d H:i:s"),
                            "tongdao"    => 0,
                            "transid"    => $v,
                            "orderid"    => $v,
                            "lx"         => 15,
                            'contentstr' => '代付结算驳回退回手续费',
                        );
                        $res = M('Moneychange')->add($chargeField);
                        if (!$res) {
                            M()->rollback();
                            $fail++;
                            continue;
                        }
                    }
                    $data['status']     = 3;
                    $data["cldatetime"] = date("Y-m-d H:i:s");
                    $res                = $Tklist->where(['id' => $v])->save($data);
                    if ($res === false) {
                        M()->rollback();
                        $fail++;
                        continue;
                    } else {
                        M()->commit();
                        $success++;
                    }
                } else {
                    M()->rollback();
                    $fail++;
                    continue;
                }
            } catch (\Exception $e) {
                M()->rollback();
                $fail++;
                continue;
            }
        }
        if ($success > 0) {
            $this->ajaxReturn(['status' => 1, 'msg' => '成功驳回：' . $success . '，失败：' . $fail]);
        } else {
            $this->ajaxReturn(['status' => 0, 'msg' => '驳回失败!']);
        }
    }

    /**
     * 提款设置验证码信息
     */
    public function tkconfigSend()
    {
        $uid = session('admin_auth')['uid'];
        $user = M('Admin')->where(['id'=>$uid])->find();
        $res = $this->send('tkconfig', $user['mobile'] ,'提款设置');
        $this->ajaxReturn(['status' => $res['code']]);
    }

    /**
     * 一键复制记录
    */
    function copy(){
        $id = I("request.id");
        $res = M('Tklist')->where(['id'=>$id])->setField("has_copy",1);
        $this->ajaxReturn(['status' => $res]);
    }
}
