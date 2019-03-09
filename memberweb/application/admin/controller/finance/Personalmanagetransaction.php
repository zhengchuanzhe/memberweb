<?php

namespace app\admin\controller\finance;

use app\common\controller\Backend;

use think\Controller;
use think\Request;

/**
 * 会员销售业绩计算表
 *
 * @icon fa fa-circle-o
 */
class Personalmanagetransaction extends Backend
{
    
    /**
     * FinanceHistoryPersonalperformance模型对象
     */
    protected $model = null;
    protected $relationSearch = true;
    public function _initialize()
    {
        parent::_initialize();
        $this->model = model('FinanceHistoryPersonalperformance');

    }
    
    /**
     * 默认生成的控制器所继承的父类中有index/add/edit/del/multi五个方法
     * 因此在当前控制器中可不用编写增删改查的代码,如果需要自己控制这部分逻辑
     * 需要将application/admin/library/traits/Backend.php中对应的方法复制到当前控制器,然后进行修改
     */
    public function index()
    {
        //设置过滤方法
        $this->request->filter(['strip_tags']);
        if ($this->request->isAjax())
        {
            $code = $this->auth->getUserInfo()['user_code'];
            //如果发送的来源是Selectpage，则转发到Selectpage
            if ($this->request->request('pkey_name'))
            {
                return $this->selectpage();
            }
            list($where, $sort, $order, $offset, $limit) = $this->buildparams();
            $total = $this->model
                ->alias('a')
                ->join('trya_admin b','a.user_code = b.user_code')
                ->field('a.*,b.grade_code,b.user_name')
                ->where($where)
                ->where("type","0")
                ->where('a.user_code',$code)
                ->order($sort, $order)
                ->count();

            $list = $this->model
                ->alias('a')
                ->join('trya_admin b','a.user_code = b.user_code')
                ->field('a.*,b.grade_code,b.user_name')
                ->where($where)
                ->where("type","0")
                ->where('a.user_code',$code)
                ->order($sort, $order)
                ->limit($offset, $limit)
                ->select();
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
