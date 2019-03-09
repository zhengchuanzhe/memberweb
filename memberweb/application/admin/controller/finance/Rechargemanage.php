<?php

namespace app\admin\controller\finance;

use app\common\controller\Backend;
use app\admin\library\Engine;
use think\Controller;
use think\Request;

/**
 * 申请充值管理
 *
 * @icon fa fa-circle-o
 */
class Rechargemanage extends Backend
{
    
    /**
     * FinanceApplicationRecharge模型对象
     */
    protected $model = null;
    protected $code=null;
    public function _initialize()
    {
        parent::_initialize();
        $this->model = model('FinanceRecharge');

        //获取当前会员的code
        $this->code=$this->auth->getUserInfo()['user_code'];
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
                    ->where(['receive_is_delete'=>false])
                    ->order($sort, $order)
                    ->count();

            $list = $this->model
                    ->where($where)
                    ->where(['receive_is_delete'=>false])
                    ->order($sort, $order)
                    ->limit($offset, $limit)
                    ->select();

            $result = array("total" => $total, "rows" => $list);

            return json($result);
        }
        return $this->view->fetch();
    }

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
        if ($this->request->isPost())
        {
            $params = $this->request->post("row/a");
            if ($params)
            {
                try
                {
                    //是否采用模型验证
                    if ($this->modelValidate)
                    {
                        $name = basename(str_replace('\\', '/', get_class($this->model)));
                        $validate = is_bool($this->modelValidate) ? ($this->modelSceneValidate ? $name . '.edit' : true) : $this->modelValidate;
                        $row->validate($validate);
                    }
                    $result = $row->allowField(true)->save($params);
                    if ($result !== false)
                    {
                        $this->success();
                    }
                    else
                    {
                        $this->error($row->getError());
                    }
                }
                catch (\think\exception\PDOException $e)
                {
                    $this->error($e->getMessage());
                }
            }
            $this->error(__('Parameter %s can not be empty', ''));
        }

        // 获取当前会员现金币
        $userFinance = model('FinancePersonalaccount')
                ->field("balance")
                ->where(['user_code'=>$this->code, 'type'=>0, 'delete_time'=>NULL])
                ->find();

        // 页面绑定
        $this->view->assign("row", $row);
        $this->view->assign("hand_user_code", $this->code);
        $this->view->assign('before_balance', $userFinance['balance']); 
        return $this->view->fetch();
    }

    /**
     * 删除
     */
    public function del($ids = "")
    {
        if ($ids)
        {
            $pk = $this->model->getPk();
            $adminIds = $this->getDataLimitAdminIds();
            if (is_array($adminIds))
            {
                $count = $this->model->where($this->dataLimitField, 'in', $adminIds);
            }
            $list = $this->model->where($pk, 'in', $ids)->select();
            $count = 0;
            foreach ($list as $k => $v)
            {
                $v["receive_is_delete"]=true;
                $count += $v->save();
            }
            if ($count)
            {
                $this->success();
            }
            else
            {
                $this->error(__('No rows were deleted'));
            }
        }
        $this->error(__('Parameter %s can not be empty', 'ids'));
    }

    /**
     * 充值
     * @Author   zzk
     * @DateTime 2018-02-22T13:56:01+0800
     * @return   [type]                   [description]
     */
    public function recharge()
    {
        // 获取参数
        $params = $this->request->post("row/a");
        // 验证参数
        if ($params['id']&&$params['state']&&$params['application_user_code']&&$params['application_amount']) {
            try{
                $rechargeInfo=$this->model->get($params['id']);
                if ($rechargeInfo['state']==0) {
                    // 是待确认状态
                    // 会员充值
                    $params['param_business_code'] = Engine::BUSCODE_HYCZ;
                    $params['param_user_code'] = $params['application_user_code'];
                    $params['param_transaction_amount'] = $params['application_amount'];
                    $params['param_operation_user_code'] = $this->code;
                    $result = model('StoreProcedure')->proFinanceEngine($params);
                    // 更改申请表状态
                    if ($result['code'] == 1)
                    {
                        // 充值成功则更改
                        $rechargeInfo['state'] = $params['state'];
                        $rechargeInfo['after_balance'] = $params['after_balance'];
                        $rechargeInfo['hand_user_code'] = $params['hand_user_code'];
                        $rechargeInfo['mark'] = $params['mark'];
                        $rechargeRes = $rechargeInfo->save();
                        $this->success('', null, [
                            'res'=>$rechargeRes, 
                            'after_balance'=>$params['after_balance'], 
                            'hand_user_code'=>$params['hand_user_code'], 
                            'mark'=>$params['mark']
                        ]);
                    }
                    else
                    {
                        $this->error($result['msg']);
                    }
                }else{
                    // 否则报错
                    $this->error(__('Recharge Failed'));
                }
            }
            catch (\think\exception\PDOException $e)
            {
                $this->error($e->getMessage());
            }  
            
        }
        $this->error(__('Parameter Error'));
    }
    
    /**
     * 拒绝充值申请
     * @Author   zzk
     * @DateTime 2018-02-22T13:56:01+0800
     * @return   [type]                   [description]
     */
    public function rechargeCancel()
    {
        // 获取参数
        $params = $this->request->post("row/a");

        // 验证参数
        if ($params['id']&&$params['state']) {
            try{
                $rechargeInfo=$this->model->get($params['id']);
                if ($rechargeInfo['state']==0) {
                    // 是待确认状态
                    // 更改申请表状态
                    $rechargeInfo['state'] = $params['state'];
                    $rechargeInfo['hand_user_code'] = $params['hand_user_code'];
                    $rechargeInfo['mark'] = $params['mark'];
                    $rechargeRes = $rechargeInfo->save();
                    $this->success('', null, [
                        'res'=>$rechargeRes, 
                        'hand_user_code'=>$params['hand_user_code'], 
                        'mark'=>$params['mark']
                    ]);
                }else{
                    // 否则报错
                    $this->error(__('Recharge Failed'));
                }
            }
            catch (\think\exception\PDOException $e)
            {
                $this->error($e->getMessage());
            }  
            
        }
        $this->error(__('Parameter Error'));
    }

}
