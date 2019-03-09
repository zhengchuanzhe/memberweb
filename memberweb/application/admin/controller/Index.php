<?php

namespace app\admin\controller;

use app\admin\model\AdminLog;
use app\common\controller\Backend;
use think\Config;
use think\Hook;
use think\Validate;

/**
 * 后台首页
 * @internal
 */
class Index extends Backend
{

    protected $noNeedLogin = ['login'];
    protected $noNeedRight = ['index', 'logout'];
    protected $layout = '';

    public function _initialize()
    {
        parent::_initialize();
    }

    /**
     * 后台首页
     */
    public function index()
    {
        //判断是否有新的消息
         
        $this->getMessageLeaveNum();
       
        $this->view->assign('title', __('Home'));
        $system_time=model('ConfigSystemTime')
                        ->field("DATE_FORMAT(system_time,'%Y-%m-%d') as account_date")
                        ->order('system_time desc')
                        ->where('type','like','%_out')
                        ->select();
        $this->view->assign('system_time', $system_time[0]['account_date']);
        return $this->view->fetch();
    }

    public function getMessageLeaveNum()
    {
        $userInfo=$this->auth->getUserInfo();
        $model= model('MessageLeave');
        $total = $model
                    ->where(array('receive_user_code'=>$userInfo["user_code"],"receive_is_delete"=>false,"is_read"=>false))
                    ->count();
        if ($total>0) {
             $menulist = $this->auth->getSidebar([
                 'messageleave'=>['new','red', 'badge'],
                 'messageleave/inbox'=>[$total,'red', 'badge'],
                ], $this->view->site['fixedpage']);
            $this->view->assign('menulist', $menulist);
        }else{
             $menulist = $this->auth->getSidebar([
                ], $this->view->site['fixedpage']);
            $this->view->assign('menulist', $menulist);
        }
    }

    /**
     * 管理员登录
     */
    public function login()
    {
        $url = $this->request->get('url', 'index/index');
        if ($this->auth->isLogin())
        {
            $this->error(__("You've logged in, do not login again"), $url);
        }
        if ($this->request->isPost())
        {
            $user_code = $this->request->post('user_code');
            $password = $this->request->post('password');
            $keeplogin = $this->request->post('keeplogin');
            $token = $this->request->post('__token__');
            $rule = [
                'user_code'  => 'require|length:7',
                'password'  => 'require|length:6,30',
                '__token__' => 'token',
            ];
            $data = [
                'user_code'  => $user_code,
                'password'  => $password,
                '__token__' => $token,
            ];
            if (Config::get('fastadmin.login_captcha'))
            {
                $rule['captcha'] = 'require|captcha';
                $data['captcha'] = $this->request->post('captcha');
            }
            $validate = new Validate($rule, [], ['user_code' => __('User code'), 'password' => __('Password'), 'captcha' => __('Captcha')]);
            $result = $validate->check($data);
            if (!$result)
            {
                $this->error($validate->getError(), $url, ['token' => $this->request->token()]);
            }
            AdminLog::setTitle(__('Login'));
            $result = $this->auth->login($user_code, $password, $keeplogin ?  1800: 0);//session过期时间30分钟
            if ($result === true)
            {
                $this->success(__('Login successful'), $url, ['url' => $url, 'id' => $this->auth->id, 'user_code' => $user_code, 'avatar' => $this->auth->avatar]);
            }
            else
            {
                $this->error($this->auth->getError(), $url, ['token' => $this->request->token()]);
            }
        }

        // 根据客户端的cookie,判断是否可以自动登录
        if ($this->auth->autologin())
        {
            $this->redirect($url);
        }
        $background = cdnurl(Config::get('fastadmin.login_background'));
        $this->view->assign('background', $background);
        Hook::listen("login_init", $this->request);
        return $this->view->fetch();
    }

    /**
     * 注销登录
     */
    public function logout()
    {
        $this->auth->logout();
        $this->success(__('Logout successful'), 'index/login');
    }

}
