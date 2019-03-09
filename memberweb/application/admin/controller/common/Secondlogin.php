<?php

namespace app\admin\controller\common;

use app\common\controller\Backend;
use app\admin\model\Admin;
use think\Session;
use think\Controller;
use think\Request;

/**
 * 二级登陆控制器
 */
class Secondlogin extends Backend
{
    private static $keeptime = 30; // 二级Session保持时间（秒）
    private static $secondView = "common/secondLogin"; // 二级登陆视图

    public static function getSecondView(){
        return self::$secondView;
    }

    public function _initialize()
    {
        parent::_initialize();

    }
    
    private function _getSecondPasswd(){
        return $this->auth->getUserInfo()['second_pass_word'];
    }

    private function _getSecondSalt(){
        return $this->auth->getUserInfo()['second_salt'];
    }

    /**
     * 检查密码是否正确
     * @Author   zzk
     * @DateTime 2018-02-07T19:29:55+0800
     * @return   [type]                   [description]
     */
    public function checkPassword()
    {
        if ($this->request->isPost())
        {
            $second_password = $this->request->post("second_password");
            $redirect_url = $this->request->post("url");
            // 验证二级密码
            if (md5(md5($second_password).$this->_getSecondSalt()) === $this->_getSecondPasswd()) {
                $this->_setSecondSession(); //保存Session
                $this->success(__('Login successful'), $redirect_url, ['url' => $redirect_url]);
            } else {
                $this->error(__('Password error'));
            }
        }
    }

    /**
     * 检查是否二级登陆
     * @Author   zzk
     * @DateTime 2018-02-07T19:29:55+0800
     * @return   [type]                   [description]
     */
    public static function isSecondLogin()
    {
        $second = Session::get('second_login_info');
        if (!$second) { // 不存在返回错误
            return false;
        }
        list($id, $expiretime, $key) = explode('|', $second);
        if ($id && $expiretime && $key && $expiretime > time()) // Session 格式正确且未超时
        {
            $admin = Admin::get($id);
            if (!$admin || !$admin->token) // 一级未登录返回错误
            {
                return false;
            }
            if ($key != md5(md5($id) . md5(self::$keeptime) . md5($expiretime) . $admin->token)) // 钥匙不匹配返回错误
            {
                return false;
            }
            return true;
        }
        return false;
    }

    /**
     * 设置二级密码Session
     * @Author   zzk
     * @DateTime 2018-02-07T19:48:05+0800
     */
    private function _setSecondSession()
    {
        if (self::$keeptime)
        {
            $expiretime = time() + self::$keeptime;
            $key = md5(md5($this->auth->id) . md5(self::$keeptime) . md5($expiretime) . $this->auth->token);
            $data = [$this->auth->id, $expiretime, $key];
            Session::set('second_login_info', implode('|', $data));
            return true;
        }
        return false;
    }
}
