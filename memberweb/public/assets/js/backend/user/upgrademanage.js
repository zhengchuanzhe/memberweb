define(['jquery', 'bootstrap', 'backend', 'table', 'form'], function ($, undefined, Backend, Table, Form) {

    var Controller = {
        index: function () {
            // 初始化表格参数配置
            Table.api.init({
                extend: {
                    index_url: 'user/upgrademanage/index',
                    add_url: 'user/upgrademanage/add',
                    edit_url: 'user/upgrademanage/edit',
                    del_url: 'user/upgrademanage/del',
                    multi_url: 'user/upgrademanage/multi',
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
                        {field: 'state_text', title: __('State'), operate:false,formatter: function(value, row, index) {
                                // 若状态为“待处理”，则红色显示
                                if (row.state == '0') {
                                    return '<font color="#FF0000">'+row.state_text+'</font>';
                                } else {
                                    return row.state_text;
                                }
                            }
                        },
                        {field: 'operate', title: __('Operate'), table: table,
                            buttons: [
                                {
                                    name: 'edit', title:'操作',icon: 'fa fa-cogs', classname: 'btn btn-dialog btn-xs btn-primary', 
                                    url: 'user/upgrademanage/edit', 
                                    callback: function (data) { 
                                        if (data) {
                                            var dd= document.getElementById('table').tBodies[0];
                                            for (var i =0; i<dd.rows.length; i++) {
                                                if (dd.rows[i].cells[1].textContent==data['id']){
                                                    dd.rows[i].cells[8].textContent=data['con'];
                                                    dd.rows[i].cells[8].firstChild.color=''
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
            $("#agree").on("click",function(){
                    Layer.open({
                        title: [
                            '同意申请',
                            'background-color:#8DCE16; color:#fff;margin-top: 0px;'
                                ]
                        , anim: 'up'
                        , content: '<b>申请一旦同意，将为会员升级</b>'  + '</br><b>是否确认？</b>' 
                        , btn: ['确定', '取消']
                        , yes: function () {
                            Controller.api.agree();
                        }
                    });
            });
            $("#refuse").on("click",function(){
                    Layer.open({
                        title: [
                            '拒绝申请',
                            'background-color:#8DCE16; color:#fff;margin-top: 0px;'
                                ]
                        , anim: 'up'
                        , content: '<b>申请一旦拒绝，将无法操作</b>'  + '</br><b>是否确认？</b>' 
                        , btn: ['确定', '取消']
                        , yes: function () {
                            Controller.api.refuse();
                        }
                    });
            });
        },
        api: {
            bindevent: function () {
                Form.api.bindevent($("form[role=form]"));
            },
            //同意
            agree:function(){
                $.ajax({
                    url: "user/upgrademanage/agree",
                    type: 'post',
                    dataType: 'json',
                    data: { id: $("#c-id").val() },
                    success: function (ret) {
                        if (ret.code == 1) {
                            Fast.api.close({
                                'id':$("#c-id").val(),
                                'con':'同意'
                            });
                            Backend.api.toastr.success('操作成功');
                        } else {
                            Backend.api.toastr.error(ret.msg);
                        }   
                    }, error: function (e) { 
                        Backend.api.toastr.error(e.message);
                        Fast.api.close(null);
                    }
                });
            },
            //拒绝
            refuse:function(){
                var application_id=$("#c-id").val();
                $.ajax({
                    url: "user/upgrademanage/refuse",
                    type: 'post',
                    dataType: 'json',
                    data: { id:  application_id},
                    success: function (ret) { 
                        if (ret.code == 1) {
                            Fast.api.close({
                                'id':application_id,
                                'con':'拒绝'
                            });
                            Backend.api.toastr.success('操作成功');
                        } else {
                            Backend.api.toastr.error(ret.msg);
                        }   
                    }, error: function (e) { 
                        Backend.api.toastr.error(e.message);
                        Fast.api.close(null);
                    }
                });
            },
            // 根据键值对，清除数组中某元素
            array_remove_by_key_value : function(array, key, val) {
                var index = -1;
                for (var i = 0; i < array.length; i++) {
                    if (array[i][key] == val) index = i;
                }
                if (index > -1) {
                    array.splice(index, 1);
                }
            },
        }
    };
    return Controller;
});