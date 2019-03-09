<?php

namespace app\admin\controller\finance;

use app\common\controller\Backend;

use think\Controller;
use think\Request;
class Companyaccount extends Backend{
    protected $model = null;
    public function _initialize()
    {
        parent::_initialize();
        $this->model = model('FinanceCompanyAccount');
        $account = $this->model->field('balance')->select();
        $account_cash = NULL;
        foreach($account as $k => $v){
            $account_cash += $v['balance'];
        }
        $model = model('FinanceHistoryTransactionalflow');
        $account_list = $model
            ->where('display_type','<>','1')
            ->alias('a')
            ->order('trading_time','desc')
            ->limit(5)
            ->join('trya_finance_businessmodule b','a.business_code = b.business_code')
            ->field('a.*,b.business_code,b.business_name')
            ->select();
        $this->assign('account_list',$account_list);
        $this->assign('account_cash',$account_cash);
    }
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
                ->order($sort, $order)
                ->count();

            $list = $this->model
                ->where($where)
                ->order($sort, $order)
                ->limit($offset, $limit)
                ->select();
            $result = array("total" => $total, "rows" => $list);

            return json($result);
        }
        return $this->view->fetch();
    }
}