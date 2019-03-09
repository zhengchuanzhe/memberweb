define(['jquery', 'bootstrap', 'backend', 'table', 'form'], function ($, undefined, Backend, Table, Form) {

    var Controller = {
        index: function () {
            // 初始化表格参数配置
            Table.api.init({
                extend: {
                    index_url: 'finance/cashapplication/index',
                    add_url: 'finance/cashapplication/add',
                    del_url: 'finance/cashapplication/del',
                    table: 'finance_application_cash',
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
                        {field: 'application_amount', title: __('Application_amount')},
                        {field: 'poundage', title: __('Poundage')},
                        {field: 'after_balance', title: __('After_balance')},
                        {field: 'application_time', title: __('Application_time')},
                        {field: 'state_text', title: __('State'), operate:false},
                        {field: 'hand_time', title: __('Hand_time')},
                        {field: 'operate', title: __('Operate'), table: table,
                            buttons: [{name: 'detail', 
                                title: '详情', icon: 'fa fa-list', classname: 'btn btn-xs btn-primary btn-dialog', 
                                url: 'finance/cashapplication/details'},{name: 'del', icon: 'fa fa-trash', classname: 'btn btn-xs btn-danger btn-delone'}], 
                                events: Table.api.events.operate, formatter:  Table.api.formatter.buttons
                        }
                    ]
                ]
            });

            // 为表格绑定事件
            Table.api.bindevent(table);
        },
        add: function () {
            var rate_temp=document.getElementById("c-rate").innerHTML.replace('%','')/100;//手续费率
            Controller.api.bindevent();
            //申请额度更改自动更改手续费
            $("#c-application_amount").on("input",function(){
                    var num=document.getElementById("c-application_amount").value*rate_temp;
                    document.getElementById("c-poundage").value=num.toFixed(2);
            });
        },
        edit: function () {
            Controller.api.bindevent();
        },
        api: {
            bindevent: function () {
                Form.api.bindevent($("form[role=form]"));
            },
        }
    };
    return Controller;
});