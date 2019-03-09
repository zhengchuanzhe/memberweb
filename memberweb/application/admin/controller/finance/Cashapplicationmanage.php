<?php

namespace app\admin\controller\finance;

use app\common\controller\Backend;

use think\Controller;
use think\Request;

/**
 * 会员提现申请管理
 *
 * @icon fa fa-circle-o
 */
class Cashapplicationmanage extends Backend
{
    
    /**
     * FinanceApplicationCash模型对象
     */
    protected $model = null;

    public function _initialize()
    {
        parent::_initialize();
        $this->model = model('FinanceApplicationCash');

        //获取当前会员的code
        $this->code=$this->auth->getUserInfo()['user_code'];

        $this->view->assign("stateList", $this->model->getStateList());
    }
    
    /**
     * 默认生成的控制器所继承的父类中有index/add/edit/del/multi五个方法
     * 因此在当前控制器中可不用编写增删改查的代码,如果需要自己控制这部分逻辑
     * 需要将application/admin/library/traits/Backend.php中对应的方法复制到当前控制器,然后进行修改
     */

     /**
     * 编辑
     */
    public function edit($ids = NULL)
    {
        $row = $this->model->get($ids);
        if (!$row)
            $this->error(__('No Results were found'));
        $adminIds = $this->getDataLimitAdminIds();
        if (is_array($adminIds))
        {
            if (!in_array($row[$this->dataLimitField], $adminIds))
            {
                $this->error(__('You have no permission'));
            }
        }
        $this->view->assign("row", $row);
        return $this->view->fetch();
    }
    

    /*
     * 完成申请
     */
    public function applicationCompletion()
    {
        // 获取参数
        $params = $this->request->post("row/a");
        if ($params["id"]) {
            $cashInfo=$this->model->get($params['id']);
            if ($cashInfo['state']==0) {
                $cashInfo['mark']=$params["mark"]?$params["mark"]:'';
                $cashInfo['hand_user_code']=$this->code;
                code:date_default_timezone_set('prc');
                $cashInfo['hand_time']=date('y-m-d H:i:s',time());
                $cashInfo['state']=1;
                $result = $cashInfo->save();
                if ($result) {
                    $this->success('', null, ['res'=>'success','hand_user_code'=>$this->code,'date'=>date("Y-m-d H:i:s")]);
                }
                else{
                    // 否则报错
                    $this->error(__('Handler Failed'));
                }
            }
            // 否则报错
            $this->error(__('Handler Failed'));
        }
        $this->error(__('Parameter Error'));
    }

}
