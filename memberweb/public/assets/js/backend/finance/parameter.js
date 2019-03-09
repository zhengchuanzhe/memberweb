define(['jquery', 'bootstrap', 'backend', 'table', 'form'], function ($, undefined, Backend, Table, Form) {

    var Controller = {
        index: function () {
            // 初始化表格参数配置
            Table.api.init({
                extend: {
                    index_url: 'finance/parameter/index',
                    edit_url: 'finance/parameter/edit',
                    multi_url: 'finance/parameter/multi',
                    table: 'finance_parameter',
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
                        {field: 'mark', title: __('Param_name')},
                        {field: 'param_value', title: __('Param_value')},
                        {field: 'update_time', title: __('Update_time'), formatter: Table.api.formatter.datetime},
                        {field: 'operate', title: __('Operate'), table: table,
                            buttons: [{name: 'edit', icon: 'fa fa-pencil', classname: 'btn btn-xs btn-success btn-editone', url: 'finance/parameter/edit'}],
                                events: Table.api.events.operate, formatter: Table.api.formatter.buttons}
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