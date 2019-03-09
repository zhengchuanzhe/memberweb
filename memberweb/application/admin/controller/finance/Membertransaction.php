<?php

namespace app\admin\controller\finance;

use app\common\controller\Backend;

use think\Controller;
use app\admin\library\Engine;
use think\Request;

/**
 * 会员转账
 *
 * @icon fa fa-circle-o
 */
class Membertransaction extends Backend
{
    
    /**
     * FinancePersonalaccount模型对象
     */
    protected $model = null;

    public function _initialize()
    {
        parent::_initialize();
        $this->model = model('FinancePersonalaccount');
    }
    public function index(){
            $code = $this->auth->getUserInfo()['user_code'];
            $cash = $this->model
                ->field('balance')
                ->where('user_code',$code)
                ->where('type','0')
                ->select()[0]['balance'];
            //设置过滤方法
            $this->request->filter(['strip_tags']);
            $this->view->assign('cash',$cash);
            return $this->view->fetch();
    }
    public function getUserNameByCode(){
        if ($this->request->isPost()) {
            $params = $this->request->post();
            $code = is_null($params['code']) ? -1 : $params['code'];
            // 验证编号是否可用
            if ($code != -1) {
                $user = model('Admin')->field('user_name')->where('user_code',$code)->find();
                if ($user!=null) {
                    $this->success($user['user_name']);
                } else {
                    $this->error(__('The code is inexistent'));
                }
            } else {
                $this->error(__('The param is error'));
            }
        }
    }
    public function transaction()
    {
        if ($this->request->isPost()) {
            $param = $this->request->post();
            if (!is_numeric($param['code'])) {
                $this->error(__('Please input code'));
            } else {
                $this_code = $this->auth->getUserInfo()['user_code'];
                $trans_code = $param['code'];
                if($this_code == $trans_code){
                    $this->error(__('Cannot transact to self'));
                }else {
                    if ($param['trans_cash'] <= 0) {
                        $this->error(__('Please enter the correct amount'));
                    } else {
                        $trans_cash = $param['trans_cash'];
                        $this_cash = $this->model
                            ->field('balance')
                            ->where('user_code', $this_code)
                            ->where('type', '0')
                            ->find();
                        $validate_code = model('Admin')->field('user_code')->where('user_code', $trans_code)->find()['user_code'];
                        if ($validate_code != null) {
                            if ($param['trans_cash'] > $this_cash['balance']) {
                                $this->error(__('Account notenough'));
                            } else {
                                //调用存储过程
                                $params['param_business_code'] = Engine::BUSCODE_HYZZ;
                                $params['param_user_code'] = $this_code;
                                $params['param_counterparty'] = $trans_code;
                                $params['param_transaction_amount'] = $trans_cash;
                                $params['param_operation_user_code'] = $this_code;
                                $result = model('StoreProcedure')->proFinanceEngine($params);
                                if ($result['code'] == 0) {
                                    $this->error(__('Handler Failed'));
                                } else {
                                    $this->success(__('Change success'));
                                }
                            }
                        } else {
                            $this->error(__('Please validate'));
                        }
                    }
                }
            }
        }
    }
    
    /**
     * 默认生成的控制器所继承的父类中有index/add/edit/del/multi五个方法
     * 因此在当前控制器中可不用编写增删改查的代码,如果需要自己控制这部分逻辑
     * 需要将application/admin/library/traits/Backend.php中对应的方法复制到当前控制器,然后进行修改
     */
    

}
