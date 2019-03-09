define(['jquery', 'bootstrap', 'backend', 'table', 'form'], function ($, undefined, Backend, Table, Form) {

    var Controller = {
        index: function () {
            // 初始化表格参数配置
            Table.api.init({
                extend: {
                    index_url: 'finance/transactionalflow/index',
                    table: 'transactionalflow',
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
                        {field: 'id', title: __('Id')},
                        {field: 'user_code', title: __('User_code')},
                        {field: 'business_name', title: __('Business_code')},
                        {field: 'transaction_amount', title: __('Transaction_amount'),},
                        {field: 'trading_time', title: __('Trading_time'),},
                        {field: 'operation_user_code', title: __('Operation_user_code')},
                        {field: 'mark', title: __('Mark'),},
                        {field: 'operate', title: __('Operate'), table: table,
                            buttons: [
                                {
                                    name: 'detail',
                                    title: '详情', icon: 'fa fa-list',
                                    classname: 'btn btn-xs btn-primary btn-dialog',
                                    url: 'finance/transactionalflow/details'
                                },
                            ],
                            events: Table.api.events.operate,
                            formatter: Table.api.formatter.buttons
                        }
                    ]
                ]
            });

            // 为表格绑定事件
            Table.api.bindevent(table);
        },
        api: {
            bindevent: function () {
                Form.api.bindevent($("form[role=form]"));
            }
        }
    };
    return Controller;
});