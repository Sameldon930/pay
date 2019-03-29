<?php
namespace Org\Util\Hx\Quick;
/**
 * php截取<body>和</body>之間字符串 
 * @param string $begin 开始字符串
 * @param string $end 结束字符串
 * @param string $str 需要截取的字符串
 * @return string
 */
function subStrXml($begin,$end,$str){
    $b= (strpos($str,$begin));
    $c= (strpos($str,$end));
    
    return substr($str,$b,$c-$b + 7);
}
?>