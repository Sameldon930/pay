<?php
/**
 * Created by PhpStorm.
 * User: gaoxi
 * Date: 2017-08-22
 * Time: 14:34
 */
namespace User\Controller;
use Think\Verify;
use Think\Page;
use Org\Net\UserLogService;

/**
 * 用户中心首页控制器
 * Class IndexController
 * @package User\Controller
 */

class IndexController extends UserController
{

    public function __construct()
    {
        parent::__construct();
    }

    /**
     * 首页
     */
    public function index()
    {
        $module = strtolower(trim(__MODULE__, '/'));
        $module = trim($module, './');
        $loginout = U($module . "/Login/loginout");
        $this->assign('loginout', $loginout);
        $this->display();
    }

    public function main()
    {
        UserLogService::write(1, '访问商户中心首页', '访问商户中心首页');
        $firstday = date('Y-m-01', time());
        $lastday = date('Y-m-d', strtotime("$firstday +1 month -1 day"));

        //成交金额
        $sql = "SELECT SUM( pay_actualamount ) AS total, FROM_UNIXTIME( pay_applydate,  '%Y-%m-%d' ) AS DATETIME
FROM pay_order WHERE pay_applydate >= UNIX_TIMESTAMP(  '".$firstday."' ) AND pay_applydate < UNIX_TIMESTAMP(  '".
            $lastday."' ) AND pay_status>=1 AND pay_memberid=".($this->fans['memberid'])."  GROUP BY DATETIME";
        $ordertotal = M('Order')->query($sql);

        //成交订单数
        $sql = "SELECT COUNT( id ) AS num, FROM_UNIXTIME( pay_applydate,  '%Y-%m-%d' ) AS DATETIME
FROM pay_order WHERE pay_applydate >= UNIX_TIMESTAMP(  '".$firstday."' ) AND pay_successdate < UNIX_TIMESTAMP(  '".
            $lastday."' ) AND pay_status>=1 AND pay_memberid=".($this->fans['memberid'])."  GROUP BY DATETIME";
        $ordernum = M('Order')->query($sql);
        foreach ($ordernum as $key=>$item){
            $category[] = date('Ymd',strtotime($item['datetime']));
            $dataone[] = $item['num'];
            $datatwo[] = $ordertotal[$key]['total'];
        }

        $this->assign('category','['.implode(',',$category).']');
        $this->assign('dataone','['.implode(',',$dataone).']');
        $this->assign('datatwo','['.implode(',',$datatwo).']');
        $this->assign('chartCategory',$category);
        $this->assign('chartData1',$dataone);
        $this->assign('chartData2',$datatwo);
        //文章默认最新2条
        $Article = M("Article");
        if($this->fans['groupid'] == 4) {
            $gglist = $Article->where(['status'=> 1, 'groupid'=>['in','0,1']])->limit(2)->order("id desc")->select();
        } else {
            $gglist = $Article->where(['status'=> 1, 'groupid'=>['in','0,2']])->limit(2)->order("id desc")->select();
        }
        $this->assign("gglist", $gglist);
        //获取最近两次登录记录
        $loginlog = M("Loginrecord")->where(['userid' => $this->fans['uid']])->order('id desc')->limit(2)->select();
        $lastlogin = '';
        if(isset($loginlog[1])) {
            $lastlogin = $loginlog[1];
        }
        $ipItem = [];
        if (trim($this->fans['login_ip'])) {
            $ipItem = explode("\r\n", $this->fans['login_ip']);
        }
        //总成交订单数
        $stat['totalordercount'] = M('Order')->where(['pay_memberid'=>10000+$this->fans['uid'], 'pay_status'=>['in', '1,2']])->count();
        //总成交订单总额
        $stat['totalordersum'] = M('Order')->where(['pay_memberid'=>10000+$this->fans['uid'], 'pay_status'=>['in', '1,2']])->sum('pay_amount');
        //本月成交订单数
        $monthBegin = date('Y-m-01').' 00:00:00';
        $stat['monthordercount'] = M('Order')->where(['pay_memberid'=>10000+$this->fans['uid'],'pay_applydate'=>['egt',strtotime($monthBegin)], 'pay_status'=>['in', '1,2']])->count();
        //本月成交订单总额
        $stat['monthordersum'] = M('Order')->where(['pay_memberid'=>10000+$this->fans['uid'],'pay_applydate'=>['egt',strtotime($monthBegin)], 'pay_status'=>['in', '1,2']])->sum('pay_amount');

        //今日成交订单数
        $todayBegin = date('Y-m-d').' 00:00:00';
        $todyEnd = date('Y-m-d').' 23:59:59';
        $stat['todayordercount'] = M('Order')->where(['pay_memberid'=>10000+$this->fans['uid'],'pay_applydate'=>['between', [strtotime($todayBegin), strtotime($todyEnd)]], 'pay_status'=>['in', '1,2']])->count();
        //今日成交订单总额
        $stat['todayordersum'] = M('Order')->where(['pay_memberid'=>10000+$this->fans['uid'],'pay_applydate'=>['between', [strtotime($todayBegin), strtotime($todyEnd)]], 'pay_status'=>['in', '1,2']])->sum('pay_amount');
        foreach($stat as $k => $v) {
            $stat[$k] = $v+0;
        }
        $this->assign('stat', $stat);
        $this->assign('ipItem',$ipItem);
        $this->assign('lastlogin', $lastlogin);
        $this->assign('user', $this->fans);
        $this->display();
    }

    public function showcontent()
    {
        $id = I("get.id", 0, 'intval');
        if($id<=0) {
            $this->error('参数错误');
        }
        UserLogService::write(1, '访问公告详情', 'ID：'.$id);
        $Article = M("Article");
        if($this->fans['groupid'] == 4) {
            $find = $Article->where(['id'=>$id,'status'=> 1,'groupid'=>['in','0,1']])->find();
        } else {
            $find = $Article->where(['id'=>$id,'status'=> 1,'groupid'=>['in','0,2']])->find();
        }
        $count = M('browserecord')->where(['articleid' => $id, 'userid' => $this->fans['uid']])->count();
        if(!$count) {
            M('browserecord')->add(['articleid' => $id, 'userid' => $this->fans['uid'], 'datetime' => date('Y-m-d H:i:s')]);
        }
        $this->assign("find", $find);
        $this->display();
    }

    public function gonggao()
    {
        UserLogService::write(1, '访问公告列表', '访问公告列表');
        $where['status'] = 1;
        if($this->fans['groupid'] == 4) {
            $where['groupid'] = ['in','0,1'];
            $count = M('Article')->where($where)->count();
            $page           = new Page($count, 5);
            $list = M('Article')->where($where)->limit($page->firstRow . ',' . $page->listRows)->order("id desc")->select();
        } else {
            $where['groupid'] = ['in','0,2'];
            $count = M('Article')->where($where)->count();
            $page           = new Page($count, 5);
            $list = M('Article')->where($where)->limit($page->firstRow . ',' . $page->listRows)->order("id desc")->select();
        }

        $this->assign("list", $list);
        $this->assign('page', $page->show());
        $this->display();
    }

    public function google()
    {
        if(IS_POST) {
            $google_secret_key = M('Member')->where(array('id'=> $this->fans['uid']))->getField('google_secret_key');
            if($google_secret_key == '') {
                UserLogService::write(1, '登录谷歌二次验证失败', '原因：未绑定谷歌身份验证器');
                $this->error("您未绑定谷歌身份验证器");
            }
            if(!$this->fans['google_auth']) {
                UserLogService::write(1, '登录谷歌二次验证失败', '原因：谷歌身份验证已关闭');
                $this->error("谷歌身份验证已关闭");
            }
            $res = check_auth_error($this->fans['uid'], 4);
            if(!$res['status']) {
                UserLogService::write(1, '登录谷歌二次验证失败', '原因：谷歌验证码输入错误次数超限');
                $this->ajaxReturn(['status' => 0, 'msg' => $res['msg']]);
            }
            $code = I('code', '', 'string');
            if($code == '') {
                UserLogService::write(1, '登录谷歌二次验证失败', '原因：谷歌验证码不能为空');
                $this->error("谷歌安全码不能为空");
            }
            $ga = new \Org\Util\GoogleAuthenticator();
            if(false === $ga->verifyCode($google_secret_key, $code, C('google_discrepancy'))) {
                log_auth_error($this->fans['uid'],4);
                UserLogService::write(1, '登录谷歌二次验证失败', '原因：谷歌验证码错误');
                $this->error("谷歌安全码错误");
            } else {
                clear_auth_error($this->fans['uid'],4);
                session('user_google_auth', $code);
                UserLogService::write(1, '登录谷歌二次验证成功', '登录谷歌二次验证成功');
                $this->success("验证通过，正在进入商户中心...", U('Index/index'));
            }
        } else {
            UserLogService::write(1, '访问谷歌二次验证页面', '访问谷歌二次验证页面');
            $this->display();
        }
    }
}