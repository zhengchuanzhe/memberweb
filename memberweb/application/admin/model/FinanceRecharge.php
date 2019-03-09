<?php

namespace app\admin\model;

use think\Model;

class FinanceRecharge extends Model
{
    // 表名
    protected $name = 'finance_application_recharge';
    
    // 自动写入时间戳字段
    protected $autoWriteTimestamp = false;

    // 定义时间戳字段名
    protected $createTime = false;
    protected $updateTime = false;
    
    // 追加属性
    protected $append = [
        'state_text'
    ];
    

    
    public function getStateList()
    {
        return ['0' => __('State 0'),'1' => __('State 1'),'2' => __('State 2')];
    }     


    public function getStateTextAttr($value, $data)
    {        
        $value = $value ? $value : $data['state'];
        $list = $this->getStateList();
        return isset($list[$value]) ? $list[$value] : '';
    }




}
