<?php

namespace app\admin\controller\personal;

use app\common\controller\Backend;
use fast\Random;
use think\Controller;
use think\Request;

/**
 * 修改密码
 *
 * @icon fa fa-circle-o
 */
class Passwordedit extends Backend
{
    
    public function _initialize()
    {
        parent::_initialize();
        $this->model = model('Admin');

        // 获取当前用户的信息
        $this->info = $this->model->get(['id' => $this->auth->id]);

    }

    /**
     * 修改密码
     * @Author   zzk
     * @DateTime 2018-02-24T22:41:15+0800
     * @return   [type]                   [description]
     */
    public function index()
    {
        if ($this->request->isPost())
        {
            $password_old = $this->request->post("password_old");
            $password_new = $this->request->post("password_new");
            if ($password_old&&$password_new)
            {
                // 验证旧密码是否正确
                if (md5(md5($password_old) . $this->info['salt'])!=$this->info['password']) {
                    $this->error(__("The old password is error"));
                }

                // 修改一级密码盐及一级密码
                $params['salt'] = Random::alnum();
                $params['password'] = md5(md5($password_new) . $params['salt']);

                $result = $this->info->save($params);
                if ($result === false)
                {
                    $this->error($this->info->getError());
                }
                $this->success();
            }
            $this->error(__("The param is error"));
        }
        return $this->view->fetch();
    }

}
