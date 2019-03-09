<?php
namespace app\admin\controller\user;

use app\admin\model\AuthGroup;
use app\admin\model\AuthGroupAccess;
use app\common\controller\Backend;
use fast\Random;
use fast\Tree;

/**
 * 会员注册
 */
class Referee extends Backend
{
    /**
     * Manage模型对象
     */
    protected $model = null;

    public function _initialize()
    {
        parent::_initialize();
        $this->model = model('User');
        // 获取当前用户code
        $this->code=$this->auth->getUserInfo()['user_code'];
    }


    /**
     * 查看
     */
    public function index()
    {
        if ($this->request->isAjax())
        {
            //如果发送的来源是Selectpage，则转发到Selectpage
            if ($this->request->request('pkey_name'))
            {
                return $this->selectpage();
            }
            $filter = $this->request->get("filter", '');
            $filter = json_decode($filter, TRUE);
            if ($filter==null||count($filter)<=0) {
                //首次
                $param_user_code=$this->code;
            }
            else{
                $param_user_code=$filter['user_code'];
            }
            $list=[];
            $father = $this->model
                ->where(['user_code'=>$param_user_code])
                ->find();
            if ($father) {
                //存在
                $total = $this->model
                    ->where(['referee_user_code'=>$father['user_code']])
                    ->count();
                $total=$total+1;
                $list = $this->model
                    ->field(['id','user_code','user_name','referee_user_code','grade_code'])
                    ->where(['referee_user_code'=>$father['user_code']])
                    ->select();
                array_unshift($list , $father);
            }



            //获取会员等级
            $adminGradeList=model("Grade")
                ->select();
            $adminGradeName=[];
            foreach ($adminGradeList as $k => $v) {
                $adminGradeName[$v['grade_code']]=$v['grade_name'];
            }
            foreach ($list as $k => &$v)
            {
                $v['grade_name']=$adminGradeName[$v['grade_code']];
            }
            $result = array("total" => $total, "rows" => $list);

            return json($result);
        }
        return $this->view->fetch();
    }
}

?>