<?php
namespace Org\Util\Shande;

class RandomStr {
    public static function generate($size) {
        $str = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
        $arr = array();
        for ($i = 0; $i < $size; $i++) {
            $arr[] = $str[mt_rand(0, 61)];
        }

        return implode('', $arr);
    }
}