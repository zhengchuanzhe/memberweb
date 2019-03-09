<?php

namespace app\admin\controller\user;

use app\common\controller\Backend;

use think\Controller;
use think\Request;

/**
 * 升级申请表
 *
 * @icon fa fa-circle-o
 */
class Upgrademanage extends Backend
{
    
    /**
     * MessageUpgradeapplication模型对象
     */
    protected $model = null;

    public function _initialize()
    {
        parent::_initialize();
        $this->model = model('MessageUpgradeapplication');
        $this->view->assign("stateList", $this->model->getStateList());
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
                    ->where(array('hand_is_delete'=>false))
                    ->order($sort, $order)
                    ->count();

            $list = $this->model
                    ->where($where)
                    ->where(array('hand_is_delete'=>false))
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
                $v['hand_is_delete']=true;
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

    /*
     * 拒绝会员升级申请
     */
    public function agree()
    {
        if ($this->request->isAjax())
        {
            $id = $this->request->post("id");
            $hand_mark = $this->request->post("hand_mark");
            if ($id)
            {
                date_default_timezone_set('prc');
                $application_info=$this->model->get($id);
                $application_info['state']=1;//申请状态设置为同意
                $application_info['hand_user_code']=$this->auth->getUserInfo()['user_code'];//操作人员ID
                $application_info['hand_time']=date('y-m-d H:i:s',time());//处理时间
                $application_info['hand_mark']=$hand_mark?$hand_mark:'';//处理人员备注
                //更新用户信息
                $usermodel=model('Admin')->where(array('user_code'=>$application_info['application_user_code']))->find();
                $usermodel['grade_code']=$application_info['new_grade_code'];//更新等级
                $usermodel['update_time']=date(time());
                //保存修改
                $application_info->save();
                $usermodel->save();
                $this->success('', null, 'success');
            }
            $this->error(__('Parameter %s can not be empty', 'id'));
        }
         
    }    

    /*
     * 拒绝会员升级申请
     */
    public function refuse()
    {
        if ($this->request->isAjax())
        {
            $id = $this->request->post("id");
            $hand_mark = $this->request->post("hand_mark");
            if ($id)
            {
                $application_info=$this->model->get($id);
                $application_info['state']=2;//申请状态设置为拒绝
                $application_info['hand_user_code']=$this->auth->getUserInfo()['user_code'];//操作人员ID
                $application_info['hand_time']=date('y-m-d H:i:s',time());//处理时间
                $application_info['hand_mark']=$hand_mark?$hand_mark:'';//处理人员备注
                //保存修改
                $application_info->save();
                $this->success('', null, 'success');
            }
            $this->error(__('Parameter %s can not be empty', 'id'));
        }
    }

}
