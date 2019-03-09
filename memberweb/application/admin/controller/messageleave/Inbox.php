<?php

namespace app\admin\controller\messageleave;

use app\common\controller\Backend;
use think\Controller;
use think\Request;

/**
 * 留言信息表
 *
 * @icon fa fa-circle-o
 */
class Inbox extends Backend
{
    
    /**
     * MessageLeave模型对象
     */
    protected $model = null;

    public function _initialize()
    {
        parent::_initialize();
        $this->model = model('MessageLeave');

    }
    
    /**
     * 默认生成的控制器所继承的父类中有index/add/edit/del/multi五个方法
     * 因此在当前控制器中可不用编写增删改查的代码,如果需要自己控制这部分逻辑
     * 需要将application/admin/library/traits/Backend.php中对应的方法复制到当前控制器,然后进行修改
     */
     
      /**
     * 查看
     */
    public function index()
    {
        //设置过滤方法
        $this->request->filter(['strip_tags']);
        if ($this->request->isAjax())
        {
            //如果发送的来源是Selectpage，则转发到Selectpage
            if ($this->request->request('pkey_name'))
            {
                return $this->selectpage();
            }
            list($where, $sort, $order, $offset, $limit) = $this->buildparams();
            $userInfo=$this->auth->getUserInfo();
            $total = $this->model
                    ->where(array('receive_user_code'=>$userInfo["user_code"],"receive_is_delete"=>false))
                    ->where($where)
                    ->order($sort, $order)
                    ->count();

            $list = $this->model
                    ->where(array('receive_user_code'=>$userInfo["user_code"],"receive_is_delete"=>false))
                    ->where($where)
                    ->order($sort, $order)
                    ->limit($offset, $limit)
                    ->select();

            $result = array("total" => $total, "rows" => $list);

            return json($result);
        }
        return $this->view->fetch();
    }

    /**
     * 删除
     */
    public function del($ids = "")
    {
        if ($ids)
        {
            $pk = $this->model->getPk();
            $adminIds = $this->getDataLimitAdminIds();
            if (is_array($adminIds))
            {
                $count = $this->model->where($this->dataLimitField, 'in', $adminIds);
            }
            $list = $this->model->where($pk, 'in', $ids)->select();
            $count = 0;
            foreach ($list as $k => $v)
            {
                $v["receive_is_delete"]=true;
                $count+=$v->save();
            }
            if ($count)
            {
                $this->success();
            }
            else
            {
                $this->error(__('No rows were deleted'));
            }
        }
        $this->error(__('Parameter %s can not be empty', 'ids'));
    }


    /**
     * 详情
     */
    public function details($ids = NULL)
    {
        $row = $this->model->get($ids);
        if (!$row)
            $this->error(__('No Results were found'));
        if (!$row["is_read"]) {
            //未读
            $row["is_read"]=true;
            $result=$row->save();
            if (!$result) {
                 $this->error("系统出错");
            }
            //刷新侧面栏
        }
        else{
            //已读讲id置为0
            $row["id"]=0;
        }
        $this->view->assign("row", $row);
        return $this->view->fetch();
    }

}
