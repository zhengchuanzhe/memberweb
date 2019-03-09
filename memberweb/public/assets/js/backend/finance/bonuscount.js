define(['jquery', 'bootstrap', 'backend', 'table', 'form'], function ($, undefined, Backend, Table, Form) {

    var Controller = {
        index: function () {
            // 初始化表格参数配置
            Table.api.init({
                extend: {
                    index_url: 'finance/bonuscount/index',
                    table: 'bonuscount',
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
                        {field: 'user_code', title: __('User code')},
                        {field: 'plan_money', title: __('Count bonus')},
                        {field: 'reality_money', title: __('Real bonus')},
                        {field: 'bonus_type', title: __('Bouns type'), formatter:Controller.api.bonus_type},
                        {field: 'mark', title: __('Mark')},
                        {field: 'operate', title: __('Operate'), table: table, 
                            buttons: [{
                                title:'修改实际奖金',
                                icon: 'fa fa-cogs', 
                                classname: 'btn btn-xs btn-dialog btn-danger', 
                                url: 'finance/bonuscount/edit', 
                            }], 
                            events: Table.api.events.operate, 
                            formatter: Table.api.formatter.operate
                        }
                    ]
                ],
                onLoadSuccess: function () {
                    // 更新左侧核算数据
                    Controller.api.update_left_param();
                    Layer.tips('正在计算...', '#total_count_bonus', {tips: 1})
                }
            });

            // 为表格绑定事件
            Table.api.bindevent(table);
            Controller.api.bindevent();
            Form.api.bindevent("form[role='form']");
        },
        edit: function () {
            Form.api.bindevent("form[role='form']");
        },
        api: {
            bonus_type:function(bonus_type){
                var strType=['推荐奖','销售奖','管理奖','重消奖','服务奖','见点奖'];
                return strType[bonus_type];
            },
            bindevent: function () {

                $(document).ready(function(){
               
                    // 计算按钮点击事件
                    $("#btn_calculate").on("click",function(){
                     
                        // 判断表格有无数据
                        var currentDataLength = $("#table").bootstrapTable('getData', {}).length;
                        var deadline_time =$("#deadline_time").val();
                        if (deadline_time.length<=0||new Date(deadline_time)>new Date()) {
                            alert("请选择正确时间");
                            return;
                        }
                        if(currentDataLength > 0){
                            // 有数据则提示是否重新计算
                            Layer.open({
                                title: [
                                    '重新计算',
                                    'background-color:#8DCE16; color:#fff;margin-top: 0px;'
                                        ]
                                , anim: 'up'
                                , content: '<b>是否重新计算？</b>'
                                , btn: ['确定', '取消']
                                , yes: function (index, layero) {
                                    // 发送请求后台计算
                                    Controller.api.calculate();
                                    Layer.close(index); 
                                }
                            });
                        } 
                        else // 表格无数据直接计算
                        {
                            // 发送请求后台计算
                            Controller.api.calculate();
                        }
                    });

                    // 发放按钮点击事件
                    $("#btn_giveout").on("click",function(){
                        // 判断表格有无数据
                        var currentDataLength = $("#table").bootstrapTable('getData', {}).length;
                        if(currentDataLength > 0){
                            // 有数据则发放奖金
                            Controller.api.give_out();
                        }else{
                            alert("请先计算数据");
                        } 
                    });

                    // 发放按钮点击事件
                    $("#btn_suggest").on("click",function(){
                        // 判断表格有无数据
                        var currentDataLength = $("#table").bootstrapTable('getData', {}).length;
                        if(currentDataLength > 0){
                            // 有数据则发放奖金
                            Controller.api.suggest_bonus();
                        }else{
                            alert("请先计算数据");
                        } 
                    });



                });
            },

            // 修改页面左侧参数
            update_left_param: function () {
                // 发送请求获取总计算金额，总实际金额，上次核算日期，本次核算日期，计算K-值
                $.ajax({
                    url: "finance/bonuscount/getParamsByType",
                    type: 'post',
                    dataType: 'json',
                    data: {},
                    success: function (ret) {
                        if (ret.hasOwnProperty("code")) {
                            var data = ret.hasOwnProperty("data") && ret.data != null ? ret.data : "";
                            if (ret.code === 1) {
                                // 修改参数
                                $("#total_count_bonus").val(ret.data[0]['total_count_bonus']?ret.data[0]['total_count_bonus']:0);
                                $("#total_real_bonus").val(ret.data[0]['total_real_bonus']?ret.data[0]['total_real_bonus']:0);
                                $("#last_account_date").val(ret.data[1]['account_date']);
                                $("#deadline_time").val(ret.data[2]['account_date']);
                                $("#k_value").val(ret.data[3]);

                            } else {
                                Backend.api.toastr.error(ret.data);
                            }
                        }
                    }, error: function (e) {
                        Backend.api.toastr.error(e.message);
                    }
                });
            },

            // 奖金计算后台请求
            calculate: function () {
                $.ajax({
                    url: "finance/bonuscount/calculate",
                    type: 'post',
                    dataType: 'json',
                    data: {deadline_time: $("#deadline_time").val()},
                    success: function (ret) {
                        if (ret.hasOwnProperty("code")) {
                            var data = ret.hasOwnProperty("data") && ret.data != null ? ret.data : "";
                            if (ret.code === 1) {
                                // 刷新页面
                                $("#table").bootstrapTable('refresh', {});
                            } else {
                                Backend.api.toastr.error(ret.msg);
                            }
                        }
                    }, error: function (e) {
                        Backend.api.toastr.error(e.message);
                    }
                });
            },
            //推荐发放计划
            suggest_bonus:function(){
                $.ajax({
                    url: "finance/bonuscount/calSuggest",
                    type: 'post',
                    dataType: 'json',
                    data: {},
                    success: function (ret) {
                        if (ret.hasOwnProperty("code")) {
                            var data = ret.hasOwnProperty("data") && ret.data != null ? ret.data : "";
                            if (ret.code === 1) {
                                // 刷新页面
                                $("#table").bootstrapTable('refresh', {});
                            } else {
                                Backend.api.toastr.error(ret.msg);
                            }
                        }
                    }, error: function (e) {
                        Backend.api.toastr.error(e.message);
                    }
                });
            },

            // 奖金发放后台请求
            give_out: function () {
                $.ajax({
                    url: "finance/bonuscount/giveOut",
                    type: 'post',
                    dataType: 'json',
                    data: {},
                    success: function (ret) {
                        if (ret.hasOwnProperty("code")) {
                            var data = ret.hasOwnProperty("data") && ret.data != null ? ret.data : "";
                            if (ret.code === 1) {
                                Backend.api.toastr.success("发放成功");
                                // 刷新页面
                                $("#table").bootstrapTable('refresh', {});
                            } else {
                                Backend.api.toastr.error(ret.data);
                            }
                        }
                    }, error: function (e) {
                        Backend.api.toastr.error(e.message);
                    }
                });
            },

        }
    };
    return Controller;
});