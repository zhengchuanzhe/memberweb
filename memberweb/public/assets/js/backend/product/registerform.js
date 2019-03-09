define(['jquery', 'bootstrap', 'backend', 'table', 'form'], function ($, undefined, Backend, Table, Form) {

    var Controller = {
        index: function () {
            // 初始化表格参数配置
            Table.api.init({
                extend: {
                    index_url: 'product/registerform/index',
                    deal_url: 'product/registerform/deal',
                    del_url: 'product/registerform/del',
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
                        {field: 'receive_name', title: __('Receive_name')},
                        {field: 'product_real_price', title: __('Product_real_price')},
                        {field: 'order_total_price', title: __('Order_total_price')},
                        {field: 'send_user', title: __('Send_user')},
                        {field: 'send_time', title: __('Send_time')},
                        {field: 'order_state_text', title: __('Order_state'), operate:false},
                        {field: 'operate', title: __('Operate'), table: table,
                            buttons: [{
                                name: 'deal',
                                title:'订单处理',
                                icon: 'fa fa-cogs',
                                classname: 'btn btn-dialog btn-xs btn-primary',
                                url: 'product/registerform/deal',
                                callback: function (data) {
                                    if (data) {
                                        var dd= document.getElementById('table').tBodies[0];
                                        for (var i =0; i<dd.rows.length; i++) {
                                            if (dd.rows[i].cells[1].textContent==data['id']){
                                                dd.rows[i].cells[12].textContent=data['con'];
                                                break;
                                            };
                                        };
                                    };
                                }
                            }],
                            events: Table.api.events.operate,
                            formatter: Table.api.formatter.operate
                        }
                    ]
                ]
            });

            // 为表格绑定事件
            Table.api.bindevent(table);
            table.off('dbl-click-row.bs.table');
        },
        add: function () {
            Controller.api.bindevent();
        },
        deal: function () {
            Controller.api.bindevent();
            $(document).ready(function(){
                //确认订单
                $("#confirm_order").on("click",function(){
                    Layer.open({
                        title: [
                            '确认订单',
                            'background-color:#8DCE16; color:#fff;margin-top: 0px;'
                        ]
                        , anim: 'up'
                        , content: '<b>订单一旦确认，将无法修改</b>'  + '</br><b>是否确认订单？</b>'
                        , btn: ['确定', '取消']
                        , yes: function () {
                            $.ajax({
                                url: "product/registerform/orderstate",
                                type: 'post',
                                dataType: 'json',
                                data: {id: $("#c-id").val(),state:2},
                                success: function (ret) {
                                    if (ret.code == 1) {
                                        if (ret.data===true) {
                                            Backend.api.toastr.success('清单确认成功');
                                            Fast.api.close({'id':$("#c-id").val(),'con':'确认'});
                                        }
                                    } else {
                                        Backend.api.toastr.error(ret.msg);
                                    }
                                }, error: function (e) {
                                    Backend.api.toastr.error(e.message);
                                    Fast.api.close(null);
                                }
                            });

                        }
                    });
                });

                //作废订单
                $("#void_order").on("click",function(){
                    Layer.open({
                        title: [
                            '作废订单',
                            'background-color:#8DCE16; color:#fff;margin-top: 0px;'
                        ]
                        , anim: 'up'
                        , content: '<b>是否作废订单？</b>' +
                        '<input id="mark" type="text" class="form-control" placeholder="请输入作废原因" >'
                        , btn: ['确定', '取消']
                        , yes: function () {
                            if ($("#mark").val().length==0) {
                                alert('请输入作废原因！');
                                return false;
                            };
                            $.ajax({
                                url: "product/registerform/orderstate",
                                type: 'post',
                                dataType: 'json',
                                data: {id: $("#c-id").val(),state:5,mark:$("#mark").val()},
                                success: function (ret) {
                                    if (ret.code == 1) {
                                        if (ret.data===true) {
                                            Backend.api.toastr.success('清单已作废');
                                            Fast.api.close({'id':$("#c-id").val(),'con':'已作废'});
                                        }else {
                                            Backend.api.toastr.error(ret.msg);
                                        }
                                    } else {
                                        Backend.api.toastr.error(ret.msg);
                                    }
                                }, error: function (e) {
                                    Backend.api.toastr.error(e.message);
                                    Fast.api.close(null);
                                }
                            });
                        }
                    });
                });

                //完成订单
                $("#completion_order").on("click",function(){
                    Layer.open({
                        title: [
                            '订单完成',
                            'background-color:#8DCE16; color:#fff;margin-top: 0px;'
                        ]
                        , anim: 'up'
                        , content: '<b>订单一旦完成，将无法修改</b>'  + '</br><b>是否完成订单？</b>'
                        , btn: ['确定', '取消']
                        , yes: function () {
                            $.ajax({
                                url: "product/registerform/orderstate",
                                type: 'post',
                                dataType: 'json',
                                data: {id: $("#c-id").val(),state:4},
                                success: function (ret) {
                                    if (ret.code == 1) {
                                        if (ret.data===true) {
                                            Backend.api.toastr.success('清单已完成');
                                            Fast.api.close({'id':$("#c-id").val(),'con':'已完成'});
                                        }
                                    } else {
                                        Backend.api.toastr.error(ret.msg);
                                    }
                                }, error: function (e) {
                                    Backend.api.toastr.error(e.message);
                                    Fast.api.close(null);
                                }
                            });
                        }
                    });
                });


            });

        },
        api: {
            bindevent: function () {
                Form.api.bindevent($("form[role=form]"));
            }
        }
    };
    return Controller;
});