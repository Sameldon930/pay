<?php
/**
 * Created by xiaowei.wang
 * CreateTime: 16/7/7 上午11:14
 * Description:
 */
namespace Org\Util\Paymax;

use Exception;
use  Org\Util\Paymax\RSAUtil;

class HttpCurlUtil
{
    /**
     * @var array 需要发送的头信息
     */
    private $header = array();
    /**
     * @var null
     */
    private $header_array = array();

    /**
     * @var string 需要访问的URL地址
     */
    private $uri = '';
    /**
     * @var array 需要发送的数据
     */
    private $vars = array();

    /**
     * 设置需要发送的HTTP头信息
     *
     * @return void
     */
    private function setHeader(){

        $defaultHeader = array(
            'lang:PHP',
            'publisher:Paymax',
            'sdk-version:1.0.0',
            'uname:'.php_uname(),
            'lang-version:'.PHP_VERSION
        );

        $nonce = PaymaxUtil::createUniqid();
        $timestamp = PaymaxUtil::getMicroTime();

        $header = array(
            'Content-Type:application/json; charset=UTF-8',
            'nonce:'.$nonce,
            'timestamp:'.$timestamp,
            'Authorization:'.SignConfig::getSecretKey(),
            'X-Paymax-Client-User-Agent:'.json_encode($defaultHeader)
        );

        $header_array = array(
            "nonce"=>$nonce,
            "timestamp"=>$timestamp,
            "Authorization"=>SignConfig::getSecretKey()
        );

        $this->header = $header;
        $this->header_array = $header_array;
    }

    /**
     * @param $data
     * @param string $sep
     * @return string
     */
    public static function makeQuery($data, $sep = '&'){
        $encoded = '';
        while (list($k,$v) = each($data)) {
            $encoded .= ($encoded ? "$sep" : "");
            $encoded .= rawurlencode($k)."=".rawurlencode($v);
        }
        return $encoded;
    }

    /**
     * 设置要发送的数据信息
     *
     * 注意：本函数只能调用一次，下次调用会覆盖上一次的设置
     *
     * @param array 设置需要发送的数据信息，一个类似于 array('name1'=>'value1', 'name2'=>'value2') 的一维数组
     * @return void
     */
    private function setVar($vars){
        if (empty($vars)) {
            return;
        }
        if (is_array($vars)){
            $this->vars = $vars;
        }
    }

    /**
     * 设置要请求的URL地址
     *
     * @param string $url 需要设置的URL地址
     * @return void
     */
    private function setUrl($url){
        if ($url != '') {
            $this->uri = $url;
        }
    }

    /**
     * 发送HTTP GET请求
     *
     * @param string $url 如果初始化对象的时候没有设置或者要设置不同的访问URL，可以传本参数
     * @param array $vars 需要单独返送的GET变量
     * @param int $timeout 连接对方服务器访问超时时间，单位为秒
     * @return unknown
     */
    public function get($url = '', $vars = array(), $timeout = 5 ){
        $this->setUrl($url);
        $this->setHeader();
        $this->setVar($vars);
        return $this->send('GET', $timeout);
    }


    /**
     * 发送HTTP POST请求
     *
     * @param string $url 如果初始化对象的时候没有设置或者要设置不同的访问URL，可以传本参数
     * @param array $vars 需要单独返送的GET变量
     * @param int $timeout 连接对方服务器访问超时时间，单位为秒
     * @return unknown
     */
    public function post($url = '', $vars = array(), $timeout = 5 ){
        $this->setUrl($url);
        $this->setHeader();
        $this->setVar($vars);
        return $this->send('POST', $timeout);
    }

    /**
     * 发送HTTP请求核心函数
     *
     * @param string $method  使用GET还是POST方式访问
     * @param int $timeout  连接对方服务器访问超时时间，单位为秒
     * @param array $options
     * @return mixed
     * @throws Exception
     */
    private function send($method = 'GET', $timeout = 5, $options = array()){
        //处理参数是否为空
        if ($this->uri == ''){
            throw new Exception(__CLASS__ .": Access url is empty");
        }

        //初始化CURL
        $ch = curl_init();
        curl_setopt($ch, CURLOPT_URL, $this->uri);
        curl_setopt($ch, CURLOPT_HEADER, 1);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
        curl_setopt($ch, CURLOPT_TIMEOUT, $timeout);

        //设置特殊属性
        if (!empty($options)){
            curl_setopt_array($ch , $options);
        }

        $_json_data = json_encode($this->vars);

        //处理POST请求数据
        if ($method == 'POST'){
            curl_setopt($ch, CURLOPT_POST, 1 );
            curl_setopt($ch, CURLOPT_POSTFIELDS, $_json_data);
        }

        //设置HTTP缺省头
        if (empty($this->header)){
            $this->setHeader();
        }

        if ($method == 'GET'){
            $sign = $this->to_sign_data($method);
        }else{
            $sign = $this->to_sign_data($method,$_json_data);
        }

        $this->header[]='sign:'.$sign;

        curl_setopt($ch, CURLOPT_HTTPHEADER, $this->header);

        //发送请求读取输数据
        $data = curl_exec($ch);
        try{
            $body_data = null;

            $header_size = curl_getinfo($ch, CURLINFO_HEADER_SIZE);
            $res_header = substr($data, 0, $header_size);
            $body_data = substr($data, $header_size);

            $response_code=intval(curl_getinfo($ch, CURLINFO_HTTP_CODE));

            if ($response_code<400){
                $this->to_verify_data($res_header, $body_data);
            }
        }catch (Exception $e) {
            return $e->getMessage();
        }
        finally
        {
            curl_close($ch);
        }

        return $body_data;
    }

    /**
     * 签名数据
     *
     * @param $method
     * @param $body_data
     * @return string
     */
    private function to_sign_data($method,$body_data=null){
        $_cur_uri_query_string = stristr($this->uri,'/v1/');
        if($_cur_uri_query_string){
            $_cur_uri = $_cur_uri_query_string;
        }else if(stristr($this->uri,'/v2/')){
            $_cur_uri = $_cur_uri_query_string = stristr($this->uri,'/v2/');
        }

        $_query_string = $_query_string_index = strpos($_cur_uri_query_string,'?');
        if (!empty($_query_string_index)){
            $_cur_uri = substr($_cur_uri_query_string,0,$_query_string_index);//uri
            $_query_string = substr($_cur_uri_query_string,$_query_string_index+1);//query string
        }

        $_to_sign_data = utf8_encode(strtolower($method))."\n".utf8_encode($_cur_uri)."\n".utf8_encode($_query_string)."\n"
        .utf8_encode($this->header_array['nonce'])."\n".utf8_encode($this->header_array['timestamp'])."\n".utf8_encode($this->header_array['Authorization'])."\n"
        .utf8_encode($body_data);
        return RSAUtil::sign($_to_sign_data);
    }

    /**
     * 验签
     *
     * @param $res_header
     * @param $body_data
     */
    private function to_verify_data($res_header, $body_data)
    {
        $res_header_array = explode("\r\n", $res_header);

        $_res_nonce = '';
        $_res_timestamp = '';
        $_res_secret_key = '';
        $_res_sign = '';

        foreach ($res_header_array as $loop) {
            if (strpos($loop, "nonce") !== false) {
                $_res_nonce = trim(substr($loop, 7));
            } elseif (strpos($loop, "timestamp") !== false) {
                $_res_timestamp = trim(substr($loop, 11));
            } elseif (strpos($loop, "Authorization") !== false) {
                $_res_secret_key = trim(substr($loop, 15));
            } elseif (strpos($loop, "sign") !== false) {
                $_res_sign = trim(substr($loop, 6));
            }
        }

        $_to_verify_data = utf8_encode($_res_nonce)."\n".$_res_timestamp."\n".$_res_secret_key."\n".$body_data;
        $verify_result = RSAUtil::verify($_to_verify_data, $_res_sign);
        if(empty($verify_result) || intval($verify_result)!=1){
            throw new \Exception("Invalid Response.[Response Data And Sign Verify Failure.]");
        }

        if (strcmp(SignConfig::getSecretKey(),$_res_secret_key)){
            throw new \Exception("Invalid Response.[Secret Key Is Invalid.]");
        }

        if ((float)PaymaxUtil::getMicroTime() - (float)$_res_timestamp >= 2*60*1000){
            throw new \Exception("Invalid Response.[Response Time Is Invalid.]");
        }
    }
}