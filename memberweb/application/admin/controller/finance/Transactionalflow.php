<?php

namespace app\admin\controller\finance;

use app\common\controller\Backend;

use think\Controller;
use think\Request;

/**
 * 会员提现申请
 *
 * @icon fa fa-circle-o
 */
class Transactionalflow extends Backend{
    protected $model = NULL;
    protected $relationSearch = true;

    public function _initialize()
    {
        parent::_initialize();
        $this->model = model('FinanceHistoryTransactionalflow');
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
                ->alias('a')
                ->join('trya_finance_businessmodule b','a.business_code = b.business_code')
                ->where($where)
                ->where('display_type','<>','1')
                ->order($sort, $order)
                ->count();

            $list = $this->model
                ->alias('a')
                ->join('trya_finance_businessmodule b','a.business_code = b.business_code')
                ->field('a.*,b.business_code,b.business_name')
                ->where($where)
                ->where('display_type','<>','1')
                ->order($sort, $order)
                ->limit($offset, $limit)
                ->select();
            $result = array("total" => $total, "rows" => $list);

            return json($result);
        }
        return $this->view->fetch();
    }
    public function details($ids = NULL){
        //获取当前业务单信息
        $trade_info = $this->model->get($ids);
        $serial_number = $trade_info['serial_number'];
        if (!$trade_info)
            $this->error(__('No Results were found'));
        $this->view->assign('trade_info',$trade_info);
        $business_info = model('FinanceHistoryAccountentries')
            ->where(array("serial_number"=>$serial_number))
            ->select();
        $personal_info = model('FinanceHistoryPersonalaccountflow')
            ->where(array("serial_number"=>$serial_number))
            ->select();
        $this->assign([
            'trade_info' => $trade_info,
            'business_info' => $business_info,
            'personal_info' => $personal_info,
        ]);
        return $this->view->fetch();
    }
}