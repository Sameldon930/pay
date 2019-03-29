<?php
// +----------------------------------------------------------------------
// | ThinkPHP [ WE CAN DO IT JUST THINK IT ]
// +----------------------------------------------------------------------
// | Copyright (c) 2009 http://thinkphp.cn All rights reserved.
// +----------------------------------------------------------------------
// | Licensed ( http://www.apache.org/licenses/LICENSE-2.0 )
// +----------------------------------------------------------------------
// | Author: liu21st <liu21st@gmail.com>
// +----------------------------------------------------------------------
namespace Org\Net;
/**
 * 用户操作日志服务
 * Class UserLogService
 * @package service
 */
class UserLogService {

    /**
     * 写入操作日志
	 * @param string $type 操作类型 1：查看 2：新增 3：修改 4：删除 5:导出
     * @param string $action
     * @param string $content
     * @return bool
     */
    public static function write($type = '1', $action = '行为', $content = "内容描述")
    {
        if(isset($_SERVER['REMOTE_ADDR']) && $_SERVER['REMOTE_ADDR']) {
            $ip = $_SERVER['REMOTE_ADDR'];
        } else {
            $ip = get_client_ip();
        }
        $node = strtolower(join('/', [MODULE_NAME, CONTROLLER_NAME, ACTION_NAME]));
        $data = ['ip' => $ip, 'node' => $node, 'user_id' => session("user_auth.uid"), 'username' => session("user_auth.username"), 'action' => $action, 'type' => $type, 'content' => $content];
        return M('user_log')->add($data) !== false;
    }
}//类定义结束