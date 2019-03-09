define(['jquery', 'bootstrap', 'backend', 'table', 'form'], function ($, undefined, Backend, Table, Form) {

    var Controller = {
        index: function () {
            // 初始化表格参数配置
            Table.api.init({
                extend: {
                    index_url: 'finance/historybonus/index',
                    add_url: 'finance/historybonus/add',
                    edit_url: 'finance/historybonus/edit',
                    del_url: 'finance/historybonus/del',
                    multi_url: 'finance/historybonus/multi',
                    table: 'finance_history_bonus',
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
                        {field: 'transaction_date', title: __('Transaction_date')},
                        {field: 'serial_number', title: __('Serial_number')},
                        {field: 'user_code', title: __('User_code')},
                        {field: 'bonus_type', title: __('Bonus_type')},
                        {field: 'trade_direction', title: __('Trade_direction')},
                        {field: 'plan_money', title: __('Plan_money')},
                        {field: 'reality_money', title: __('Reality_money')},
                        {field: 'adjust_user_code', title: __('Adjust_user_code')},
                        {field: 'bookkeeping_user_code', title: __('Bookkeeping_user_code')},
                        {field: 'entry_time', title: __('Entry_time')},
                        {field: 'operate', title: __('Operate'), table: table, events: Table.api.events.operate, formatter: Table.api.formatter.operate}
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