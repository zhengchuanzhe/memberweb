define(['jquery', 'bootstrap', 'backend', 'table', 'form'], function ($, undefined, Backend, Table, Form) {

    var Controller = {
        index: function () {
            // 初始化表格参数配置
            Table.api.init({
                extend: {
                    index_url: 'messageleave/notice/index',
                    add_url: 'messageleave/notice/add',
                    edit_url: 'messageleave/notice/edit',
                    del_url: 'messageleave/notice/del',
                    multi_url: 'messageleave/notice/multi',
                    table: 'message_notice',
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
                        {field: 'title', title: __('Title')},
                        {field: 'user_code', title: __('User_code')},
                        {field: 'create_time', title: __('Create_time'), formatter: Table.api.formatter.datetime},
                        {field: 'update_time', title: __('Update_time'), formatter: Table.api.formatter.datetime},
                        {field: 'operate', title: __('Operate'), table: table,
                            buttons: [
                                {
                                    name: 'detail', 
                                    title: '详情', icon: 'fa fa-list', 
                                    classname: 'btn btn-xs btn-primary btn-dialog', 
                                    url: 'messageleave/notice/details'
                                },
                                {
                                    name: 'edit', icon: 'fa fa-pencil', 
                                    classname: 'btn btn-xs btn-success btn-editone'
                                },
                                {
                                    name: 'del', icon: 'fa fa-trash', 
                                    classname: 'btn btn-xs btn-danger btn-delone'
                                }
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