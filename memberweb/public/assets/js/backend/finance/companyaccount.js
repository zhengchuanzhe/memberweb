define(['jquery', 'bootstrap', 'backend', 'table', 'form'], function ($, undefined, Backend, Table, Form) {

    var Controller = {
        index: function () {
            // 初始化表格参数配置
            Table.api.init({
                extend: {
                    index_url: 'finance/companyaccount/index',
                    table: 'companyaccount',
                }
            });

            var table = $("#table");

            // 初始化表格
            table.bootstrapTable({
                url: $.fn.bootstrapTable.defaults.extend.index_url,
                escape: false,
                pk: 'id',
                sortName: 'account_number',
                sortOrder:'asc',
                search:false,
                pagination: false,
                commonSearch: false,
                columns: [
                    [

                        {field: 'account_number', title: __('Account_number')},
                        {field: 'account_name', title: __('Account_name')},
                        {field: 'balance', title: __('Account_balance')},
                    ]
                ]
            });

            // 为表格绑定事件
            Table.api.bindevent(table);
        },

        api: {
            bindevent: function () {
            }
        }
    };
    return Controller;
});