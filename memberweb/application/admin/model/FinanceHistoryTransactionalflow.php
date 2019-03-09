<?php

namespace app\admin\model;

use think\Db;
use think\Model;

/**
 * 存储过程模块
 */
class FinanceHistoryTransactionalflow extends Model
{
    protected $model = 'finance_history_transactionalflow';
    // 追加属性
    protected $append = [
        'business_code_text',
    ];
    public function getBusinessCodeList()
    {
        return ['hycz' => __('hycz'),
            'hytx_xj' => __('hytx_xj'),
            'hytx_jj' => __('hytx_jj'),
            'hyzclth' => __('hyzclth'),
            'hycfxflth' => __('hycfxflth'),
            'jjpf' => __('jjpf'),
            'hyzz' => __('hyzz')];
    }
    public function getBusinessCodeTextAttr($value, $data)
    {
        $value = $value ? $value : $data['business_code'];
        $list = $this->getBusinessCodeList();
        return isset($list[$value]) ? $list[$value] : '';
    }
}
