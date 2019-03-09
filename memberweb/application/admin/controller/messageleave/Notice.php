<?php

namespace app\admin\controller\messageleave;

use app\common\controller\Backend;

use think\Controller;
use think\Request;

/**
 * 通知管理
 *
 * @icon fa fa-circle-o
 */
class Notice extends Backend
{
    
    /**
     * MessageNotice模型对象
     */
    protected $model = null;

    public function _initialize()
    {
        parent::_initialize();
        $this->model = model('MessageNotice');
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
                    $params['user_code']=$this->auth->getUserInfo()['user_code'];
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

        //获取当前会员的code
        $code=$this->auth->getUserInfo()['user_code'];

        // 页面绑定
        $this->view->assign('code', $code); // 默认使用自己的编号

        return $this->view->fetch();
    }

    /**
     * 详情
     * @Author   zzk
     * @DateTime 2018-02-11T18:42:14+0800
     * @param    [type]                   $ids [description]
     * @return   [type]                        [description]
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
