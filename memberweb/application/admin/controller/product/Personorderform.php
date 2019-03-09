<?php

namespace app\admin\controller\product;

use app\common\controller\Backend;
use app\admin\controller\common\Secondlogin;
use think\Controller;
use think\Request;

/**
 * 订单管理
 *
 * @icon fa fa-circle-o
 */
class Personorderform extends Backend
{

    /**
     * ProductPersonorderform模型对象
     */
    protected $model = null;

    public function _initialize()
    {
        parent::_initialize();
        $this->model = model('ProductOrderform');
        //获取当前会员的code
        $this->code=$this->auth->getUserInfo()['user_code'];
        $this->view->assign("orderStateList", $this->model->getOrderStateList());
    }

    /**
     * 查看
     */
    public function index()
    {
        // // 二级登陆验证
        // if(!Secondlogin::isSecondLogin()){
        //     $this->view->assign("redirect_url", $this->auth->getRequestUri());
        //     return $this->view->fetch(Secondlogin::getSecondView());
        // }
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

            // 获取该会员的订单，该会员未删除

            $total = model('ProductProductinfo')
                ->where($where)
                ->where(['order_user_code'=>$this->code, 'order_is_delete'=>false])
                ->alias('a')
                ->join('trya_product_orderform b','a.id= b.product_productinfo_id')
                ->where('product_type_id','2')
                ->order($sort, $order)
                ->count();

            $list = model('ProductProductinfo')
                ->where($where)
                ->alias('a')
                ->join('trya_product_orderform b','a.id= b.product_productinfo_id')
                ->where('product_type_id','2')
                ->where(['order_user_code'=>$this->code, 'order_is_delete'=>false])
                ->order($sort, $order)
                ->limit($offset, $limit)
                ->select();

            // 显示产品名称
            $list = addtion($list, 'product_productinfo_id','product_orderform_id');

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
                    // 计算金额是否正确
                    // 取出产品信息
                    $productPrice = model('ProductProductinfo')
                        ->field("real_price")
                        ->where(["id"=>$params["product_productinfo_id"]])
                        ->find();

                    if ($productPrice["real_price"]*$params["order_quantity"]==$params["order_total_price"]) {
                        // 总金额正确
                        //判断余额是否充足
                        //获取现金币当前余额
                        $user_finance=model("FinancePersonalaccount")
                                    ->where(['user_code'=>$this->code,'type'=>0])
                                    ->select();
                        if ($params['order_total_price']>$user_finance[0]['balance']) {
                            $this->error(__('Sorry, your credit is running low'));
                        }

                        // 添加操作
                        $result = model('StoreProcedure')->proOrderAdd($params);
                        if ($result['code'] == 1)
                        {
                            $this->success();
                        }
                        else
                        {
                            $this->error($result['msg']);
                        }
                    } else {
                        $this->error(__('The param is error'));
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
            ->field("id,name,real_price")
            ->where('product_type_id','2')
            ->select();

        // 页面绑定
        $this->view->assign('productList', $productList);
        $this->view->assign('productRealPrice', $productList[0]['real_price']);
        $this->view->assign('code', $this->code);
        return $this->view->fetch();
    }

    /**
     * 根据产品ID获取产品真实价格
     * @Author   zzk
     * @DateTime 2018-02-06T16:19:26+0800
     * @return   [type]                   [description]
     */
    public function getRealpriceById(){
        if ($this->request->isPost()) {
            $params = $this->request->post();
            $product = model('ProductProductinfo')
                ->field("real_price")
                ->where("id",$params['id'])
                ->find();
            // 验证产品是否存在
            if (!is_null($product)) {
                $this->success('', null, $product['real_price']);
            } else {
                $this->error(__('Can achieve the product'));
            }
        }
    }

    /**
     * 根据产品ID获取产品库存
     * @Author   zzk
     * @DateTime 2018-02-06T16:19:26+0800
     * @return   [type]                   [description]
     */
    public function getInventoryById(){
        if ($this->request->isPost()) {
            $params = $this->request->post();
            $product = model('ProductProductinfo')
                ->field("inventory")
                ->where("id",$params['id'])
                ->find();
            // 验证产品是否存在
            if (!is_null($product)) {
                $this->success('', null, $product['inventory']);
            } else {
                $this->error(__('Can achieve the product'));
            }
        }
    }

    /**
     * 根据会员ID获取个人余额
     * @Author   zzk
     * @DateTime 2018-02-06T16:19:26+0800
     * @return   [type]                   [description]
     */
    public function getRemainingSumById(){

    }


    /**
     * 详情
     */
    public function detail($ids = NULL)
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
        $name = model('ProductProductinfo')
            ->field('name')
            ->where('id',$row['product_productinfo_id'])
            ->select()[0]['name'];
        $this->view->assign("name", $name);
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
                $v["order_is_delete"]=true;
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
}
