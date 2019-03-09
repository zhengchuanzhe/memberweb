define(['jquery', 'bootstrap', 'backend', 'table', 'form'], function ($, undefined, Backend, Table, Form) {

    var Controller = {
        index: function () {
            // 初始化表格参数配置
            Table.api.init({
                extend: {
                    index_url: 'finance/cashapplicationmanage/index',
                    add_url: 'finance/cashapplicationmanage/add',
                    edit_url: 'finance/cashapplicationmanage/edit',
                    del_url: 'finance/cashapplicationmanage/del',
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
                        {field: 'application_user_code', title: __('Application_user_code')},
                        {field: 'application_amount', title: __('Application_amount')},
                        {field: 'application_time', title: __('Application_time')},
                        {field: 'state_text', title: __('State'), operate:false,formatter: function(value, row, index) {
                                // 若状态为“待处理”，则红色显示
                                if (row.state == '0') {
                                    return '<font color="#FF0000">'+row.state_text+'</font>';
                                } else {
                                    return row.state_text;
                                }
                            }},
                        {field: 'hand_user_code', title: __('Hand_user_code')},
                        {field: 'hand_time', title: __('Hand_time')},
                        {field: 'operate', title: __('Operate'), table: table,
                                 buttons: [
                                {
                                    name: 'edit', title:'确认操作',icon: 'fa fa-cogs', classname: 'btn btn-dialog btn-xs btn-primary', 
                                    url: 'finance/cashapplicationmanage/edit',
                                    callback: function (data){
                                        if (data) {
                                            var dd= document.getElementById('table').tBodies[0];
                                            for (var i =0; i<dd.rows.length; i++) {
                                                if (dd.rows[i].cells[1].textContent==data['id']){
                                                    dd.rows[i].cells[5].textContent=data['con'];
                                                    dd.rows[i].cells[6].textContent=data['hand_user_code'];
                                                    dd.rows[i].cells[7].textContent= data['hand_time'];
                                                    break;
                                                };
                                            };
                                        };
                                    }
                                },
                                {name: 'del', icon: 'fa fa-trash', classname: 'btn btn-xs btn-danger btn-delone'}], 
                                events: Table.api.events.operate, formatter: function(value, row, index) {
                                        // 默认按钮组 
                                         var buttons = $.extend([], this.buttons || []);
                                        // 若状态为“待处理”，则不显示删除按钮
                                        return Table.api.buttonlink(this, buttons, value, row, index, 'buttons'); 
                                } 
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

            $(document).ready(function(){
                // 确认通过事件
                $("#confirm").on("click",function(){
                    Layer.open({
                        title: [
                            '确认提现',
                            'background-color:#8DCE16; color:#fff;margin-top: 0px;'
                                ]
                        , anim: 'up'
                        , content: '<b>申请一旦确认，将无法修改</b>'  + '</br><b>是否确认？</b>' 
                        , btn: ['确定', '取消']
                        , yes: function () {
                                var row = {
                                    "id": $("#c-id").val(),
                                    'mark': $("#c-mark").val(),
                                };
                                $.ajax({
                                    url: "finance/Cashapplicationmanage/applicationCompletion",
                                    type: 'post',
                                    dataType: 'json',
                                    data: { row: row },
                                    success: function (ret) { 
                                        if (ret.code == 1) {
                                            if (ret.data.res=='success') {
                                                Backend.api.toastr.success('充值成功');
                                                Fast.api.close({
                                                    'id':$("#c-id").val(),
                                                    'con':'申请完成',
                                                    'hand_user_code':ret.data.hand_user_code,
                                                    'hand_time':ret.data.date,
                                                    'mark':$("#c-mark").val()
                                                });
                                            }
                                            else {
                                                Backend.api.toastr.error(ret.msg);
                                            }
                                        } else {
                                            Backend.api.toastr.error(ret.msg);
                                        }   
                                    }, error: function (e) { 
                                        Backend.api.toastr.error(e.message);
                                    }
                                });

                        }
                    });
                });

                $("#cancel").on("click",function(){
                     Fast.api.close(null);
                });

            });
        },
        api: {
            bindevent: function () {
                Form.api.bindevent($("form[role=form]"));
            }
        }
    };
    return Controller;
});