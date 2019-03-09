define(['jquery', 'bootstrap', 'backend', 'table', 'form'], function ($, undefined, Backend, Table, Form) {

    var Controller = {
        index: function () {
            // 初始化表格参数配置
            Table.api.init({
                extend: {
                    index_url: 'finance/personalmanagetransaction/index',
                    table: 'finance_history_personalperformance',
                }
            });

            var table = $("#table");

            // 初始化表格
            table.bootstrapTable({
                url: $.fn.bootstrapTable.defaults.extend.index_url,
                pk: 'id',
                sortName: 'id',
                showToggle:false,
                showColumns:false,
                showExport:false,
                search:false,
                operate:false,
                columns: [
                    [
                        {checkbox: true},
                        {field: 'id', title: __('Id'),operate:false},
                        {field: 'user_code', title: __('User_code'),operate:false},
                        {field: 'user_name', title: __('User_name')},
                        {field: 'grade_name', title: __('User_grade')},
                        {field: 'now_day_amount', title: __('Now_day_amount')},
                        {field: 'calculate_amount', title: __('Calculate_amount')},
                        {field: 'surplus_amount', title: __('Surplus_amount')},
                        {field: 'cal_time', title: __('Cal_time')},
                        {field: 'accounting_time', title: __('Accounting_time')},
                    ]
                ]
            });

            // 为表格绑定事件
            Table.api.bindevent(table);
        },
        add: function () {
            Controller.api.bindevent();
        },
        edit: function () {
            Controller.api.bindevent();
        },
        api: {
            bindevent: function () {
                Form.api.bindevent($("form[role=form]"));
            }
        }
    };
    return Controller;
});