<?php
namespace app\admin\controller\user;

use app\admin\model\AuthGroup;
use app\admin\model\AuthGroupAccess;
use app\common\controller\Backend;
use app\admin\library\Engine;
use fast\Random;
use fast\Tree;

/**
* 会员注册
*/
class Virtualsingle extends Backend
{
    protected $model = null;

    public function _initialize()
    {
        parent::_initialize();
        $this->model = model('User');

        $this->assignconfig("admin", ['id' => $this->auth->id]);
    }

    /**
     * 会员注册
     * @Author   zzk
     * @DateTime 2018-02-03T10:34:21+0800
     * @return   [type]                   [description]
     */
    public function index()
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
                // 验证会员安置人是否是第一次推荐
                $managercount=$this->model
                    ->field('user_area')
                    ->where(['referee_user_code'=>$params['referee_user_code']])
                    ->count();
                if ($managercount<=0) {//第一次推荐
                    if ($params['user_area']=='B') {
                        $this->error(__('It must be placed in the A area'));//必须放在A区
                    }
                }else{
                    $user_area_count=$this->model
                        ->field('user_area')
                        ->where(['manage_user_code'=>$params['manage_user_code'],'user_area'=>$params['user_area']])
                        ->count();
                    if ($user_area_count>0) {
                        $this->error(__('Area is full.Choose another'));//该区域已满
                    }
                }

                //判断会员信息是否已经注册
                $user_count=$this->model
                    ->field('user_area')
                    ->where('bank_account='.$params['bank_account'].' or id_card='.$params['id_card'].' or phone_number='.$params['phone_number'])
                    ->count();
                if ($user_count>0) {
                    $this->error(__('The user has been registered'));//该用户已经注册
                }

                $params['manage_user_code']=$this->findManageCodeArea($params);//设置安置人code
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

                //添加会员角色权限
                $dataset = [];
                $dataset[] = ['uid' => $this->model->id, 'group_id' => 4];
                model('AuthGroupAccess')->saveAll($dataset);
                $this->success();
            }
            $this->error();
        }
        // 获取当前会员的code
        $code=$this->auth->getUserInfo()['user_code'];

        // 获取当前会员的名称
        $name=$this->auth->getUserInfo()['user_name'];

        // 取出银行列表
        $bankList = model('Bank')
                ->field("bank_code,bank_name as name")
                ->select();
        // 取出会员等级列表
        $gradeList = model('Grade')
                ->field("grade_code,grade_name as name")
                ->where("grade_code !='lv4'")
                ->select();

        // 页面绑定
        $this->view->assign('bankList', $bankList); 
        $this->view->assign('gradeList', $gradeList); 
        $this->view->assign('code', $code); // 默认使用自己的编号
        $this->view->assign('name', $name); // 默认使用自己的编号
        $this->view->assign("userAreaList", $this->model->getUserAreaList()); // A、B区
        $this->view->assign("user_code", Random::numeric(7)); // 随机生成新编号
        return $this->view->fetch();
    }   


    /**
     *
     *查找安置节点下的左区或右区最跟节点孩子
     *
     */
    private function findManageCodeArea($params){
        //找寻code最下节点
        $user_list= $this->model->select();
        $user_array=[];
        foreach ($user_list as $k => $v) {
            $user_array[$v['manage_user_code']][$v['user_area']]=$v['user_code'];
        }
        $manage_user_code=$params['manage_user_code'];
        $user_area=$params['user_area'];
        if ($user_area=='B') {
            if (isset($manage_user_code[$manage_user_code]['B'])){
                //B区存在节点
                $manage_user_code=$manage_user_code[$manage_user_code]['B'];
            }
            else{
                //B区不存在节点
                return  $manage_user_code;
            }
        }
        while (isset($user_array[$manage_user_code]['A'])) {
            $manage_user_code=$user_array[$manage_user_code]['A'];
        }
        return $manage_user_code;
    }


    /**
     * 获取随机会员编号
     * @Author   zzk
     * @DateTime 2018-02-03T19:08:38+0800
     * @return   [type]                   [description]
     */
    public function getRandomCode() {
        $code = Random::numeric(7);
        while ($this->model->where('user_code',$code)->find()!=null)
        {
            $code = Random::numeric(7);
        }
        $this->success('', null, $code);
    }

    /**
     * 验证新编号是否存在
     * @Author   zzk
     * @DateTime 2018-02-03T19:12:28+0800
     * @return   boolean                  [description]
     */
    public function isExistCode(){
        if ($this->request->isPost()) {
            $params = $this->request->post();
            $code = is_null($params['code']) ? -1 : $params['code'];
            // 验证编号是否可用
            if ($code != -1) {
                if ($this->model->where('user_code',$code)->find()==null) {
                    $this->success(__('The code is availability'));
                } else {
                    $this->error(__('The code is exist'));
                }
            } else {
                $this->error(__('The param is error'));
            }
        }
    }

    /**
     * 根据编号获取会员名
     * @Author   zzk
     * @DateTime 2018-02-03T19:12:28+0800
     * @return   boolean                  [description]
     */
    public function getUserNameByCode(){
        if ($this->request->isPost()) {
            $params = $this->request->post();
            $code = is_null($params['code']) ? -1 : $params['code'];
            // 验证编号是否可用
            if ($code != -1) {
                $user = $this->model->field('user_name')->where('user_code',$code)->find();
                if ($user!=null) {
                    $this->success($user['user_name']);
                } else {
                    $this->error(__('The code is inexistent'));
                }
            } else {
                $this->error(__('The param is error'));
            }
        }
    }

    /**
     * 根据编号验证推荐人
     * @Author   zcz
     * @DateTime 2018-04-13T19:12:28+0800
     * @return   boolean                  [description]
     */
    public function checkRefereeUserCode(){
        if ($this->request->isPost()) {
            $params = $this->request->post();
            $code = is_null($params['code']) ? -1 : $params['code'];
            // 验证编号是否可用
            if ($code != -1) {
                $user = $this->model->field('user_name')->where('user_code',$code)->find();
                $count=$this->model->where(['referee_user_code'=>$code])->count();
                if ($user!=null) {
                    $this->success('', null, array('user_name'=>$user['user_name'],'count'=>$count));
                } else {
                    $this->error(__('The code is inexistent'));
                }
            } else {
                $this->error(__('The param is error'));
            }
        }
    }

    /**
     * 根据编号验证安置人
     * @Author   zcz
     * @DateTime 2018-04-13T19:12:28+0800
     * @return   boolean                  [description]
     */
    public function checkManageUserCode(){
        if ($this->request->isPost()) {
            $params = $this->request->post();
            $code = is_null($params['code']) ? -1 : $params['code'];
            // 验证编号是否可用
            if ($code != -1) {
                $user = $this->model->field('user_name')->where('user_code',$code)->find();
                $users = $this->model->field(['user_name','user_area'])->where('manage_user_code',$code)->select();
                if (count($users)<2) {
                    if (count($users)<=0) {
                        $this->success('', null, array('user_name'=>$user['user_name'],'message'=>'A,B区可安置'));
                    }
                    $this->success('', null, array('user_name'=>$user['user_name'],'message'=>$users[0]['user_area'].'区已安置'));
                } else {
                    $this->success('', null, array('user_name'=>$user['user_name'],'message'=>"该人员安置区已满"));
                }
            } else {
                $this->error(__('The param is error'));
            }
        }
    }
    
}

?>