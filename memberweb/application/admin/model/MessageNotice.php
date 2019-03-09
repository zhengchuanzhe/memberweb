<?php

namespace app\admin\model;

use think\Model;
use traits\model\SoftDelete;

class MessageNotice extends Model
{
    // 表名
    protected $name = 'message_notice';

    // 开启自动写入时间戳字段
    protected $autoWriteTimestamp = 'int';

    // 定义时间戳字段名
    protected $createTime = 'create_time';
    protected $updateTime = 'update_time';
    
    // 软删除
    use SoftDelete;
    protected $deleteTime = 'delete_time';
    protected $type=["delete_time"=>"datetime:Y-m-d ..."];

    // 追加属性
    protected $append = [
        'create_time_text'
    ];


    public function getCreateTimeTextAttr($value, $data)
    {
        $value = $value ? $value : $data['create_time'];
        return is_numeric($value) ? date("Y-m-d H:i:s", $value) : $value;
    }

    protected function setCreateTimeAttr($value)
    {
        return $value && !is_numeric($value) ? strtotime($value) : $value;
    }


}
