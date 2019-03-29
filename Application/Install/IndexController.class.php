<?php

namespace Install\Controller;

use Org\Util\Str;
use Think\Controller;
use Think\Db;
use Think\Storage;


/**
 * 安装控制器
 */
class IndexController extends Controller
{
    // 初始化方法
    protected function _initialize()
    {
        $no_verify = array('index','step1', 'complete');
        if (in_array(ACTION_NAME, $no_verify)) {
            return true;
        }
        if (Storage::has(CONF_PATH .'/install.lock')) {
            $this->error('已经成功安装了本系统，请不要重复安装!', U('/admin'));
        }
    }

    // 安装首页
    public function index()
    {
        $this->redirect('Install/Index/step1');
    }

    // 安装第一步，同意安装协议
    public function step1()
    {
        session('step', '1');
        session('error', false);
        $this->assign('meta_title', "step1");
        $this->display();
    }

    // 安装第二步，检测运行所需的环境设置
    public function step2()
    {
        if (IS_AJAX) {
            if (session('error')) {
                $this->error('环境检测没有通过，请调整环境后重试！');
            } else {
                $this->success('恭喜您环境检测通过', U('step3'));
            }
        } else {
            session('step', '2');
            session('error', false);

            //环境检测
            $this->assign('check_env', check_env());

            //目录文件读写检测
            if (IS_WRITE) {
                $this->assign('check_dirfile', check_dirfile());
            }

            //函数及扩展库检测
            $this->assign('check_func_and_ext', check_func_and_ext());

            $this->assign('meta_title', "step2");
            $this->display();
        }
    }

    // 安装第三步，创建数据库
    public function step3($db = null)
    {
        if (IS_POST) {
            //检测数据库配置
            if (!is_array($db) || empty($db['DB_TYPE'])
                || empty($db['DB_HOST']) || empty($db['DB_NAME'])
                || empty($db['DB_USER']) || empty($db['DB_PREFIX'])) {
                $this->error('请填写完整的数据库配置');
            } else {
                //缓存数据库配置
                session('db_config', $db);

                //创建数据库连接
                $db_name = $db['DB_NAME'];
                unset($db['DB_NAME']); //防止不存在的数据库导致连接数据库失败
                $db_instance = Db::getInstance($db);

                //检测数据库连接
                $result1 = $db_instance->execute('select version()');
                if (!$result1) {
                    $this->error('数据库连接失败，请检查数据库配置！');
                }

                //用户选择不覆盖情况下检测是否已存在数据库
                if (I('post.cover') === '0') {
                    //检测是否已存在数据库
                    $result2 = $db_instance->execute('SELECT * FROM information_schema.schemata WHERE schema_name="' . $db_name . '"');
                    if ($result2) {
                        $this->error('该数据库已存在，请更换名称！如需覆盖，请选中覆盖按钮！');
                    }

                    //创建数据库
                    $sql = "CREATE DATABASE IF NOT EXISTS `{$db_name}` DEFAULT CHARACTER SET utf8";
                    $db_instance->execute($sql) || $this->error($db_instance->getError());
                }
            }

            //跳转到数据库安装页面
            $this->success('参数正确开始安装', U('step4'));
        } else {
            session('step', '3');
            session('error', false);
            $rand = Str::randString(6, 3); //生成随机数
            $this->assign('meta_title', "step3");
            $this->display();
        }
    }

    // 安装第四步，安装数据表，创建配置文件
    public function step4()
    {
        if (session('step') !== '3') {
            $this->error('请按顺序安装', U('step3'));
        }
        session('step', '4');
        session('error', false);
        $this->assign('meta_title', "step4");
        $this->display();

        //连接数据库
        $db_config   = session('db_config');
        $db_instance = Db::getInstance($db_config);

        //创建数据表
        create_tables($db_instance, $db_config['DB_PREFIX']);

        //创建配置文件
        $conf = write_config($db_config);

        //根据加密字符串更新admin密码的加密结果
        $db_instance->execute("UPDATE `".$db_config['DB_PREFIX']."websiteconfig` SET `domain`='".$_SERVER['HTTP_HOST']."' WHERE `id` = 1;");
        $db_instance->execute("UPDATE `".$db_config['DB_PREFIX']."member` SET `password`='".md5('adminadmin'.C('DATA_AUTH_KEY'))."' WHERE `id` = 1;");

        if (session('error')) {
            $this->error('安装出错', 'index');
        } else {
            $this->redirect('complete');
        }
    }

    // 安装完成
    public function complete()
    {
        if (session('step') !== '4') {
            $this->error('请正确安装系统', 'step1');
        }

        //写入安装锁定文件(只能在最后一步写入锁定文件，因为锁定文件写入后安装模块将无法访问)
        Storage::put(CONF_PATH . './install.lock', 'lock');
		
		//写入配置
        $str = "<?php
        return array(
            'WEB_TITLE' => '".C('INSTALL_PRODUCT_NAME')."',
            'DOMAIN' => '".$_SERVER['HTTP_HOST']."',
            'WEB_STATICS' => '".$_SERVER['HTTP_HOST']."',
			'MODULE_ALLOW_LIST'   => array('Home','User','Admin','Install', 'Weixin','Pay','Cashier',, 'Agent'),
            'LOGINNAME' => 'loginlogin',
            'HOUTAINAME' => 'Admin',
            'COMPANY_NAME'=>'聚合支付',
        );";
		file_put_contents(CONF_PATH . './website.php',$str);
        session('step', null);
        session('error', null);
        $this->assign('meta_title', "完成");
        $this->display();
    }
}