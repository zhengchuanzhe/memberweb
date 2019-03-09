define(['jquery', 'bootstrap', 'backend', 'table', 'form'], function ($, undefined, Backend, Table, Form) {

    var Controller = {
        index: function () {
            // 初始化表格参数配置
            Table.api.init({
                extend: {
                    index_url: 'auth/admin/index',
                    add_url: 'auth/admin/add',
                    edit_url: 'auth/admin/edit',
                    del_url: 'auth/admin/del',
                    multi_url: 'auth/admin/multi',
                }
            });

            var table = $("#table");

            // 初始化表格
            table.bootstrapTable({
                url: $.fn.bootstrapTable.defaults.extend.index_url,
                columns: [
                    [
                        {field: 'state', checkbox: true, },
                        {field: 'id', title: 'ID'},
                        {field: 'user_code', title: __('User code')},
                        {field: 'user_name', title: __('User name')},
                       // {field: 'groups_text', title: __('Group'), operate:false, formatter: Table.api.formatter.label},
                        {field: 'grade_name', title: __('Membership grade'), operate:false, formatter: Table.api.formatter.label},
                        {field: 'status', title: __("Status"), formatter: Table.api.formatter.status},
                        {field: 'login_time', title: __('Login time'), formatter: Table.api.formatter.datetime},
                        {field: 'operate', title: __('Operate'), table: table, events: Table.api.events.operate, formatter: function (value, row, index) {
                                if(row.id == Config.admin.id){
                                    return '';
                                }
                                return Table.api.formatter.operate.call(this, value, row, index);
                            }}
                    ]
                ]
            });

            // 为表格绑定事件
            Controller.api.bindevent();
            Form.api.bindevent($("form[role=form]"));
            Table.api.bindevent(table);
        },
        add: function () {
            Controller.api.bindevent();
            Form.api.bindevent($("form[role=form]"));
        },
        edit: function () {
            Controller.api.bindevent();
            Form.api.bindevent($("form[role=form]"));
        },
        api: {
            bindevent: function () {
                $(document).ready(function(){
                    // 随机生成新会员编号
                    $("#random").on("click",function(){
                        $.ajax({
                            url: "user/register/getRandomCode",
                            type: 'post',
                            dataType: 'json',
                            success: function (ret) {
                                $("#user_code").val(ret.data);
                            }, error: function (e) {
                                Backend.api.toastr.error(e.message);
                            }
                        });
                    });
                    // 验证新会员编号是否可用
                    $("#isExistCode").on("click",function(){
                        var re = /.{7}/;
                        if (re.test($("#user_code").val())) {
                            $.ajax({
                                url: "user/register/isExistCode",
                                type: 'post',
                                dataType: 'json',
                                data: {code: $("#user_code").val()},
                                success: function (ret) {
                                    if (ret.code == 1) {
                                        Backend.api.toastr.success(ret.msg);
                                    } else {
                                        Backend.api.toastr.error(ret.msg);
                                    }
                                    
                                }, error: function (e) {
                                    Backend.api.toastr.error(e.message);
                                }
                            });
                        } else {
                            Backend.api.toastr.error("会员编号应为7位");
                        }
                    });
                    // 验证推荐人会员编号是否输入正确
                    $("#is_referee_user_code").on("click",function(){
                        var re = /.{7}/;
                        if (re.test($("#referee_user_code").val())) {
                            $.ajax({
                                url: "user/register/getUserNameByCode",
                                type: 'post',
                                dataType: 'json',
                                data: {code: $("#referee_user_code").val()},
                                success: function (ret) {
                                    if (ret.code == 1) {
                                        Backend.api.toastr.success(ret.msg);
                                    } else {
                                        Backend.api.toastr.error(ret.msg);
                                    }
                                    
                                }, error: function (e) {
                                    Backend.api.toastr.error(e.message);
                                }
                            });
                        } else {
                            Backend.api.toastr.error("会员编号应为7位");
                        }
                    });
                    // 验证报单人会员编号是否输入正确
                    $("#is_declaration_form_code").on("click",function(){
                        var re = /.{7}/;
                        if (re.test($("#declaration_form_code").val())) {
                            $.ajax({
                                url: "user/register/getUserNameByCode",
                                type: 'post',
                                dataType: 'json',
                                data: {code: $("#declaration_form_code").val()},
                                success: function (ret) {
                                    if (ret.code == 1) {
                                        Backend.api.toastr.success(ret.msg);
                                    } else {
                                        Backend.api.toastr.error(ret.msg);
                                    }
                                    
                                }, error: function (e) {
                                    Backend.api.toastr.error(e.message);
                                }
                            });
                        } else {
                            Backend.api.toastr.error("会员编号应为7位");
                        }
                    });
                    // 验证安置人会员编号是否输入正确
                    $("#is_manage_user_code").on("click",function(){
                        var re = /.{7}/;
                        if (re.test($("#manage_user_code").val())) {
                            $.ajax({
                                url: "user/register/getUserNameByCode",
                                type: 'post',
                                dataType: 'json',
                                data: {code: $("#manage_user_code").val()},
                                success: function (ret) {
                                    if (ret.code == 1) {
                                        Backend.api.toastr.success(ret.msg);
                                    } else {
                                        Backend.api.toastr.error(ret.msg);
                                    }
                                    
                                }, error: function (e) {
                                    Backend.api.toastr.error(e.message);
                                }
                            });
                        } else {
                            Backend.api.toastr.error("会员编号应为7位");
                        }
                    });
                    // 验证服务中会员编号是否输入正确
                    $("#is_service_centre_code").on("click",function(){
                        var re = /.{7}/;
                        if (re.test($("#service_centre_code").val())) {
                            $.ajax({
                                url: "user/register/getUserNameByCode",
                                type: 'post',
                                dataType: 'json',
                                data: {code: $("#service_centre_code").val()},
                                success: function (ret) {
                                    if (ret.code == 1) {
                                        Backend.api.toastr.success(ret.msg);
                                    } else {
                                        Backend.api.toastr.error(ret.msg);
                                    }
                                    
                                }, error: function (e) {
                                    Backend.api.toastr.error(e.message);
                                }
                            });
                        } else {
                            Backend.api.toastr.error("会员编号应为7位");
                        }
                    });
                    $("#password_reset").on("click",function(){
                        $.ajax({
                            url: "auth/admin/passwordReset",
                            type: 'post',
                            dataType: 'json',
                            data: {code: $("#user_code").val()},
                            success: function (ret) {
                                if (ret.code == 1) {
                                    Backend.api.toastr.success(ret.msg);
                                } else {
                                    Backend.api.toastr.error(ret.msg);
                                }
                            }, error: function (e) {
                                Backend.api.toastr.error(e.message);
                            }
                        });
                    });
                    $("#select_user").on("click",function(){
                        var re = /.{7}/;
                        if (re.test($("#user_code").val())) {
                            $.ajax({
                                url: "auth/admin/selectUser",
                                type: 'post',
                                dataType: 'json',
                                data: {code: $("#user_code").val()},
                                success: function (ret) {
                                    if (ret.code == 1) {
                                        document.getElementById('grade_code').value=ret.data['grade'];
                                        document.getElementById('user_cash').value=ret.data['cash'];
                                        document.getElementById('user_bonus').value=ret.data['bonus'];
                                        document.getElementById('user_shopping').value=ret.data['shopping'];
                                        document.getElementById('user_register').value=ret.data['register'];
                                    }else {
                                        document.getElementById('grade_code').value="";
                                        document.getElementById('user_cash').value="";
                                        document.getElementById('user_bonus').value="";
                                        document.getElementById('user_shopping').value="";
                                        document.getElementById('user_register').value="";
                                        Backend.api.toastr.error(ret.msg);
                                    }
                                }, error: function (e) {
                                    Backend.api.toastr.error(e.message);
                                }
                            });
                        } else {
                            Backend.api.toastr.error("会员编号应为7位");
                        }
                    });
                    $("#confirm_change").on("click",function(){
                        Layer.open({
                            title: [
                                '确认修改',
                                'background-color:#8DCE16; color:#fff;margin-top: 0px;'
                            ]
                            , anim: 'up'
                            , content: '<b>修改一旦确认，将修改会员金额</b>'  + '</br><b>是否确认？</b>'
                            , btn: ['确定', '取消']
                            , yes: function () {
                                $.ajax({
                                    url: "auth/admin/confirmChange",
                                    type: 'post',
                                    dataType: 'json',
                                    data: {
                                        code:$("#user_code").val(),
                                        grade:$("#grade_code").val(),
                                        0: $("#user_cash").val(),
                                        1: $("#user_bonus").val(),
                                        2: $("#user_shopping").val(),
                                        3: $("#user_register").val()},
                                    success: function (ret) {
                                        if (ret.code == 1) {
                                            Backend.api.toastr.success(ret.msg);
                                            window.location.reload();
                                        }else {
                                            Backend.api.toastr.error(ret.msg);
                                        }
                                    }, error: function (e) {
                                        Backend.api.toastr.error(e.message);
                                    }
                                });
                            }
                        });
                    });
                    $("#upgrade_user").on("click",function(){
                        Layer.open({
                            title: [
                                '确认提升',
                                'background-color:#8DCE16; color:#fff;margin-top: 0px;'
                            ]
                            , anim: 'up'
                            , content: '<b>修改一旦确认，将提升会员等级为服务中心</b>'  + '</br><b>是否确认？</b>'
                            , btn: ['确定', '取消']
                            , yes: function () {
                                $.ajax({
                                    url: "auth/admin/upgradeUser",
                                    type: 'post',
                                    dataType: 'json',
                                    data: {code:$("#user_code").val()},
                                    success: function (ret) {
                                        if (ret.code == 1) {
                                            Backend.api.toastr.success(ret.msg);
                                            window.location.reload();
                                        }else {
                                            Backend.api.toastr.error(ret.msg);
                                        }
                                    }, error: function (e) {
                                        Backend.api.toastr.error(e.message);
                                    }
                                });
                            }
                        });
                    });
                });
            }
        }
    };
    return Controller;
});