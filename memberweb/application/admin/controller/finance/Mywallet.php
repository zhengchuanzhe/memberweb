<?php

namespace app\admin\controller\finance;

use app\admin\library\Engine;
use app\common\controller\Backend;
use think\Controller;
use think\Db;

/**
 * 我的钱包
 *
 */
class Mywallet extends Backend
{
    public function index()
    {
        $code = $this->auth->getUserInfo()['user_code'];
        $cash = 0.00;
        $bonus = 0.00;
        $shopping = 0.00;

        //获取用户现金币、奖金、购物积分
        $balances = model('FinancePersonalaccount')
            ->field('type,balance')
            ->where(['user_code' => $code])
            ->select();

        foreach ($balances as $balance) {
            switch ($balance['type']) {
                case 0:
                    $cash = $balance['balance'];
                    break;
                case 1:
                    $bonus = $balance['balance'];
                    break;
                case 2:
                    $shopping = $balance['balance'];
                    break;
                case 3:
                    $registered_integral = $balance['balance'];
                    break;
                default:
                    break;
            }
        }

        //获取用户账单流水
        $historyTranFlow = model('FinanceHistoryTransactionalflow')
            ->alias('a')
            ->field('serial_number,transaction_amount,trading_time,operation_user_code')
            ->where(['user_code' => $code])
            ->where('display_type','<>','2')
            ->order(['trading_time'=>'desc'])
            ->join('trya_finance_businessmodule b','a.business_code = b.business_code')
            ->field('a.*,b.business_code,b.business_name')
            ->select();

        //获取各币种转换汇率
        $rates = model('FinanceParameter')
                    ->where(['group_name'=>'hbzh'])
                    ->select();
        foreach ($rates as $rate) {
            switch ($rate['param_name']) {
                case 'xj2jf':
                    $rate_one= $rate['param_value'];
                    break;
                case 'jj2jf':
                    $rate_two = $rate['param_value'];
                    break;
                case 'jj2xj':
                    $rate_three = $rate['param_value'];
                    break;
                default:
                    break;
            }
        }
        //结算转换
        if($this->request->isPost()){
            $params = $this->request->post("row/a");
            if($params){
                if(!empty($params['cash_shopping_cash'])&&$params['cash_shopping_cash']>0){
                    if($params['cash_shopping_cash']>$cash){
                        $this->error(__('Account not enough'));
                    }

                    else {
                        //调用存储过程,第一种转换
                        $params['param_user_code'] = $code;
                        $params['param_transaction_amount'] = $params['cash_shopping_cash'];
                        $params['param_change_type'] = 0;
                        $params['param_operation_user_code']= $code;

                        $result = model('StoreProcedure')->proFinancePersonalChange($params);
                        if ($result['code'] == 0) {

                            $this->error(__('Handler Failed'));
                        } else {
                            $this->success(__('Change success'));
                        }
                    }
                }
                else if(!empty($params['bonus_shopping_bonus'])&&$params['bonus_shopping_bonus']>0){
                    if($params['bonus_shopping_bonus']>$bonus){
                        $this->error(__('Account not enough'));
                    }
                    else {
                        //调用存储过程,第二种转换
                        $params['param_user_code'] = $code;
                        $params['param_transaction_amount'] = $params['bonus_shopping_bonus'];
                        $params['param_change_type'] = 1;
                        $params['param_operation_user_code']= $code;
                        $result = model('StoreProcedure')->proFinancePersonalChange($params);
                        if ($result['code'] == 0) {
                            $this->error(__('Handler Failed'));
                        } else {
                            $this->success(__('Change success'));
                        }
                    }
                }
                else if(!empty($params['bonus_cash_bonus'])&&$params['bonus_cash_bonus']>0){
                    if($params['bonus_cash_bonus']>$bonus){
                        $this->error(__('Account not enough'));
                    }
                    else {
                        //调用存储过程,第三种转换
                        $params['param_user_code'] = $code;
                        $params['param_transaction_amount'] = $params['bonus_cash_bonus'];
                        $params['param_change_type'] = 2;
                        $params['param_operation_user_code']= $code;
                        $result = model('StoreProcedure')->proFinancePersonalChange($params);
                        if ($result['code'] == 0) {
                            $this->error(__('Handler Failed'));
                        } else {
                            $this->success(__('Change success'));
                        }
                    }
                }
                $this->error(__('Parameter Error'));
            }
            else {
                $this->error(__('Parameter %s can not be empty', ''));
            }
        }
        //页面绑定
        $this->view->assign([
            'totalcash'     => $cash,
            'totalbonus'    => $bonus,
            'totalshopping' => $shopping,
            'registered_integral' => $registered_integral, //注册积分
            'historyTranFlow'    => $historyTranFlow,
            'rate_one' => $rate_one,
            'rate_two' => $rate_two,
            'rate_three' => $rate_three,
        ]);
        //个人账户流水
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
            $total = model('FinanceHistoryPersonalaccountflow')
                ->alias('p')
                ->where($where)
                ->order('p.id desc')
                ->join('trya_finance_history_transactionalflow t','p.serial_number=t.serial_number')
                ->join('trya_finance_businessmodule b','b.business_code=t.business_code')
                ->field('p.id')
                ->where('p.user_code',$code)
                ->count();

            $list = model('FinanceHistoryPersonalaccountflow')
                ->alias('p')
                ->where($where)
                ->order('p.id desc')
                ->limit($offset, $limit)
                ->join('trya_finance_history_transactionalflow t','p.serial_number=t.serial_number')
                ->join('trya_finance_businessmodule b','b.business_code=t.business_code')
                ->field('IFNULL(p.mark,b.business_name) as mark,p.id,p.user_code,p.counterparty,p.account_type,p.transaction_amount,p.trade_direction,p.before_balance,p.after_balance,p.trading_time')
                ->where('p.user_code',$code)
                ->select();

            $result = array("total" => $total, "rows" => $list);

            return json($result);
        }
        return $this->view->fetch();
    }

    /**
     * 流水详情
     * @Author   zzk
     * @DateTime 2018-02-11T18:42:14+0800
     * @param    [type]                   $ids [description]
     * @return   [type]                        [description]
     */
    public function detail($nos = NULL)
    {
        //获取用户流水
        $tranflows = model('FinanceHistoryPersonalaccountflow')
            ->field('account_type,transaction_amount,trade_direction,before_balance,after_balance,mark')
            ->where(['serial_number' => $nos])
            ->select();

        if (!$tranflows)
            $this->error(__('No Results were found'));
        $this->view->assign("tranflows", $tranflows);
        return $this->view->fetch();
    }
}
