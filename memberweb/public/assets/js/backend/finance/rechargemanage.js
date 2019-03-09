define(['jquery', 'bootstrap', 'backend', 'table', 'form'], function ($, undefined, Backend, Table, Form) {

    var Controller = {
        index: function () {
            // 初始化表格参数配置
            Table.api.init({
                extend: {
                    index_url: 'finance/rechargemanage/index',
                    edit_url: 'finance/rechargemanage/edit',
                    del_url: 'finance/rechargemanage/del',
                    multi_url: 'finance/rechargemanage/multi',
                    table: 'rechargemanage',
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
                        {field: 'after_balance', title: __('After_balance')},
                        {field: 'application_time', title: __('Application_time')},
                        {field: 'state_text', title: __('State'), operate:false, 
                            formatter: function(value, row, index) {
                                // 若状态为“待处理”，则红色显示
                                if (row.state == '0') {
                                    return '<font color="#FF0000">'+row.state_text+'</font>';
                                } else {
                                    return row.state_text;
                                }
                            }
                        },
                        {field: 'hand_user_code', title: __('Hand_user_code')},
                        {field: 'mark', title: __('Mark')},
                        {field: 'operate', title: __('Operate'), table: table,
                            buttons: [
                                {
                                    name: 'edit', title:'确认操作',icon: 'fa fa-cogs', classname: 'btn btn-dialog btn-xs btn-primary', 
                                    url: 'finance/rechargemanage/edit', 
                                    callback: function (data) {
                                        if (data) {
                                            var dd= document.getElementById('table').tBodies[0];
                                            for (var i =0; i<dd.rows.length; i++) {
                                                if (dd.rows[i].cells[1].textContent==data['id']){
                                                    if (!isNaN(data['after_balance'])) {
                                                        dd.rows[i].cells[4].textContent=data['after_balance'];
                                                    }
                                                    dd.rows[i].cells[6].textContent=data['con'];
                                                    dd.rows[i].cells[7].textContent=data['hand_user_code'];
                                                    dd.rows[i].cells[8].textContent=data['mark'];
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
                                if (row.state == '0') {
                                    Controller.api.array_remove_by_key_value(buttons, "name", "del");
                                }
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
            // 初始化
            Controller.api.calculate_after_balance();

            Controller.api.bindevent();
            $(document).ready(function(){
                // 确认通过事件
                $("#confirm").on("click",function(){
                    Layer.open({
                        title: [
                            '确认充值',
                            'background-color:#8DCE16; color:#fff;margin-top: 0px;'
                                ]
                        , anim: 'up'
                        , content: '<b>申请一旦确认，将为会员充值</b>'  + '</br><b>是否确认？</b>' 
                        , btn: ['确定', '取消']
                        , yes: function () {
                                var row = {
                                    "id": $("#c-id").val(),
                                    'state': 1,
                                    'application_user_code': $("#c-application_user_code").val(),
                                    'application_amount': $("#c-application_amount").val(),
                                    'before_balance': $("#c-before_balance").val(),
                                    'after_balance': $("#c-after_balance").val(),
                                    'hand_user_code': $("#c-hand_user_code").val(),
                                    'mark': $("#c-mark").val(),
                                };

                                $.ajax({
                                    url: "finance/rechargemanage/recharge",
                                    type: 'post',
                                    dataType: 'json',
                                    data: { row: row },
                                    success: function (ret) { 
                                        if (ret.code == 1) {
                                            if (ret.data.res===1) {
                                                Backend.api.toastr.success('充值成功');
                                                Fast.api.close({
                                                    'id':$("#c-id").val(),
                                                    'con':'申请完成',
                                                    'after_balance':ret.data.after_balance,
                                                    'hand_user_code':ret.data.hand_user_code,
                                                    'mark':ret.data.mark
                                                });
                                            }
                                            else{
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

                // 拒绝通过事件
                $("#cancel").on("click",function(){
                    Layer.open({
                        title: [
                            '确定拒绝',
                            'background-color:#8DCE16; color:#fff;margin-top: 0px;'
                                ]
                        , anim: 'up'
                        , content: '<b>申请一旦拒绝，将不为会员充值</b>'  + '</br><b>是否确认？</b>' 
                        , btn: ['确定', '取消']
                        , yes: function () {
                                var row = {
                                    "id": $("#c-id").val(),
                                    'state': 2,
                                    'hand_user_code': $("#c-hand_user_code").val(),
                                    'mark': $("#c-mark").val(),
                                };

                                $.ajax({
                                    url: "finance/rechargemanage/rechargeCancel",
                                    type: 'post',
                                    dataType: 'json',
                                    data: { row: row },
                                    success: function (ret) { 
                                        if (ret.code == 1) {
                                            if (ret.data.res===1) {
                                                Fast.api.close({
                                                    'id':$("#c-id").val(),
                                                    'con':'未通过',
                                                    'hand_user_code':ret.data.hand_user_code,
                                                    'mark':ret.data.mark
                                                });
                                            }
                                        } else {
                                            Backend.api.toastr.error(ret.msg);
                                        }   
                                    }, error: function (e) { 
                                        Backend.api.toastr.error(e.message);
                                        Fast.api.close(null);
                                    }
                                });

                        }
                    });
                });
            });
        },
        api: {
            bindevent: function () {
                Form.api.bindevent($("form[role=form]"));
            },

            // 计算申请后余额
            calculate_after_balance: function () {
                $("#c-after_balance").val(parseFloat($("#c-application_amount").val())+parseFloat($("#c-before_balance").val()));
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

            // 若待处理则显示红色
            is_deal : function(state_text) {
                if(state_text=="待处理") {
                    return '<font color="#FF0000">待处理</font>';
                }
            }
        }
    };
    return Controller;
});