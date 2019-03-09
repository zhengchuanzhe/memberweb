<?php

namespace app\admin\controller\personal;

use app\common\controller\Backend;
use fast\Random;
use think\Controller;
use think\Request;

/**
 * 修改二级密码
 *
 * @icon fa fa-circle-o
 */
class Secondpasswordedit extends Backend
{
    
    public function _initialize()
    {
        parent::_initialize();
        $this->model = model('Admin');

        // 获取当前用户的信息
        $this->info = $this->model->get(['id' => $this->auth->id]);

    }
    
    /**
     * 修改二级密码
     * @Author   zzk
     * @DateTime 2018-02-24T22:41:15+0800
     * @return   [type]                   [description]
     */
    public function index()
    {
        if ($this->request->isPost())
        {
            $second_password_old = $this->request->post("second_password_old");
            $second_password_new = $this->request->post("second_password_new");
            if ($second_password_new)
            {
                if ($this->info['second_pass_word']!=""&&$this->info['second_salt']!="") {
                    // 验证旧密码是否正确
                    if (md5(md5($second_password_old) . $this->info['second_salt'])!=$this->info['second_pass_word']) {
                        $this->error(__("The old password is error"));
                    }
                }
                
                // 修改二级密码盐及二级密码
                $params['second_salt'] = Random::alnum();
                $params['second_pass_word'] = md5(md5($second_password_new) . $params['second_salt']);

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
