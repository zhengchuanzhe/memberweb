<?php

namespace app\admin\controller\personal;

use app\common\controller\Backend;
use app\admin\model\AuthGroup;

use think\Controller;
use think\Request;

/**
 * 我的首页
 *
 * @icon fa fa-circle-o
 */
class Home extends Backend
{
    
    public function _initialize()
    {
        parent::_initialize();

    }
    
    /**
     * 查看
     */
    public function index()
    {
        //获取通知列表（最新的5条）
        $noticeList = model('MessageNotice')
                    ->order('create_time','desc')
                    ->limit(5)
                    ->select();

        //页面绑定
        $this->view->assign('noticeList', $noticeList);
        //会员角色
        $result = collection(AuthGroup::where('id', 'in', $this->auth->getChildrenGroupIds(true))->select())->toArray();
        $groupdata = [];
        foreach ($result as $k => $v)
        {
            $groupdata[$v['id']] = $v['name'];
        }
        $group_name='';
        $grouplist = $this->auth->getGroups($this->auth->getUserInfo()['id']);
        foreach ($grouplist as $k => $v)
        {
            $group_name=$group_name.$groupdata[$v['group_id']].' ';
        }
        $this->view->assign("group_name", $group_name);
        //会员等级
        $gradeInfo= model('Grade')
                ->where(array('grade_code'=>$this->auth->getUserInfo()['grade_code']))
                ->field("grade_code,grade_name")
                ->find();
        $this->view->assign("grade_name", $gradeInfo['grade_name']);

        return $this->view->fetch();
    }

}
