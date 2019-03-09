<?php

namespace app\admin\library;
use think\Db;

/**
 * 奖金计算类
 */
class BonusCalculation
{


	public static function deleteAllbounsTemp()
	{
		return model('StoreProcedure')->deleteAllbounsTemp();
	}


	/**
	 * 奖金派发
	 * $type：0推荐奖,1销售奖,2管理奖,3重消奖
	 * $operation_user_code 操作人编号
	 */
	public static function jjpf($type,$operation_user_code)
	{
		return model('StoreProcedure')->proBonusOut($type,$operation_user_code);
	}


	/**
	 * 推荐奖计算
	 */
	public static function tjj_cal($deadline_time)
	{
		return model('StoreProcedure')->proBonusCalculationTjj($deadline_time);
	}


	/**
	 *销售奖计算
	 */
	public static function xsj_cal($deadline_time)
	{

		return BonusCalculation::manage_cal($deadline_time)&&model('StoreProcedure')->proBonusCalculationXsj($deadline_time);
	}




	/**
	 * 管理奖计算
	 * 返回bool型
	 */
	public static function glj_cal($deadline_time)
	{
		return model('StoreProcedure')->proBonusCalculationGlj($deadline_time);
	}

	/**
	 * 重消奖计算
	 * 返回bool型
	 */
	public static function cxj_cal($deadline_time)
	{
		$result = model('StoreProcedure')->proBonusCxjGetDate($deadline_time);
		$a=[];
		if ($result==null) {
			return false;
		}
		foreach ($result as $k => $v) {
			$v['bouns']=0.0;//奖金
			$a[$v['user_code']]=$v;
		}
		$paramModel=model('FinanceParameter');

		//重消奖层级
		$param_cj=$paramModel
					->where(['group_name'=>'cxj','param_name'=>'cj'])
					->select()[0]['param_value'];
		//重消奖比例
		$param_bl=$paramModel
					->where(['group_name'=>'cxj','param_name'=>'bl'])
					->select()[0]['param_value'];
		// 逐层计算
		foreach ($a as $k => $v) {
			$manage_user_code=$v['manage_user_code'];
			if ($manage_user_code==$k) {
				//管理人员就是他本身不再计算
				continue;
			}
			for ($i=0; $i <$param_cj ; $i++) {
				if (!array_key_exists($manage_user_code,$a)||$manage_user_code==$a[$manage_user_code]['manage_user_code']) {
					//管理人员就是他本身或不存在该键值对不再计算
					break;
				}
			    //在其上级增加奖金
			    $a[$manage_user_code]['bouns']= $a[$manage_user_code]['bouns']+$v['price']*$param_bl;
				$manage_user_code=$a[$manage_user_code]['manage_user_code'];
			}
		}
		$bouns_type=3;//重复消费奖
		$bounstemp= model("FinanceBonustemp");
		foreach ($a as $key => $value) {
			$dataList[]=array('user_code' =>$value['user_code'] ,
							  'bonus_type'=>$bouns_type,
							  'trade_direction'=>1,
							  'plan_money'=>$value['bouns'],
							  'reality_money'=>$value['bouns']
							);
		}
		$result=$bounstemp->where(['bonus_type'=>$bouns_type])->delete();//删除原有计算数据
		$result= $bounstemp->insertAll($dataList,true);//批量插入
		if ($result==count($dataList)) {
			return true;
		}
		return false;
	}

	/**
	 * 服务奖计算
	 * 返回bool型
	 */
	public static function fwj_cal($deadline_time)
	{
		return model('StoreProcedure')->proBonusCalculationFwj($deadline_time);
	}


	/**
	 * 见点奖计算
	 * 返回bool型
	 */
	public static function jdj_cal($deadline_time)
	{
		$jdjdate = model('StoreProcedure')->proBonusJdjGetDate($deadline_time);

		if ($jdjdate==null) {
			return false;
		}

		$paramModel=model('FinanceParameter');
		//见点奖费率
		$param_fl=$paramModel
					->where(['group_name'=>'jdj','param_name'=>'fl'])
					->select()[0]['param_value'];
        $param_cj=$paramModel
                    ->where(['group_name'=>'jdjcj'])
                    ->max('param_value');
		$a=[];
		$users=model("Admin")            
                ->alias('a')
				->field('user_code,manage_user_code,param_value as cj')
                ->join('trya_finance_parameter p',"a.grade_code=p.param_name and p.group_name='jdjcj'")
                ->where('a.id!=1')
				->select();

		foreach ($users as $k => $v) {
			$v['bouns']=0.0;//奖金
			$v['mark']='';
			$a[$v['user_code']]=$v;
		}

		foreach ($jdjdate as $k => $v) {
			$money=$v['transaction_amount'];
			$manage_user_code=$a[$v['counterparty']]['manage_user_code'];
			for ($i=0; $i <$param_cj ; $i++) {
				if (!array_key_exists($manage_user_code,$a)||$manage_user_code==$a[$manage_user_code]['manage_user_code']) {
					//管理人员就是他本身或不存在该键值对不再计算
					break;
				}
                if ($a[$manage_user_code]['cj']>$i) {
                    $a[$manage_user_code]['bouns']=$a[$manage_user_code]['bouns']+$money*$param_fl;
                    $a[$manage_user_code]['mark']=$a[$manage_user_code]['mark'].'下'.(string)($i+1).'层用户'.$v['counterparty'].' ';   
                }
				$manage_user_code=$a[$manage_user_code]['manage_user_code'];
			}
		}

		$bouns_type=5;//见点奖
		$bounstemp= model("FinanceBonustemp");
		foreach ($a as $key => $value) {
			$dataList[]=array('user_code' =>$value['user_code'] ,
							  'bonus_type'=>$bouns_type,
							  'trade_direction'=>1,
							  'plan_money'=>$value['bouns'],
							  'reality_money'=>$value['bouns'],
                              'mark'=>$value['mark']
							);
		}
		$result=$bounstemp->where(['bonus_type'=>$bouns_type])->delete();//删除原有计算数据
		$result= $bounstemp->insertAll($dataList,true);//批量插入
		if ($result==count($dataList)) {
			return true;
		}
		return false;
	}


	//计算血缘业绩
	public static function manage_cal($ftime){
		// 获取核算日期
        $date_result = model('ConfigSystemTime')
                ->field("system_time as account_date")
                ->where(['type' => 'xsj_cal'])
                ->find();
		 //获取业绩金额
        $user_yeji=model('FinanceHistoryTransactionalflow')
                ->field('user_code,sum(transaction_amount) as user_yeji')
                ->where(['business_code'=>'hybd'])
                ->where("trading_time>'".$date_result['account_date']."' and trading_time<'".$ftime."'")
                ->group('user_code');

        $admins = model("Admin")
            ->field(['id', 'user_code', 'user_name', 'manage_user_code'])
            ->where('user_code', '<>', '1234567')
            ->order('id', 'asc')
            ->select();

        $admin_list=[];
        foreach ($admins as $k => $v) {
        	$admin_list[$v['user_code']]=['manage_user_code'=>$v['manage_user_code'],'value'=>0];
        }

        foreach ($user_yeji as $k => $v) {
        	$user_code=$v['code'];
        	$user_yeji=$v['user_yeji'];
        	$manage_user_code=$admin_list[$user_code]['manage_user_code'];
        	$admin_list[$manage_user_code]['value']=$admin_list[$user_code]['value']+$user_yeji;
        }

        $data=[];
        foreach ($admin_list as $k => $v) {
        	array_push($data, ['user_code'=>$k,'now_day_amount'=>$v['value'],'type'=>1,'cal_time'=>$ftime]);
        }

        model('FinanceHistoryPersonalperformance')->saveAll($data);
       	return true;
	}



}