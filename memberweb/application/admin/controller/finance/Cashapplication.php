<?php

namespace app\admin\controller\finance;

use app\common\controller\Backend;

use think\Controller;
use think\Request;
use app\admin\library\Engine;
/**
 * 会员提现申请
 *
 * @icon fa fa-circle-o
 */
class Cashapplication extends Backend
{
    
    /**
     * FinanceApplicationCash模型对象
     */
    protected $model = null;
    protected $low_amount=null;
    protected $code=null;
    public function _initialize()
    {
        parent::_initialize();
        $this->model = model('FinanceApplicationCash');

        //获取当前会员的code
        $this->code=$this->auth->getUserInfo()['user_code'];
        $this->view->assign("user_code", $this->code);
        //获取奖金币当前余额
        $user_finance=model("FinancePersonalaccount")
                        ->where(['user_code'=>$this->code,'type'=>1])
                        ->select();
        $this->view->assign("now_balance", $user_finance[0]['balance']);
        //获取奖金币提现手续费费率
        $rate_param=model("FinanceParameter")
                    ->where(['group_name'=>'txsxf','param_name'=>'jj'])
                    ->select();
        $this->view->assign("rate_param", $rate_param[0]['param_value']*100);
        //获取最低提现额度
        $this->low_amount=model("FinanceParameter")
                    ->where(['group_name'=>'txed','param_name'=>'low'])
                    ->select();
        $this->view->assign("low_amount", $this->low_amount[0]['param_value']);

        $this->view->assign("stateList", $this->model->getStateList());
    }
    
    /**
     * 查看
     */
    public function index()
    {
        //设置过滤方法
        $this->request->filter(['strip_tags']);
        if ($this->request->isAjax())
        {
            //如果发送的来源是Selectpage，则转发到Selectpage
            if ($this->request->request('pkey_name'))
            {
                return $this->selectpage();
            }
            list($where, $sort, $order, $offset, $limit) = $this->buildparams();
            $total = $this->model
                    ->where($where)
                    ->where(['application_user_code'=>$this->code, 'send_is_delete'=>false])
                    ->order($sort, $order)
                    ->count();

            $list = $this->model
                    ->where($where)
                    ->where(['application_user_code'=>$this->code, 'send_is_delete'=>false])
                    ->order($sort, $order)
                    ->limit($offset, $limit)
                    ->select();

            $result = array("total" => $total, "rows" => $list);

            return json($result);
        }
        return $this->view->fetch();
    }


    /**
     * 添加
     */
    public function add()
    {
        if ($this->request->isPost())
        {
            $params = $this->request->post("row/a");
            if ($params)
            {
                if ($this->dataLimit)
                {
                    $params[$this->dataLimitField] = $this->auth->id;
                }
                try
                {
                    //是否采用模型验证
                    if ($this->modelValidate)
                    {
                        $name = basename(str_replace('\\', '/', get_class($this->model)));
                        $validate = is_bool($this->modelValidate) ? ($this->modelSceneValidate ? $name . '.add' : true) : $this->modelValidate;
                        $this->model->validate($validate);
                    }
                    //获取奖金币当前余额
                    $user_finance=model("FinancePersonalaccount")
                                    ->where(['user_code'=>$this->code,'type'=>1])
                                    ->select();
                    if ($params['application_amount']<$this->low_amount[0]['param_value']||$params['application_amount']>$user_finance[0]['balance']) {
                         $this->error('请输入正确提现金额');
                    }
                     // 会员提现
                    $params['param_business_code'] = Engine::BUSCODE_HYTX_JJ;
                    $params['param_user_code'] = $params['application_user_code'];
                    $params['param_transaction_amount'] = $params['application_amount'];
                    $params['param_operation_user_code'] = $this->code;
                    $result = model('StoreProcedure')->proFinanceEngine($params);
                    // 添加提现申请
                    if ($result['code'] == 1)
                    {
                        $result = $this->model->allowField(true)->save($params);
                        if ($result !== false)
                        {
                            $this->success();
                        }
                        else
                        {
                            $this->error($this->model->getError());
                        }
                    }
                    else
                    {
                        $this->error($result['msg']);
                    }
                   
                }
                catch (\think\exception\PDOException $e)
                {
                    $this->error($e->getMessage());
                }
            }
            $this->error(__('Parameter %s can not be empty', ''));
        }

        return $this->view->fetch();
    }

    /**
     * 详情
     */
    public function details($ids = NULL)
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



}
