define(['jquery', 'bootstrap', 'backend', 'table', 'form'], function ($, undefined, Backend, Table, Form) {

    var Controller = {
        index: function () {
            Table.api.init({
                extend: {
                    index_url: 'finance/mywallet/index',
                    table: 'finance_history_personalaccountflow',
                }
            });

            var table = $("#table");

            // 初始化表格
            table.bootstrapTable({
                url: $.fn.bootstrapTable.defaults.extend.index_url,
                pk: 'id',
                sortName: 'id',
                showToggle: false,
                showColumns: false,
                showExport: false,
                commonSearch: false,
                search: false,
                operate: false,
                columns: [
                    [
                        {checkbox: true},
                        {field: 'id', title: __('Id')},
                        {field: 'user_code', title: __('User_code')},
                        {field: 'counterparty', title: __('Counterparty'),formatter:Controller.api.change_counterparty},
                        {field: 'account_type', title: __('Account_type'),formatter:Controller.api.change_account_type},
                        {field: 'transaction_amount', title: __('Transaction_amount')},
                        {field: 'trade_direction', title: __('Trade_direction'),formatter:Controller.api.change_trade_direction},
                        {field: 'before_balance', title: __('Before_balance')},
                        {field: 'after_balance', title: __('After_balance')},
                        {field: 'mark', title: __('Mark')},
                        {field: 'trading_time', title: __('Trading_time')},
                    ]
                ]
            });

            // 为表格绑定事件
            Table.api.bindevent(table);
            var rate_one=document.getElementById("rate_one").innerHTML.replace('%','');//第一种汇率
            var rate_two=document.getElementById("rate_two").innerHTML.replace('%','');//第二种汇率
            var rate_three=document.getElementById("rate_three").innerHTML.replace('%','');//第三种汇率
            Controller.api.bindevent();
            $("#cash_shopping_cash").on("input",function(){
                var num = document.getElementById("cash_shopping_cash").value*rate_one;
                document.getElementById("cash_shopping_shopping").value=num.toFixed(2);
            });
            $("#bonus_shopping_bonus").on("input",function(){
                var num = document.getElementById("bonus_shopping_bonus").value*rate_two;
                document.getElementById("bonus_shopping_shopping").value=num.toFixed(2);
            });
            $("#bonus_cash_bonus").on("input",function(){
                var num = document.getElementById("bonus_cash_bonus").value*rate_three;
                document.getElementById("bonus_cash_cash").value=num.toFixed(2);
            });
            Controller.api.bindevent();
            $("#change_one").on("click",function(){
                setTimeout(function(){  //使用  setTimeout（）方法设定定时2000毫秒
                    window.location.reload();//页面刷新
                },2000);
            });
            $("#change_two").on("click",function(){
                setTimeout(function(){  //使用  setTimeout（）方法设定定时2000毫秒
                    window.location.reload();//页面刷新
                },2000);
            });
            $("#change_three").on("click",function(){
                setTimeout(function(){  //使用  setTimeout（）方法设定定时2000毫秒
                    window.location.reload();//页面刷新
                },2000);
            });

        },
        api: {
            bindevent: function () {
                Form.api.bindevent($("form[role=form]"));
            },
            change_counterparty:function(counterparty){
                if(counterparty.length<=0||counterparty==''){
                    return '公司账户';
                }
                return counterparty;
            },
            //账户类型
            change_account_type:function(account_type){
                switch(account_type)
                {
                    case 0:
                        return "现金币"
                        break;
                    case 1:
                        return "奖金币"
                        break;
                    case 2:
                        return "购物积分"
                        break;
                    case 3:
                        return "注册积分"
                        break;
                    default:
                        return "错误";
                }
            },
            //交易方向
            change_trade_direction:function(trade_direction){
                if(trade_direction==0){
                    return '借';
                }
                return '贷';
            }
        }
    };
    return Controller;
});