<?php
/**
 * Created by subime.
 * User: zf
 * Date: 2018-10-31
 * Time: 11:33
 */
namespace Home\Controller;

use Think\Controller;
class BackcodeController extends Controller
{
    public function index()
    {
         $code = I("request.code");
         echo "$code";
    }

}