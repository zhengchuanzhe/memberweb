define(['jquery', 'bootstrap', 'backend', 'table', 'form'], function ($, undefined, Backend, Table, Form) {

    var Controller = {
        index: function () {
            // 初始化表格参数配置
            Table.api.init({
                extend: {
                    index_url: 'product/personregisterform/index',
                    add_url: 'product/personregisterform/add',
                    del_url: 'product/personregisterform/del',
                    table: 'product_orderform',
                }
            });

            var table = $("#table");

            // 初始化表格
            table.bootstrapTable({
                url: $.fn.bootstrapTable.defaults.extend.index_url,
                pk: 'id',
                sortName: 'b.id',
                columns: [
                    [
                        {checkbox: true},
                        {field: 'id', title: __('Id')},
                        {field: 'product_productinfo_name', title: __('Productinfo'), operate: false, formatter: Table.api.formatter.label},
                        {field: 'order_quantity', title: __('Order_quantity')},
                        {field: 'order_user_code', title: __('Order_user_code')},
                        {field: 'order_time', title: __('Order_time')},
                        {field: 'order_phone', title: __('Order_phone')},
                        {field: 'receive_address', title: __('Receive_address')},
                        {field: 'receive_name', title: __('Receive_name')},
                        {field: 'product_real_price', title: __('Product_real_price')},
                        {field: 'order_total_price', title: __('Order_total_price')},
                        {field: 'send_user', title: __('Send_user')},
                        {field: 'send_time', title: __('Send_time')},
                        {field: 'order_state_text', title: __('Order_state'), operate:false},
                        {field: 'operate', title: __('Operate'), table: table,
                            buttons: [{
                                name: 'detail',
                                title: '详情',
                                icon: 'fa fa-list',
                                classname: 'btn btn-dialog btn-xs btn-primary',
                                url: 'product/personregisterform/detail'
                            }],
                            events: Table.api.events.operate,
                            formatter: Table.api.formatter.operate
                        }
                    ]
                ]
            });

            // 为表格绑定事件
            Table.api.bindevent(table);
        },
        add: function () {
            // 初始化
            Controller.api.calculate_total_price();

            $(document).ready(function(){
                // 产品选项卡更改事件
                // 自动更改价格及总价
                $("#product").on("change",function(){
                    $.ajax({
                        url: "product/personregisterform/getRealpriceById",
                        type: 'post',
                        dataType: 'json',
                        data: {id: $(this).val()},
                        success: function (ret) {
                            if (ret.hasOwnProperty("code")) {
                                var data = ret.hasOwnProperty("data") && ret.data != "" ? ret.data : "";
                                if (ret.code === 1) {
                                    // 返回成功事件
                                    $("#c-product_real_price").val(ret.data); // 更改价格
                                    Controller.api.calculate_total_price(); // 更改总价
                                } else {
                                    Backend.api.toastr.error(ret.data);
                                }
                            }

                        }, error: function (e) {
                            Backend.api.toastr.error(e.message);
                        }
                    });
                });

                // 数量更改事件
                // 验证库存是否充足，自动更改总价
                $("#c-order_quantity").on("input",function(){
                     Controller.api.calculate_total_price(); // 更改总价
                });
            });
            Controller.api.bindevent();
        },
        api: {
            bindevent: function () {
                Form.api.bindevent($("form[role=form]"));
            },

            // 计算总价
            calculate_total_price: function () {
                $("#c-order_total_price").val($("#c-product_real_price").val()*$("#c-order_quantity").val());// 订单总额
            }
        }
    };
    return Controller;
});