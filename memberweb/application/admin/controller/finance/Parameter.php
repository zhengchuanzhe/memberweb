<?php

namespace app\admin\controller\finance;

use app\common\controller\Backend;

use think\Controller;
use think\Request;

/**
 * 参数管理
 *
 * @icon fa fa-circle-o
 */
class Parameter extends Backend
{
    
    /**
     * FinanceParameter模型对象
     */
    protected $model = null;

    public function _initialize()
    {
        parent::_initialize();
        $this->model = model('FinanceParameter');

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
                    ->where($where)
                    ->order('group_name asc,param_name asc')
                    ->count();

            $list = $this->model
                    ->where($where)
                    ->order('group_name asc,param_name asc')
                    ->limit($offset, $limit)
                    ->select();
            foreach ($list as $key => $value) {
                $value['param_value']=floatval($value['param_value']);
            }
            $result = array("total" => $total, "rows" => $list);

            return json($result);
        }
        return $this->view->fetch();
    }



    /**
     * 编辑
     */
    public function edit($ids = NULL)
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
        if ($this->request->isPost())
        {
            $params = $this->request->post("row/a");
            if ($params)
            {
                try
                {
                    //是否采用模型验证
                    if ($this->modelValidate)
                    {
                        $name = basename(str_replace('\\', '/', get_class($this->model)));
                        $validate = is_bool($this->modelValidate) ? ($this->modelSceneValidate ? $name . '.edit' : true) : $this->modelValidate;
                        $row->validate($validate);
                    }
                    
                    $result = $row->allowField(true)->save($params);
                    if ($result !== false)
                    {
                        $this->success();
                    }
                    else
                    {
                        $this->error($row->getError());
                    }
                }
                catch (\think\exception\PDOException $e)
                {
                    $this->error($e->getMessage());
                }
            }
            $this->error(__('Parameter %s can not be empty', ''));
        }
        $row['param_value']=floatval($row['param_value']);
        $this->view->assign("row", $row);
        return $this->view->fetch();
    }


}
