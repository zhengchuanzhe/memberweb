<?php

namespace app\admin\controller\messageleave;

use app\common\controller\Backend;

use think\Controller;
use think\Request;
use fast\Tree;
use app\admin\model\AuthGroup;

/**
 * 发件箱
 * @icon fa fa-circle-o
 */
class Outbox extends Backend
{
    
    /**
     * MessageLeave模型对象
     */
    protected $model = null;
    protected $userInfo=null;

    public function _initialize()
    {
        parent::_initialize();
        $this->model = model('MessageLeave');
        $this->userInfo=$this->auth->getUserInfo();
        $reciev_user=[];
        $model=model('admin');
        if (!$this->userInfo['id']==1) {
            //管理员
            $reciev_user=$model->select();
        }
        else if($this->userInfo['grade_code']==='lv4'){
            //服务中心
             $reciev_user=$model->where(array('service_centre_code'=>$this->userInfo['user_code']))->select();
        }
        else{
            //一般用户
            $reciev_user=$model->where('service_centre_code is NULL or grade_code=1')->select();
        }
        $receive_user_data = [];
        foreach ($reciev_user as $key => $value) {
            $receive_user_data[$value['user_code']]=$value['user_name'].'('.$value['user_code'].')';
        }
        $this->view->assign('receive_user_data', $receive_user_data);
    }
     
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
          
            $total = $this->model
                    ->where(array('send_user_code'=>$this->userInfo["user_code"],"send_is_delete"=>false))
                    ->where($where)
                    ->order($sort, $order)
                    ->count();

            $list = $this->model
                    ->where(array('send_user_code'=>$this->userInfo["user_code"],"send_is_delete"=>false))
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
     * 添加
     */
    public function add()
    {
        if ($this->request->isPost())
        {
            $params = $this->request->post("row/a");
            $group = $this->request->post("receive_user/a");
            if ($params)
            {
                if ($this->dataLimit)
                {
                    $params[$this->dataLimitField] = $this->auth->id;
                }
                try
                {
                    //是否采用模型验证
                    if ($this->modelValidate)
                    {
                        $name = basename(str_replace('\\', '/', get_class($this->model)));
                        $validate = is_bool($this->modelValidate) ? ($this->modelSceneValidate ? $name . '.add' : true) : $this->modelValidate;
                        $this->model->validate($validate);
                    }
                    $result=null;
                    $dataList[]=null;
                    foreach ($group as $key => $receive_code) {
                        $params['receive_user_code']=$receive_code;
                        $dataList[] = $params;
                    }
                    $this->model->allowField(true)->saveAll($dataList);
                    if ($result !== false)
                    {
                        $this->success();
                    }
                    else
                    {
                        $this->error($this->model->getError());
                    }
                }
                catch (\think\exception\PDOException $e)
                {
                    $this->error($e->getMessage());
                }
            }
            $this->error(__('Parameter %s can not be empty', ''));
        }
        $this->view->assign("userInfo", $this->userInfo);
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
                $v["send_is_delete"]=true;
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
        $this->view->assign("row", $row);
        return $this->view->fetch();
    }

}
