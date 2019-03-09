<?php

namespace app\admin\model;

use think\Db;
use think\Model;

/**
 * 存储过程模块
 */
class StoreProcedure extends Model
{

	/**
	 * 格式化返回值
	 * @Author   zzk
	 * @DateTime 2018-02-07T16:01:42+0800
	 * @param    [type]                   $rtn [description]
	 * @return   [type]                        [description]
	 */
	function formatResult($result) {

		$rtn = array('code'=>0,'msg'=>'计算错误'); //初始化返回值
		$len = count($result); //返回数组长度
	
		// 验证返回值的最后的一个值是否为数组
		if (is_array($result[$len-1][0])) {
			// 验证最后一个数组键名是否正确
	    	if (array_key_exists("pro_err", $result[$len-1][0]) ) { 
	    		if ($result[$len-1][0]['pro_err'] == 0) { // 返回正确
	    			$rtn['code'] = 1;		
	    		} 
	    	} 
	    }

	    return $rtn;
	}

    /**
	 * 添加订单 
	 * 
	 * name:pro_order_add
	 *
	 * 业务逻辑
	 *  1.更改产品库存（产品表，库存-订单产品数量）
	 *  2.更改用户余额（用户资金表，用户余额-订单总金额）
	 *  3.生成订单（订单表）
	 *
	 * 参数
	 *  IN `product_productinfo_id` int,
	 *  IN `order_quantity` int,
	 *  IN `order_total_price` float,
	 *  IN `order_user_code` varchar(10),
	 *  IN `order_time` datetime,
	 *  IN `order_phone` varchar(20),
	 *  IN `receive_address` varchar(20),
	 *  IN `receive_name` varchar(20),
	 *  IN `product_real_price` float
	 * @Author   zzk
	 * @DateTime 2018-02-07T10:37:38+0800
	 */
	public function proOrderAdd($params){

	    $result = Db::query("call pro_order_add(?,?,?,?,?,?,?,?,?)",[
	        $params['product_productinfo_id'],
	        $params['order_quantity'],
	        $params['order_total_price'],
	        $params['order_user_code'],
	        $params['order_time'],
	        $params['order_phone'],
	        $params['receive_address'],
	        $params['receive_name'],
	        $params['product_real_price'],
	    ]);

	    return $this->formatResult($result);
	}

	/**
	 * 财务类事务运算引擎 
	 * 
	 * name:pro_finance_engine
	 *
	 * 业务逻辑
	 *  1.定义临时表，存储业务的配置参数，即业务需要执行哪些存储过程
	 *  2.获取需要执行的存储过程，并根据权重排序
	 *  3.执行上一部生成的存储过程
	 *
	 * 参数
	 *  IN `param_business_code` int 			//执行的业务模块名称
	 *  IN `param_user_code` int 				//交易用户编号
	 *  IN `param_transaction_amount` float 	//交易金额
	 *  IN `param_operation_user_code`			//操作人编号
	 * @Author   zzk
	 * @DateTime 2018-02-21T13:37:38+0800
	 */
	public function proFinanceEngine($params){

	    $result = Db::query("call pro_finance_engine(?,?,?,?,?)",[
	        $params['param_business_code'],
	        $params['param_user_code'],
	        isset($params['param_counterparty'])?$params['param_counterparty']:'',
	        $params['param_transaction_amount'],
	        $params['param_operation_user_code'],
	    ]);

	    return $this->formatResult($result);
	}


	public function deleteAllbounsTemp(){
		$result=Db::query("TRUNCATE trya_finance_bonustemp",[
	    ]);
	    return  true;
	}


	/**
	 * 计算推荐奖
	 * 
	 * name:pro_bonus_calculation_tjj
	 *
	 * 正确返回true，否则返回false
	 *
	 * 参数
	 * @Author   zcz
	 * @DateTime 2018-03-07T10:37:38+0800
	 *
	 */
	public function proBonusCalculationTjj($deadline_time){

	    $result = Db::query("call pro_bonus_calculation_tjj(?)",[
	    	$deadline_time,
	    ]);
	    $len = count($result);
	    if (is_array($result[$len-1][0])&&$result[$len-1][0]['pro_err'] == 0) {//返回正确
	    	return true;
	    }
	    return  false;
	}




	/**
	 * 计算销售奖
	 * 
	 * name:pro_bonus_calculation_xsj
	 *
	 * 正确返回true，否则返回false
	 *
	 * 参数
	 * @Author   zcz
	 * @DateTime 2018-03-07T10:37:38+0800
	 *
	 */
	public function proBonusCalculationXsj($deadline_time){

	    $result = Db::query("call pro_bonus_calculation_xsj(?)",[
	    	$deadline_time,
	    ]);
	    $len = count($result);
	    if (is_array($result[$len-1][0])&&$result[$len-1][0]['pro_err'] == 0) {//返回正确
	    	return true;
	    }
	    return  false;
	}


	/**
	 * 计算管理奖
	 * 
	 * name:pro_bonus_calculation_xsj
	 *
	 * 正确返回true，否则返回false
	 *
	 * 参数
	 * @Author   zcz
	 * @DateTime 2018-03-07T10:37:38+0800
	 *
	 */
	public function proBonusCalculationGlj($deadline_time){

	    $result = Db::query("call pro_bonus_calculation_glj(?)",[
	    	$deadline_time,
	    ]);
	    $len = count($result);
	    if (is_array($result[$len-1][0])&&$result[$len-1][0]['pro_err'] == 0) {//返回正确
	    	return true;
	    }
	    return  false;
	}



    /**
	 * 获取重消奖参数 
	 * 
	 * name:pro_bonus_cxj_getadate
	 *
	 * 重消奖参数
	 *  1.user_code(用户编号)
	 *  2.manage_user_code(安置人编号)
	 *  3.price(重复消费金额)
	 * 正确返回数组，否则返回null
	 *
	 * 参数
	 * @Author   zcz
	 * @DateTime 2018-03-07T10:37:38+0800
	 *
	 */
	public function proBonusCxjGetDate($deadline_time){

	    $result = Db::query("call pro_bonus_cxj_getdate(?)",[
	    	$deadline_time,
	    ]);
	    $len = count($result);
	    if (is_array($result[$len-1][0])&&$result[$len-1][0]['pro_err'] == 0) {//返回正确
	    	return $result[$len-2];
	    }
	    return null;
	}

	/**
	 * 计算服务奖
	 * 
	 * name:pro_bonus_calculation_fwj
	 *
	 * 正确返回true，否则返回false
	 *
	 * 参数
	 * @Author   zcz
	 * @DateTime 2018-03-07T10:37:38+0800
	 *
	 */
	public function proBonusCalculationFwj($deadline_time){
		$result = Db::query("call pro_bonus_calculation_fwj(?)",[
	    	$deadline_time,
	    ]);
	    $len = count($result);
	    if (is_array($result[$len-1][0])&&$result[$len-1][0]['pro_err'] == 0) {//返回正确
	    	return true;
	    }
	    return  false;
	}



    /**
	 * 获取见点奖参数 
	 * 
	 * name:pro_bonus_jdj_getadate
	 *
	 * 重消奖参数
	 *  1.user_code(用户编号)
	 *  2.manage_user_code(安置人编号)
	 *  3.price(重复消费金额)
	 * 正确返回数组，否则返回null
	 *
	 * 参数
	 * @Author   zcz
	 * @DateTime 2018-03-07T10:37:38+0800
	 *
	 */
	public function proBonusJdjGetDate($deadline_time){

	    $result = Db::query("call pro_bonus_jdj_getdate(?)",[
	    	$deadline_time,
	    ]);
	    $len = count($result);
	    if ($len==3&&is_array($result[$len-1][0])&&$result[$len-1][0]['pro_err'] == 0) {//返回正确
	    	return $result[$len-2];
	    }
	    return [];
	}


	 /**
	 * 获取奖金派发
	 * 
	 * name:pro_bonus_out
	 *
	 * 重消奖参数
	 *  1.$type：0推荐奖,1销售奖,2管理奖,3重消奖
	 *  2.$operation_user_code 操作人编号
	 * 正确返回true，否则返回false
	 *
	 * 参数
	 * @Author   zcz
	 * @DateTime 2018-03-07T10:37:38+0800
	 *
	 */
	public function proBonusOut($type,$operation_user_code){

	    $result = Db::query("call pro_bonus_out(?,?)",[
	    	$type,
	    	$operation_user_code,
	    ]);
	    $len = count($result);
	    if (is_array($result[$len-1][0])&&$result[$len-1][0]['pro_err'] == 0) {//返回正确
	    	return true;
	    }
	    return false;
	}

	 /**
	 * 货币转换
	 * 
	 * name:pro_finance_personal_change
	 *
	 * 
	 *  param_change_type：0:现金币兑换购物积分,1:奖金兑换购物积分,2:奖金兑换现金
	 *
	 * 参数
	 * @Author   zcz
	 * @DateTime 2018-03-07T10:37:38+0800
	 *
	 */
    public function proFinancePersonalChange($params)
    {

        $result = Db::query("call pro_finance_personal_change(?,?,?,?)", [
            $params['param_user_code'],
	        $params['param_transaction_amount'],
            $params['param_change_type'],
	        $params['param_operation_user_code'],
        ]);
        return $this->formatResult($result);
    }
}

