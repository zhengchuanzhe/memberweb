<?php

namespace app\admin\controller\finance;

use app\common\controller\Backend;

use think\Controller;
use think\Request;

/**
 * 会员账户流水
 *
 * @icon fa fa-circle-o
 */
class Historypersonalaccountflow extends Backend
{
    
    /**
     * FinanceHistoryPersonalaccountflow模型对象
     */
    protected $model = null;
    protected $relationSearch = true;

    public function _initialize()
    {
        parent::_initialize();
        $this->model = model('FinanceHistoryPersonalaccountflow');

    }
    
    /**
     * 默认生成的控制器所继承的父类中有index/add/edit/del/multi五个方法
     * 因此在当前控制器中可不用编写增删改查的代码,如果需要自己控制这部分逻辑
     * 需要将application/admin/library/traits/Backend.php中对应的方法复制到当前控制器,然后进行修改
     */

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
                    ->alias('p')
                    ->where($where)
                    ->order('p.id desc')
                    ->join('trya_finance_history_transactionalflow t','p.serial_number=t.serial_number')
                    ->join('trya_finance_businessmodule b','b.business_code=t.business_code')
                    ->field('p.id')
                    ->count();

            $list = $this->model
                    ->alias('p')
                    ->where($where)
                    ->order('p.id desc')
                    ->limit($offset, $limit)
                    ->join('trya_finance_history_transactionalflow t','p.serial_number=t.serial_number')
                    ->join('trya_finance_businessmodule b','b.business_code=t.business_code')
                    ->field('IFNULL(p.mark,b.business_name) as mark,p.id,p.user_code,p.counterparty,p.account_type,p.transaction_amount,p.trade_direction,p.before_balance,p.after_balance,p.trading_time')
                    ->select();

            $result = array("total" => $total, "rows" => $list);

            return json($result);
        }
        return $this->view->fetch();
    }


}
