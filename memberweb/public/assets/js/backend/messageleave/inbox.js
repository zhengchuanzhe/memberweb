define(['jquery', 'bootstrap', 'backend', 'table', 'form'], function ($, undefined, Backend, Table, Form) {

    var Controller = {
        index: function () {
            // 初始化表格参数配置
            Table.api.init({
                extend: {
                    index_url: 'messageleave/inbox/index',
                    add_url: 'messageleave/inbox/add',
                    edit_url: 'messageleave/inbox/edit',
                    del_url: 'messageleave/inbox/del',
                    multi_url: 'messageleave/inbox/multi',
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
                                title: '详情', text:"详情",icon: 'fa fa-list', classname: 'btn btn-dialog btn-xs btn-primary', 
                                url: 'messageleave/inbox/details', callback: function (data) {
                                        if (data!=0) {
                                            var dd= document.getElementById('table').tBodies[0];
                                            for (var i =0; i<dd.rows.length; i++) {
                                                if (dd.rows[i].cells[1].textContent==data){
                                                    dd.rows[i].cells[6].textContent='已读';
                                                    dd.rows[i].cells[6].firstChild.color=''
                                                    break;
                                                };
                                            };
                                        };
                                    }}], 
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
        details:function(){
            Controller.api.bindevent();
            var data=$("input[name=callback").val();
            Fast.api.callback(data);
            if (data!=0) {
                var arr= top.window.$("li a[addtabs][url='messageleave/inbox']").context.title.split(' ');
                var count=arr.length>1 ? arr[1]-1:0;
                if (count>0) {
                    top.window.$("li a[addtabs][url='messageleave/inbox']").context.title=arr[0]+' '+count;
                };
                top.window.Backend.api.sidebar({'messageleave/inbox':[count,'red', 'badge']});
            };

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