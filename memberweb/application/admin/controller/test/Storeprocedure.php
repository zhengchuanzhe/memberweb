<?php

namespace app\admin\controller\test;

use app\admin\library\Engine;
use think\Controller;

/**
 * 存储过程测试类
 */
class Storeprocedure extends Controller
{

    /**
     * 财务引擎
     * @Author   zzk
     * @DateTime 2018-02-21T14:17:39+0800
     * @return   [type]                   [description]
     */
    public function proFinanceEngine()
    {
        $params['param_business_code'] = Engine::BUSCODE_MEMBER_RECHARGE;
        $params['param_user_code'] =;
        $params['param_transaction_amount'] = $params['application_amount'];
        $params['param_operation_user_code'] = $this->code;
        $result = model('StoreProcedure')->proFinanceEngine($params);
        var_dump($result);
    }

}
