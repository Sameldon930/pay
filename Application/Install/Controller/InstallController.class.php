<?php
/**
 * Created by PhpStorm.
 * User: gaoxi
 * Date: 2017-07-13
 * Time: 11:30
 */
namespace Install\Controller;

use Home\Controller\BaseController;
use Think\Storage;

class InstallController extends BaseController
{
    public function index(){
        if (Storage::has(CONF_PATH .'/install.lock')) {
            $this->error('已经成功安装了本系统，请不要重复安装!', U('/admin'));
        }
        redirect(U('Install/Index/step1'));
    }
}