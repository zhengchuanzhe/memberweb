<?php

namespace app\admin\controller\auth;

use app\admin\model\AuthGroup;
use app\admin\model\AuthGroupAccess;
use app\common\controller\Backend;
use fast\Random;
use fast\Tree;
use think\Model;
use think\session;

/**
 * 管理员管理
 *
 * @icon fa fa-users
 * @remark 一个管理员可以有多个角色组,左侧的菜单根据管理员所拥有的权限进行生成
 */
class Admin extends Backend
{

    protected $model = null;
    protected $childrenGroupIds = [];
    protected $childrenAdminIds = [];
    public function _initialize()
    {
        parent::_initialize();
        $this->model = model('Admin');

        $this->childrenAdminIds = $this->auth->getChildrenAdminIds(true);
        $this->childrenGroupIds = $this->auth->getChildrenGroupIds(true);

        $groupList = collection(AuthGroup::where('id', 'in', $this->childrenGroupIds)->select())->toArray();

        Tree::instance()->init($groupList);
        $groupdata = [];
        if ($this->auth->isSuperAdmin())
        {
            $result = Tree::instance()->getTreeList(Tree::instance()->getTreeArray(0));
            foreach ($result as $k => $v)
            {
                $groupdata[$v['id']] = $v['name'];
            }
        }
        else
        {
            $result = [];
            $groups = $this->auth->getGroups();
            foreach ($groups as $m => $n)
            {
                $childlist = Tree::instance()->getTreeList(Tree::instance()->getTreeArray($n['id']));
                $temp = [];
                foreach ($childlist as $k => $v)
                {
                    $temp[$v['id']] = $v['name'];
                }
                $result[__($n['name'])] = $temp;
            }
            $groupdata = $result;
        }

        // 获取当前用户code
        $this->code=$this->auth->getUserInfo()['user_code'];

        $this->view->assign('groupdata', $groupdata);
        $this->assignconfig("admin", ['id' => $this->auth->id]);
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
            $childrenGroupIds = $this->childrenGroupIds;
            $groupName = AuthGroup::where('id', 'in', $childrenGroupIds)
                    ->column('id,name');
            $authGroupList = AuthGroupAccess::where('group_id', 'in', $childrenGroupIds)
                    ->field('uid,group_id')
                    ->select();

            $adminGroupName = [];
            foreach ($authGroupList as $k => $v)
            {
                if (isset($groupName[$v['group_id']]))
                    $adminGroupName[$v['uid']][$v['group_id']] = $groupName[$v['group_id']];
            }
            $groups = $this->auth->getGroups();
            foreach ($groups as $m => $n)
            {
                $adminGroupName[$this->auth->id][$n['id']] = $n['name'];
            }
            list($where, $sort, $order, $offset, $limit) = $this->buildparams();
            $total = $this->model
                    ->where($where)
                    ->where('id', 'in', $this->childrenAdminIds)
                    ->order($sort, $order)
                    ->count();

            $list = $this->model
                    ->where($where)
                    ->where('id', 'in', $this->childrenAdminIds)
                    ->field(['password', 'salt', 'token', 'second_pass_word', 'second_salt'], true)
                    ->order($sort, $order)
                    ->limit($offset, $limit)
                    ->select();
            foreach ($list as $k => &$v)
            {
                $groups = isset($adminGroupName[$v['id']]) ? $adminGroupName[$v['id']] : [];
                $v['groups'] = implode(',', array_keys($groups));
                $v['groups_text'] = implode(',', array_values($groups));
            }
            unset($v);

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
        $gradeList = model('Grade')
            ->field("grade_code,grade_name as name")
            ->select();
        $this->view->assign('gradeList', $gradeList);
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
                // 验证安置人编号是否存在
                if (!$this->model->where('user_code',$params['manage_user_code'])->find()) {
                    $this->error(__('Manage user code is error'));
                }
                // 验证会员安置人是否存在闲置区域
                $managed = $this->model
                            ->field('user_area')
                            ->where('manage_user_code',$params['manage_user_code'])
                            ->select();
                if (count($managed)>=2) { // 两区域均已满
                    $this->error(__('Areas are full'));
                } elseif (count($managed)==1) {
                    if ($managed[0]['user_area'] == $params['user_area']) { // 该区域已满
                        $this->error($managed[0]['user_area'].__('Area is full.Choose another'));
                    }
                }
                
                $params['salt'] = Random::alnum();
                $params['second_salt'] = Random::alnum();
                $params['password'] = md5(md5($params['password']) . $params['salt']);
                $params['second_pass_word']=md5(md5($params['second_pass_word']) . $params['second_salt']);
                $params['avatar'] = '/assets/img/avatar.png'; //设置新管理员默认头像。
                $result = $this->model->validate('Admin.add')->save($params);
                if ($result === false)
                {
                    $this->error($this->model->getError());
                }
                $group = $this->request->post("group/a");

                //过滤不允许的组别,避免越权
                $group = array_intersect($this->childrenGroupIds, $group);
                $dataset = [];
                foreach ($group as $value)
                {
                    $dataset[] = ['uid' => $this->model->id, 'group_id' => $value];
                }
                model('AuthGroupAccess')->saveAll($dataset);
                $this->success();
            }
            $this->error();
        }

        // 取出银行列表
        $bankList = model('Bank')
                ->field("bank_code,bank_name as name")
                ->select();
        // 取出会员等级列表
        $gradeList = model('Grade')
                ->field("grade_code,grade_name as name")
                ->select();

        // 页面绑定
        $this->view->assign('bankList', $bankList); 
        $this->view->assign('gradeList', $gradeList); 
        $this->view->assign('code', $this->code); // 默认使用自己的编号
        $this->view->assign("userAreaList", $this->model->getUserAreaList()); // A、B区
        $this->view->assign("user_code", Random::numeric(7)); // 随机生成新编号
        return $this->view->fetch();
    }

    /**
     * 编辑
     */
    public function edit($ids = NULL)
    {
        $row = $this->model->get(['id' => $ids]);
        if (!$row)
            $this->error(__('No Results were found'));
        if ($this->request->isPost())
        {
            $params = $this->request->post("row/a");
            if ($params)
            {
                //这里需要针对user_code和email做唯一验证
                $adminValidate = \think\Loader::validate('Admin');
                //若未更改如下信息，则不做唯一验证
              
                $result = $row->validate('Admin.edit')->save($params);
                if ($result === false)
                {
                    $this->error($row->getError());
                }
                $this->success();
            }
            $this->error();
        }
        $grouplist = $this->auth->getGroups($row['id']);
        $groupids = [];
        foreach ($grouplist as $k => $v)
        {
            $groupids[] = $v['id'];
        }

        // 取出银行列表
        $bankList = model('Bank')
                ->field("bank_code,bank_name as name")
                ->select();
        // 取出会员等级列表
        $gradeList = model('Grade')
                ->field("grade_code,grade_name as name")
                ->select();

        // 页面绑定
        $this->view->assign("row", $row);
        $this->view->assign("groupids", $groupids);
        $this->view->assign('bankList', $bankList); 
        $this->view->assign('gradeList', $gradeList); 
        return $this->view->fetch();
    }
    //密码重置
    public function passwordReset(){
            // 一级密码不为空，则修改一级密码盐及一级密码
            $password['salt'] = Random::alnum();
            $password['password'] = md5(md5('123456abc') . $password['salt']);
            $password['second_salt'] = Random::alnum();
            $password['second_pass_word'] = md5(md5('123456abc') . $password['second_salt']);
            $user = $this->request->post()['code'];
            $this->model->save($password,function($query)use($user){
                $query->where('user_code',$user);
            });
            $this -> success(__('Reset success'));
        }

    /**
     * 删除
     */
    public function del($ids = "")
    {
        if ($ids)
        {
            // 避免越权删除管理员
            $childrenGroupIds = $this->childrenGroupIds;
            $adminList = $this->model->where('id', 'in', $ids)->where('id', 'in', function($query) use($childrenGroupIds) {
                        $query->name('auth_group_access')->where('group_id', 'in', $childrenGroupIds)->field('uid');
                    })->select();
            if ($adminList)
            {
                $deleteIds = [];
                foreach ($adminList as $k => $v)
                {
                    $deleteIds[] = $v->id;
                }
                $deleteIds = array_diff($deleteIds, [$this->auth->id]);
                if ($deleteIds)
                {
                    $this->model->destroy($deleteIds);
                    model('AuthGroupAccess')->where('uid', 'in', $deleteIds)->delete();
                    $this->success();
                }
            }
        }
        $this->error();
    }
    public function selectUser(){
            $code = $this->request->post()['code'];
            $user = $this->model->where('user_code',$code)->find();
            if($user != NULL) {
                $user = $user['user_code'];
                $grade = $this->model
                    ->alias('a')
                    ->join('trya_config_grade b', 'a.grade_code=b.grade_code')
                    ->field('a.*,b.grade_code,b.grade_name')
                    ->where('user_code', $user)
                    ->find()['grade_name'];
                $balances = model('FinancePersonalaccount')
                    ->field('type,balance')
                    ->where(['user_code' => $user])
                    ->select();
                foreach ($balances as $balance) {
                    switch ($balance['type']) {
                        case 0:
                            $cash = $balance['balance'];
                            break;
                        case 1:
                            $bonus = $balance['balance'];
                            break;
                        case 2:
                            $shopping = $balance['balance'];
                            break;
                        case 3:
                            $register = $balance['balance'];
                            break;
                        default:
                            break;
                    }
                }
                session('this_user',$user);
                $this->success("", null, array('cash' => $cash, 'bonus' => $bonus, 'shopping' => $shopping, 'register' => $register, 'grade' => $grade));
            }else{
                $this->error(__('User code not found'));
            }
    }
    public function confirmChange(){
        $params = $this->request->post();
        if(empty(Session::get('this_user'))) {
            $this->error(__('User code error'));
        }else{
            if (($params['code'] != Session::get('this_user'))) {
                $this->error(__('User code error'));
            } else {
                if ($params[0] < 0||$params[1] < 0||$params[2] < 0||$params[3] < 0) {
                    $this->error(__('Cash error'));
                } else {
                    $type = 0;
                    for($i=0;$i<=3;$i++){
                        $cash['balance'] = $params[$type];
                        model('FinancePersonalaccount')->save($cash, function ($query)use($type) {
                            $query->where('type', $type);
                            $query->where('user_code', Session::get('this_user'));
                        });
                        $type++;
                    }
                    Session::delete('this_user');
                    $this -> success(__('Change success'));
                }
            }
        }
    }
    //会员升级
    public function upgradeUser(){
        $user = $this->request->post()['code'];
        if(empty(Session::get('this_user'))) {
            $this->error(__('User code error'));
        }else{
            if (($user != Session::get('this_user'))) {
                $this->error(__('User code error'));
            }else {
                $grade['grade_code'] = 'lv4';
                $this->model->save($grade, function ($query) {
                    $query->where('user_code', Session::get('this_user'));
                });
                Session::delete('this_user');
                $this->success(__('Change success'));
            }
        }
    }
    /**
     * 批量更新
     * @internal
     */

    /**
     * 批量更新
     * @internal
     */
    public function multi($ids = "")
    {
        // 管理员禁止批量操作
        $this->error();
    }

    /**
     * 下拉搜索
     */
    protected function selectpage()
    {
        $this->dataLimit = 'auth';
        $this->dataLimitField = 'id';
        return parent::selectpage();
    }

}
