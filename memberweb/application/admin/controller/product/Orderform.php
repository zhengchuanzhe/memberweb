<?php

namespace app\admin\controller\product;

use app\common\controller\Backend;

use app\admin\library\Engine;
use think\Controller;
use think\Request;

/**
 * 订单管理
 *
 * @icon fa fa-circle-o
 */
class Orderform extends Backend
{

    /**
     * ProductOrderform模型对象
     */
    protected $model = null;

    public function _initialize()
    {
        parent::_initialize();
        $this->model = model('ProductOrderform');
        $this->view->assign("orderStateList", $this->model->getOrderStateList());
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

            // 获取管理员未删除的订单

            $total = model('ProductProductinfo')
                ->where($where)
                ->where(['manage_is_delete'=>false])
                ->alias('a')
                ->join('trya_product_orderform b','a.id= b.product_productinfo_id')
                ->where('product_type_id','2')
                ->order($sort, $order)
                ->count();

            $list = model('ProductProductinfo')
                ->where($where)
                ->where(['manage_is_delete'=>false])
                ->alias('a')
                ->join('trya_product_orderform b','a.id= b.product_productinfo_id')
                ->where('product_type_id','2')
                ->order($sort, $order)
                ->limit($offset, $limit)
                ->select();

            // 显示产品名称
            $list = addtion($list, 'product_productinfo_id');

            $result = array("total" => $total, "rows" => $list);

            return json($result);
        }
        return $this->view->fetch();
    }

    /**
     * 填写发货人信息，获取数据
     */
    public function deal($ids = NULL)
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
                    $orderInfo=$this->model->get($params['id']);
                    if ($orderInfo['order_state']==2) {
                        $orderInfo['send_user']=$params['send_user'];
                        $orderInfo['send_time']=$params['send_time'];
                        $orderInfo['order_state']=3;
                        $result=$orderInfo->save();
                        if ($result !== false)
                        {
                            $this->success();
                        }
                        else
                        {
                            $this->error($row->getError());
                        }
                    }
                    else
                    {
                        $this->error(__('You have no permission'));
                    }


                }
                catch (\think\exception\PDOException $e)
                {
                    $this->error($e->getMessage());
                }
            }
            $this->error(__('Parameter %s can not be empty', ''));
        }
        // 取出产品列表
        $productList = model('ProductProductinfo')
            ->field("id,name")
            ->select();
        // 页面绑定
        $this->view->assign('productList', $productList);
        $this->view->assign("row", $row);
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
                $v["manage_is_delete"]=true;
                $count+=$v->save();

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
     *确认/取消/完成订单
    */
    public function orderstate()
    {
        $id = $this->request->post("id");
        $state = $this->request->post("state");
        if ($id&&$state) {
            try{
                $orderInfo=$this->model->get($id);
                if ($orderInfo['order_state']==1&&($state==2||$state==5)) {
                    //是待确认状态
                    $orderInfo['order_state']=$state;
                    if ($state==5) {
                        //重消类订单作废
                        $params['param_business_code'] = Engine::BUSCODE_CXDDZF;//注册订单作废
                        $params['param_user_code'] =$orderInfo['order_user_code'];
                        $params['param_transaction_amount'] = $orderInfo['order_total_price'];
                        $params['param_operation_user_code']=$this->auth->getUserInfo()['user_code'];
                        $result = model('StoreProcedure')->proFinanceEngine($params);
                        if ($result['code'] != 1)
                        {
                            //订单作废失败   
                            $this->error($result['msg']);
                        }
                        //条件标签
                        $orderInfo['mark']=$this->request->post("mark");
                    }
                    $orderInfo->save();
                    $this->success('', null, true);
                }
                else if ($orderInfo['order_state']==3&&$state==4) {
                    //确定完成
                    $orderInfo['order_state']=$state;
                    $orderInfo->save();
                    $this->success('', null, true);
                }
                else{
                    //否则报错
                    $this->error(__('You have no permission'));
                }
            }
            catch (\think\exception\PDOException $e)
            {
                $this->error($e->getMessage());
            }

        }
        $this->error(__('Parameter %s can not be empty', 'id/state'));
    }

}
