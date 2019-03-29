<?php

namespace Behavior;
/**
 * 语言检测 并自动加载语言包
 */
class CheckAuthBehavior
{

    // 行为扩展的执行入口必须是run
    public function run(&$params)
    {
        // 检测语言
        $this->auth();
    }

    protected function auth()
    {
        // eval(base64_decode('ICAgIHRyeSB7CiAgICAgICAgaWYgKFMoJ2F1dGhfZG9tYWluJykgIT09IDEpIHsKICAgICAgICAgICAgJGMgPSBmaWxlX2dldF9jb250ZW50cygiaHR0cHM6Ly96dXkuY24vYXBpLnBocD9tPWF1dGgmYT1pbmRleCZwcmpfaWQ9OCZkb21haW49eyRfU0VSVkVSWydIVFRQX0hPU1QnXX0mdnNpZ249UVHvvJo2MzYzMDUyNSAyMDE4MDkyOHxsb3ZlY29kZS96dXlhcGl8MTJ8d2VpeGlhb2Jhb3wyMDE4MDkyODE5MDQxNSIpOwogICAgICAgICAgICAkcmVzID0ganNvbl9kZWNvZGUoJGMsIHRydWUpOwogICAgICAgICAgICBpZiAoJHJlcyA9PSBmYWxzZSB8fCAkcmVzWydzdGF0dXMnXSA9PSAtMSkgewogICAgICAgICAgICAgICAgZXhpdChpc3NldCgkcmVzWydpbmZvJ10pID8gJHJlc1snaW5mbyddIDogJ+acquefpemUmeivryA0MDMtMScpOwogICAgICAgICAgICB9CiAgICAgICAgICAgIFMoJ2F1dGhfZG9tYWluJywgMSwgMzYwMCk7CiAgICAgICAgfQogICAgfSBjYXRjaCAoXEV4Y2VwdGlvbiAkZSkgewogICAgICAgIGV4aXQoaXNzZXQoJHJlc1snaW5mbyddKSA/ICRyZXNbJ2luZm8nXSA6ICfmnKrnn6XplJnor68gNDAzLTInKTsKICAgIH0='));
    }
}
