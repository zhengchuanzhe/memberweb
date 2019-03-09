<?php

namespace app\admin\controller\product;

use app\common\controller\Backend;

use think\Controller;
use think\Request;

/**
 * 产品表
 *
 * @icon fa fa-circle-o
 */
class Productinfo extends Backend
{

    /**
     * ProductProductinfo模型对象
     */
    protected $model = null;

    public function _initialize()
    {
        parent::_initialize();
        $this->model = model('ProductProductinfo');
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
            //如果发送的来源是Selectpage，则转发到Selectpage
            if ($this->request->request('pkey_name'))
            {
                return $this->selectpage();
            }
            list($where, $sort, $order, $offset, $limit) = $this->buildparams();
            $total = $this->model
                ->where($where)
                ->order($sort, $order)
                ->count();

            $list = $this->model
                ->where($where)
                ->order($sort, $order)
                ->limit($offset, $limit)
                ->select();

            // 显示类别名称
            $list = addtion($list, 'product_type_id');

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
                /*
                 * 已经弃用,如果为了兼容老版可取消注释
                  foreach ($params as $k => &$v)
                  {
                  $v = is_array($v) ? implode(',', $v) : $v;
                  }
                 */
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
        // 取出分类列表
        $typeList = model('ProductType')
            ->field("id,name")
            ->select();

        // 页面绑定
        $this->view->assign('typeList', $typeList);
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
                /*
                 * 已经弃用,如果为了兼容老版可取消注释
                  foreach ($params as $k => &$v)
                  {
                  $v = is_array($v) ? implode(',', $v) : $v;
                  }
                 */
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
        // 取出分类列表
        $typeList = model('ProductType')
            ->field("id,name")
            ->select();

        // 页面绑定
        $this->view->assign('typeList', $typeList);
        $this->view->assign("row", $row);
        return $this->view->fetch();
    }


    public function detail($ids = NULL)
    {
        $row = $this->model->get($ids);
        if (!$row)
            $this->error(__('No Results were found'));
        // 取出分类列表
        $typeList = model('ProductType')
            ->field("id,name")
            ->select();

        // 页面绑定
        $this->view->assign('typeList', $typeList);
        $this->view->assign("row", $row);
        return $this->view->fetch();
    }
}
