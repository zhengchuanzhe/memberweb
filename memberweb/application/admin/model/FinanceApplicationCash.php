<?php

namespace app\admin\model;

use think\Model;

class FinanceApplicationCash extends Model
{
    // 表名
    protected $name = 'finance_application_cash';
    
    // 自动写入时间戳字段
    protected $autoWriteTimestamp = false;

    // 定义时间戳字段名
    protected $createTime = false;
    protected $updateTime = false;
    
    // 追加属性
    protected $append = [
        'state_text',
        'application_type_name'
    ];
    

    
    public function getStateList()
    {
        return ['0' => __('State 0'),'1' => __('State 1')];
    }     


    public function getStateTextAttr($value, $data)
    {        
        $value = $value ? $value : $data['state'];
        $list = $this->getStateList();
        return isset($list[$value]) ? $list[$value] : '';
    }

    public function getApplicationTypeNameList()
    {
        return ['xj' => __('Application_type xj'),'jj' => __('Application_type jj')];
    }     


    public function getApplicationTypeNameAttr($value, $data)
    {        
        $value = $value ? $value : $data['application_type'];
        $list = $this->getApplicationTypeNameList();
        return isset($list[$value]) ? $list[$value] : '';
    }


}
