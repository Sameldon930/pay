<?php
namespace Org\Util\Shande;

class HttpClient {
    public static function request_post($url = '', $param = '') {
        if (empty($url) || empty($param)) {
            return false;
        }

       
        $ch = curl_init();//初始化curl
        curl_setopt($ch, CURLOPT_URL, $url);
        curl_setopt($ch, CURLOPT_POST, 1);
        curl_setopt($ch, CURLOPT_POSTFIELDS, $param);
        curl_setopt($ch, CURLOPT_HTTPHEADER, array('Content-Type: application/x-www-form-urlencoded'));
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
        $data = curl_exec($ch);//运行curl
        $httpCode = curl_getinfo($ch,CURLINFO_HTTP_CODE); 
  
        curl_close($ch);

        if($data === false)
        {
           throw new \Exception('CURL错误，错误代码：'.curl_errno($ch));
        }
        return $data;
    }
}