<?php

namespace app\admin\model;

use think\Model;

class ProductOrderform extends Model
{
    // 表名
    protected $name = 'product_orderform';
    
    // 自动写入时间戳字段
    protected $autoWriteTimestamp = false;

    // 定义时间戳字段名
    protected $createTime = false;
    protected $updateTime = false;
    
    // 追加属性
    protected $append = [
        'order_state_text'
    ];
    

    
    public function getOrderStateList()
    {
        return ['1' => __('Order_state 1'),'2' => __('Order_state 2'),'3' => __('Order_state 3'),'4' => __('Order_state 4'),'5' => __('Order_state 5')];
    }     


    public function getOrderStateTextAttr($value, $data)
    {        
        $value = $value ? $value : $data['order_state'];
        $list = $this->getOrderStateList();
        return isset($list[$value]) ? $list[$value] : '';
    }




}
