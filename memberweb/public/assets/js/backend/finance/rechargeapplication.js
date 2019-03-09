define(['jquery', 'bootstrap', 'backend', 'table', 'form'], function ($, undefined, Backend, Table, Form) {

    var Controller = {
        index: function () {
            // 初始化表格参数配置
            Table.api.init({
                extend: {
                    index_url: 'finance/rechargeapplication/index',
                    add_url: 'finance/rechargeapplication/add',
                    del_url: 'finance/rechargeapplication/del',
                    multi_url: 'finance/rechargeapplication/multi',
                    table: 'rechargeapplication',
                }
            });

            var table = $("#table");

            // 初始化表格
            table.bootstrapTable({
                url: $.fn.bootstrapTable.defaults.extend.index_url,
                pk: 'id',
                sortName: 'id',
                columns: [
                    [
                        {checkbox: true},
                        {field: 'id', title: __('Id')},
                        {field: 'application_user_code', title: __('Application_user_code')},
                        {field: 'application_amount', title: __('Application_amount')},
                        {field: 'after_balance', title: __('After_balance')},
                        {field: 'application_time', title: __('Application_time')},
                        {field: 'state_text', title: __('State'), operate:false, 
                            formatter: function(value, row, index) {
                                // 若状态为“待处理”，则红色显示
                                if (row.state == '0') {
                                    return '<font color="#FF0000">'+row.state_text+'</font>';
                                } else {
                                    return row.state_text;
                                }
                            }
                        },
                        {field: 'hand_user_code', title: __('Hand_user_code')},
                        {field: 'mark', title: __('Mark')},
                        {field: 'operate', title: __('Operate'), table: table, 
                            buttons: [
                                {name: 'detail', title: '详情', icon: 'fa fa-list', classname: 'btn btn-dialog btn-xs btn-primary', 
                                    url: 'finance/rechargeapplication/details'},
                                {name: 'del', icon: 'fa fa-trash', classname: 'btn btn-xs btn-danger btn-delone'}
                            ], 
                            events: Table.api.events.operate, formatter: Table.api.formatter.buttons
                        }
                    ]
                ]
            });

            // 为表格绑定事件
            Table.api.bindevent(table);
        },
        add: function () {
            // 初始化
            Controller.api.calculate_after_balance();

            $(document).ready(function(){
                // 申请金额更改事件
                // 自动更改申请后余额
                $("#c-application_amount").on("change",function(){
                    Controller.api.calculate_after_balance(); // 更改申请后的余额
                });
            });
            Controller.api.bindevent();
        },
        edit: function () {
            Controller.api.bindevent();
        },
        api: {
            bindevent: function () {
                Form.api.bindevent($("form[role=form]"));
            },

            // 计算申请后余额
            calculate_after_balance: function () {
                $("#c-after_balance").val(parseFloat($("#c-application_amount").val())+parseFloat($("#c-before_balance").val()));
            }
        }
    };
    return Controller;
});