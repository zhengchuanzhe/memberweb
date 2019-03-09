<?php

namespace app\admin\model;

use think\Model;

class Admin extends Model
{
    // 表名
    protected $name = 'admin';
    
    // 自动写入时间戳字段
    protected $autoWriteTimestamp = false;

    // 定义时间戳字段名
    protected $createTime = false;
    protected $updateTime = false;
    
    // 追加属性
    protected $append = [
        'login_time_text',
        'create_time_text',
        'update_time_text',
        'user_area_text'
    ];
    

    
    public function getUserAreaList()
    {
        return ['A' => __('User_area a'),'B' => __('User_area b')];
    }     


    public function getLoginTimeTextAttr($value, $data)
    {
        $value = $value ? $value : $data['login_time'];
        return is_numeric($value) ? date("Y-m-d H:i:s", $value) : $value;
    }


    public function getCreateTimeTextAttr($value, $data)
    {
        $value = $value ? $value : $data['create_time'];
        return is_numeric($value) ? date("Y-m-d H:i:s", $value) : $value;
    }


    public function getUpdateTimeTextAttr($value, $data)
    {
        $value = $value ? $value : $data['update_time'];
        return is_numeric($value) ? date("Y-m-d H:i:s", $value) : $value;
    }


    public function getUserAreaTextAttr($value, $data)
    {        
        $value = $value ? $value : $data['user_area'];
        $list = $this->getUserAreaList();
        return isset($list[$value]) ? $list[$value] : '';
    }

    protected function setLoginTimeAttr($value)
    {
        return $value && !is_numeric($value) ? strtotime($value) : $value;
    }

    protected function setCreateTimeAttr($value)
    {
        return $value && !is_numeric($value) ? strtotime($value) : $value;
    }

    protected function setUpdateTimeAttr($value)
    {
        return $value && !is_numeric($value) ? strtotime($value) : $value;
    }
    public function refereeTree($data,$code,&$list)
    {
        foreach ($data as $k => $v){
            $ids[] = $v['user_code'];
        }
        $total = count($ids)+1;
        foreach ($data as $k => $v){
            $referee_user_code[] = $v['referee_user_code'];
        }
        for($i = 0;$i<$total;$i++) {
            foreach ($data as $k => $v) {
                if ($v['referee_user_code'] == $code) {
                    $arr = $v;
                    array_push($list, $arr);
                    $code = $arr['user_code'];
                    unset($data[$k]);
                    unset($referee_user_code[$k]);
                }
                $referee = array("$code");
                $info=array_intersect($referee_user_code,$referee);
                if(empty($info)){
                    $code = $v['referee_user_code'];
                }
            }
        }
        //并加入业绩字段
        $num = -1;
        foreach ($list as $k => $v) {
            $num++;
            $list[$num]['transaction_amount']= '0';
        }
    }
    public function refereeTransaction(&$data){
        $data = array_reverse($data);
        $user = model('FinanceHistoryTransactionalflow')
            ->field(['transaction_amount','operation_user_code'])
            ->where('business_code','hybd')
            ->select();
        //获取会员自身操作的业绩金额
        foreach($data as $k => $v){
            foreach($user as $ke => $vo){
                if($v['user_code']==$vo['operation_user_code']){
                    $v['transaction_amount'] += $vo['transaction_amount'];
                }
            }
        }
        $referee_data = $data;
        foreach($data as $kk => $vv){
            foreach($referee_data as $kke => $vvo){
                if($vv['user_code'] == $vvo['referee_user_code']){
                    $vv['transaction_amount'] += $vvo['transaction_amount'];
                }
            }
        }
        array_multisort($data,SORT_ASC);
    }

}
