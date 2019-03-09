<?php

namespace app\admin\controller\user;

use app\common\controller\Backend;

use think\Controller;
use think\Request;

/**
 * 会员升级申请管理
 *
 * @icon fa fa-circle-o
 */
class Upgradeapplication extends Backend
{
    
    /**
     * MessageUpgradeapplication模型对象
     */
    protected $model = null;
    protected $userInfo=null;

    public function _initialize()
    {
        parent::_initialize();
        $this->model = model('MessageUpgradeapplication');
        $this->view->assign("stateList", $this->model->getStateList());
        
        $this->userInfo=$this->auth->getUserInfo();

        // 取出会员等级列表
        $gradeList = model('Grade')
                ->field("grade_code,grade_name as name")
                ->select();
        $this->view->assign("gradeList", $gradeList);
    }
    
    /**
     * 默认生成的控制器所继承的父类中有index/add/edit/del/multi五个方法
     * 因此在当前控制器中可不用编写增删改查的代码,如果需要自己控制这部分逻辑
     * 需要将application/admin/library/traits/Backend.php中对应的方法复制到当前控制器,然后进行修改
     */
    
    /**
     * 查看,只显示自己的申请信息
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
                    ->where($where)
                    ->where(array('application_user_code'=>$this->userInfo['user_code'],'application_is_delete'=>false))
                    ->order($sort, $order)
                    ->count();

            $list = $this->model
                    ->where($where)
                    ->where(array('application_user_code'=>$this->userInfo['user_code'],'application_is_delete'=>false))
                    ->order($sort, $order)
                    ->limit($offset, $limit)
                    ->select();

            $list=addtion($list,[
                        [
                            'field'    => 'old_grade_code',
                            'display'  => 'old_grade_name',
                            'primary'  => 'grade_code',
                            'column'   => 'grade_name',
                            'model'    => '\app\admin\model\Grade',
                            'name'     => 'Grade',
                            'table'    => 'config_grade'
                        ],
                        [
                            'field'    => 'new_grade_code',
                            'display'  => 'new_grade_name',
                            'primary'  => 'grade_code',
                            'column'   => 'grade_name',
                            'model'    => '\app\admin\model\Grade',
                            'name'     => 'Grade',
                            'table'    => 'config_grade'
                        ]
                ]);
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
                    $result = $this->model->allowField(true)->save($params);
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
                //管理员删除
                $v['application_is_delete']=true;
                $count += $v->save();
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
    public function details($ids = "")
    {
        $row = $this->model->get($ids);
        if (!$row)
            $this->error(__('No Results were found'));
        $adminIds = $this->getDataLimitAdminIds();
        if (is_array($adminIds))
        {
            if (!in_array($row[$this->dataLimitField], $adminIds))
            {
                $this->error(__('You have no permission'));
            }
        }
        $this->view->assign("row", $row);
        return $this->view->fetch();
    }

}
