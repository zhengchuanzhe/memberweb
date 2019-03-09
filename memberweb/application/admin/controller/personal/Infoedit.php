<?php

namespace app\admin\controller\personal;

use app\common\controller\Backend;
use fast\Random;
use think\Controller;
use think\Request;

/**
 * 个人信息编辑
 *
 * @icon fa fa-circle-o
 */
class Infoedit extends Backend
{
    
    public function _initialize()
    {
        parent::_initialize();
        $this->model = model('Admin');

        // 获取当前用户的信息
        $this->info = $this->model->get(['id' => $this->auth->id]);

    }
    
    /**
     * 编辑
     * @Author   zzk
     * @DateTime 2018-02-24T22:41:15+0800
     * @return   [type]                   [description]
     */
    public function index()
    {
        if ($this->request->isPost())
        {
            $params = $this->request->post("row/a");
            
            
            $this->auth->getUserInfo()['bank_code']=$params['bank_code'];

            if ($params)
            {
                $this->auth->getUserInfo()['bank_code']=$params['bank_code'];
                $this->auth->getUserInfo()['open_bank_name']=$params['open_bank_name'];
                $this->auth->getUserInfo()['bank_account']=$params['bank_account'];
                $this->auth->getUserInfo()['user_name']=$params['user_name'];
                $this->auth->getUserInfo()['phone_number']=$params['phone_number'];
                $this->auth->getUserInfo()['receive_address']=$params['receive_address'];
                $result=$this->auth->getUserInfo()->save(); 
                if ($result === false)
                {
                    $this->error($this->info->getError());
                }
                $this->success();
            }
            $this->error();
        }

        // 取出银行列表
        $bankList = model('Bank')
                ->field("bank_code,bank_name as name")
                ->select();
        // 取出会员等级列表
        $gradeList = model('Grade')
                ->field("grade_code,grade_name as name")
                ->select();

        // 页面绑定
        $this->view->assign("row", $this->info);
        $this->view->assign("userAreaList", $this->model->getUserAreaList()); // A、B区
        $this->view->assign('bankList', $bankList); 
        $this->view->assign('gradeList', $gradeList); 
        return $this->view->fetch();
    }

}
