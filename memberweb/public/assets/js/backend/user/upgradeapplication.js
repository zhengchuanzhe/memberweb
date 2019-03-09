define(['jquery', 'bootstrap', 'backend', 'table', 'form'], function ($, undefined, Backend, Table, Form) {

    var Controller = {
        index: function () {
            // 初始化表格参数配置
            Table.api.init({
                extend: {
                    index_url: 'user/upgradeapplication/index',
                    add_url: 'user/upgradeapplication/add',
                    del_url: 'user/upgradeapplication/del',
                    table: 'message_upgradeapplication',
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
                        {field: 'old_grade_name', title: __('Old_grade_code')},
                        {field: 'new_grade_name', title: __('New_grade_code')},
                        {field: 'application_time', title: __('Application_time')},
                        {field: 'hand_user_code', title: __('Hand_user_code')},
                        {field: 'hand_time', title: __('Hand_time')},
                        {field: 'state_text', title: __('State'), operate:false},
                        {field: 'operate', title: __('Operate'), table: table, buttons: [{name: 'detail', 
                                title: '详情', icon: 'fa fa-list', classname: 'btn btn-xs btn-primary btn-dialog', 
                                url: 'user/upgradeapplication/details'},{name: 'del', icon: 'fa fa-trash', classname: 'btn btn-xs btn-danger btn-delone'}], 
                                events: Table.api.events.operate, formatter:  Table.api.formatter.buttons
                        }
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