define(['jquery', 'bootstrap', 'backend', 'table', 'form'], function ($, undefined, Backend, Table, Form) {

    var Controller = {
        index: function () {
            // 初始化表格参数配置
            Table.api.init({
                extend: {
                    index_url: 'messageleave/outbox/index',
                    add_url: 'messageleave/outbox/add',
                    edit_url: 'messageleave/outbox/edit',
                    del_url: 'messageleave/outbox/del',
                    multi_url: 'messageleave/outbox/multi',
                    table: 'message_leave',
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
                        {field: 'message_title', title: __('Message_title')},
                        {field: 'send_user_code', title: __('Send_user_code')},
                        {field: 'receive_user_code', title: __('Receive_user_code')},
                        {field: 'send_time', title: __('Send_time')},
                        {field: 'is_read', title: __('Is_read') , formatter:Controller.api.is_read},
                        {field: 'operate', title: __('Operate'), table: table, buttons: [{name: 'detail', 
                                title: '详情', icon: 'fa fa-list', classname: 'btn btn-xs btn-primary btn-dialog', 
                                url: 'messageleave/outbox/details'},{name: 'del', icon: 'fa fa-trash', classname: 'btn btn-xs btn-danger btn-delone'}], 
                                events: Table.api.events.operate, formatter:  Table.api.formatter.buttons
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
        edit: function () {
            Controller.api.bindevent();
        },
        api: {
            bindevent: function () {
                Form.api.bindevent($("form[role=form]"));
            },
            is_read:function(isread){
                if(isread==0){
                    return '<font color="#FF0000">未读</font>';
                }
                return "已读";
            }
        }
    };
    return Controller;
});