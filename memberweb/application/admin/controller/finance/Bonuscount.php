<?php

namespace app\admin\controller\finance;

use app\common\controller\Backend;
use app\admin\library\BonusCalculation;
use think\Controller;

/**
 * 奖金核算
 *
 */
class Bonuscount extends Backend
{
    public function _initialize()
    {
        parent::_initialize();
        $this->model = model('FinanceBonustemp');
        //获取系统设置K-值
        $system_k_value=model('FinanceParameter')->where(['group_name'=>'bobi','param_name'=>'k_value'])
                    ->select()[0]['param_value'];
        $this->view->assign("system_k_value", $system_k_value);
    }

    /**
     * 临时奖金
     * @Author   zzk
     * @DateTime 2018-03-21T20:16:39+0800
     * @return   [type]                   [description]
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
                    ->order(['user_code'=>'asc'])
                    ->count();

            $list = $this->model
                    ->where($where)
                    ->order(['user_code'=>'asc'])
                    ->limit($offset, $limit)
                    ->select();

            $result = array("total" => $total, "rows" => $list);

            return json($result);
        }
        return $this->view->fetch();
    }

    /**
     * 修改实际奖金
     * @Author   zzk
     * @DateTime 2018-03-20T22:16:12+0800
     * @param    [type]                   $ids [description]
     * @return   [type]                        [description]
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
        // 后台渲染
        $this->view->assign("real_bonus", $row['reality_money']);
        return $this->view->fetch();
    }

    /**
     * 奖金核算
     * @Author   zzk
     * @DateTime 2018-03-21T20:07:31+0800
     * @return   [type]                   [description]
     */
    public function calculate() {
        if ($this->request->isAjax())
        {
            $deadline_time = $this->request->post("deadline_time");
            if (!is_null($deadline_time))
            {
                try
                {
                    //清除所有临时计算奖金
                    BonusCalculation::deleteAllbounsTemp();
                    //推荐奖计算
                    $result = BonusCalculation::tjj_cal($deadline_time);
                    if ($result == false)
                    {
                        $this->error($result);
                    }
                    //销售奖计算
                    $result = BonusCalculation::xsj_cal($deadline_time);
                    if ($result == false)
                    {
                        $this->error($result);
                    }
                    //管理奖计算
                    $result = BonusCalculation::glj_cal($deadline_time);
                    if ($result == false)
                    {
                        $this->error($result);
                    }
                    //重消奖计算
                    $result = BonusCalculation::cxj_cal($deadline_time);
                    if ($result == false)
                    {
                        $this->error($result);
                    }
                    //服务奖计算
                    $result = BonusCalculation::fwj_cal($deadline_time);
                    if ($result == false)
                    {
                        $this->error($result);
                    }
                    //见点奖计算
                    $result = BonusCalculation::jdj_cal($deadline_time);
                    if ($result == false)
                    {
                        $this->error($result);
                    }
                    if ($result !== false)
                    {
                        $this->success();
                    }
                    else
                    {
                        $this->error($result);
                    }
                }
                catch (\think\exception\PDOException $e)
                {
                    $this->error($e->getMessage());
                }
            }
            $this->error(__('Parameter %s can not be empty', ''));
        }
    }




    /**
     * 奖金发放
     * @Author   zzk
     * @DateTime 2018-03-21T20:07:31+0800
     * @return   [type]                   [description]
     */
    public function giveOut() {
        if ($this->request->isAjax())
        {
                try
                {
                    $result = BonusCalculation::jjpf('0',$this->auth->getUserInfo()['user_code']);     
                    if ($result == false)
                    {
                        $this->error($result);
                    }
                    $result = BonusCalculation::jjpf('1',$this->auth->getUserInfo()['user_code']);     
                    if ($result == false)
                    {
                        $this->error($result);
                    }
                    $result = BonusCalculation::jjpf('2',$this->auth->getUserInfo()['user_code']);     
                    if ($result == false)
                    {
                        $this->error($result);
                    }
                    $result = BonusCalculation::jjpf('3',$this->auth->getUserInfo()['user_code']);     
                    if ($result == false)
                    {
                        $this->error($result);
                    }
                    $result = BonusCalculation::jjpf('4',$this->auth->getUserInfo()['user_code']);     
                    if ($result == false)
                    {
                        $this->error($result);
                    }
                    $result = BonusCalculation::jjpf('5',$this->auth->getUserInfo()['user_code']);     
                    if ($result == false)
                    {
                        $this->error($result);
                    }
                    else
                    {
                        $this->success();
                    }
                }
                catch (\think\exception\PDOException $e)
                {
                    $this->error($e->getMessage());
                }
        }
    }

    /**
     * 根据奖金类型获取临时奖金参数（总计算金额、总实际金额、核算日期）
     * @Author   zzk
     * @DateTime 2018-03-21T20:07:31+0800
     * @return   [type]                   [description]
     */
    public function getParamsByType() {
        if ($this->request->isAjax())
        {
                try
                {
                    // 获取总计算金额、总实际金额
                    $total_result = $this->model
                        ->field('sum(plan_money) as total_count_bonus,sum(reality_money) as total_real_bonus')
                        ->find();
                    $bonus_type = 'cxj_cal';
                    // 获取核算日期
                    $date_result = model('ConfigSystemTime')
                        ->field("system_time as account_date")
                        ->where(['type' => $bonus_type])
                        ->find();
                    $bonus_type = 'cxj_cal_temp';
                    // 获取核算日期
                    $date_result_temp = model('ConfigSystemTime')
                        ->field("system_time as account_date")
                        ->where(['type' => $bonus_type])
                        ->find();
                    //获取总业绩金额
                    $reality_total=model('FinanceHistoryTransactionalflow')
                                        ->field('transaction_amount')
                                        ->where(['business_code'=>'hybd'])
                                        ->where("trading_time>'".$date_result['account_date']."' and trading_time<'".$date_result_temp['account_date']."'")
                                        ->sum('transaction_amount');
                    //计算K值
                    $k_value=0;
                    if ($reality_total!=null&&$reality_total>0) {
                        $k_value=$total_result['total_real_bonus']/ $reality_total;
                    }
                    // 验证结果
                    if ($total_result !== false && $date_result !== false)
                    {
                        $this->success('',null,[$total_result,$date_result,$date_result_temp,$k_value]);
                    }
                    else
                    {
                        $this->error($this->model->getError());
                    }
                }
                catch (\think\exception\PDOException $e)
                {
                    $this->error($e->getMessage());
                }
            $this->error(__('Parameter %s can not be empty', ''));
        }
    }


    //生成建议奖金发放结果
    public function calSuggest(){

        //获取添加时间有限权重
        $admins=model("Admin")
                    ->field("user_code")
                    ->order(["create_time"=>'desc'])
                    ->select();

        $adminCount=count($admins);
        $adminlist=[];
        for ($i=0; $i <$adminCount ; $i++) { 
            $adminlist[$admins[$i]['user_code']]=['value' =>$i+1];
        }
        //获取总奖金有限权重
        $histoyBount=model("FinanceHistoryBonus")
                    ->field("user_code,sum(reality_money) as  reality_money ")
                    ->group("user_code")
                    ->order(['sum(reality_money)'=>'asc'])
                    ->select();
        $histoyBountCount=count($histoyBount);
        for ($i=0; $i <$histoyBountCount ; $i++) { 
            $adminlist[$histoyBount[$i]['user_code']]['value']=$adminlist[$histoyBount[$i]['user_code']]['value']+$i+1;
        }


        //获取系统设置K-值
        $system_k_value=model('FinanceParameter')->where(['group_name'=>'bobi','param_name'=>'k_value'])
                    ->select()[0]['param_value'];

        // 获取核算日期
        $date_result = model('ConfigSystemTime')
                ->field("system_time as account_date")
                ->where(['type' => 'cxj_cal'])
                ->find();
         // 获取核算日期
        $date_result_temp = model('ConfigSystemTime')
                ->field("system_time as account_date")
                ->where(['type' => "cxj_cal_temp"])
                ->find();
        //获取总业绩金额
        $reality_total=model('FinanceHistoryTransactionalflow')
                ->field('transaction_amount')
                ->where(['business_code'=>'hybd'])
                ->where("trading_time>'".$date_result['account_date']."' and trading_time<'".$date_result_temp['account_date']."'")
                ->sum('transaction_amount');
        //计算设置发放奖金金额
        $suggest_money=$reality_total*$system_k_value;


        //获取总的奖金
        $list = $this->model
                    ->select();
        //获取总奖金金额
        $bouns_total=$this->model
                    ->sum('reality_money');
        if ($suggest_money>=$bouns_total) {
            $this->success();
        }

        $updateList=[];

        for ($i=0; $i <count($list)-1 ; $i++) { 
            $i_user_code=$list[$i]['user_code'];
            $i_value=$adminlist[$i_user_code]['value'];
            for ($j=$i+1; $j< count($list); $j++) { 
                $j_user_code=$list[$j]['user_code'];
                if ($i_value<$adminlist[$j_user_code]['value']) {
                    $temp=$list[$i];
                    $list[$i]=$list[$j];
                    $list[$j]=$temp;
                }
            }
            if ($list[$i]['reality_money']<=0) {
                continue;
            }
            if (($bouns_total-$list[$i]['reality_money'])> $suggest_money) {
                $bouns_total=$bouns_total-$list[$i]['reality_money'];
                array_push($updateList, ['id'=>$list[$i]['id'],'reality_money'=>0]);
                $list[$i]['reality_money']=0;
            }else {
                $list[$i]['reality_money']=$list[$i]['reality_money']+$suggest_money-$bouns_total;
                array_push($updateList, ['id'=>$list[$i]['id'],'reality_money'=>$list[$i]['reality_money']]);
                break;
            }
        }
        $this->model->saveAll($updateList);
        $this->success();


    }

}
