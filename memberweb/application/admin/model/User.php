<?php

namespace app\admin\model;

use think\Model;
use traits\model\SoftDelete;

class User extends Model
{
    // 表名
    protected $name = 'admin';
    
    // 自动写入时间戳字段
    protected $autoWriteTimestamp = 'int';

    // 定义时间戳字段名
    protected $createTime = 'create_time';
    protected $updateTime = 'update_time';
 

    // 字段类型或者格式转换
    protected $type = ['delete_time'=>'datetime:Y-m-d H:i:s'];

    // 软删除
    use SoftDelete;
    protected $deleteTime = 'delete_time';

    
    public function getUserAreaList()
    {
        return ['A' => __('User_area A'),'B' => __('User_area B')];
    }   

}
