define(['jquery', 'bootstrap', 'backend', 'table', 'form'], function ($, undefined, Backend, Table, Form) {

    var Controller = {
        index: function () {
            // 初始化表格参数配置
            Table.api.init({
                extend: {
                    index_url: 'finance/historypersonalaccountflow/index',
                    table: 'finance_history_personalaccountflow',
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
                        {field: 'id', title: __('Id'),operate: false},
                        {field: 'user_code', title: __('User_code')},
                        {field: 'counterparty', title: __('Counterparty'),formatter:Controller.api.change_counterparty,operate: false},
                        {field: 'account_type', title: __('Account_type'),formatter:Controller.api.change_account_type,operate: false},
                        {field: 'transaction_amount', title: __('Transaction_amount'),operate: false},
                        {field: 'trade_direction', title: __('Trade_direction'),formatter:Controller.api.change_trade_direction,operate: false},
                        {field: 'before_balance', title: __('Before_balance'),operate: false},
                        {field: 'after_balance', title: __('After_balance'),operate: false},
                        {field: 'mark', title: __('Mark'),operate: false},
                        {field: 'trading_time', title: __('Trading_time'),operate: false},
                    ]
                ]
            });

            // 为表格绑定事件
            Table.api.bindevent(table);
        },
        api: {
            bindevent: function () {
                Form.api.bindevent($("form[role=form]"));
            },
            //交易对手
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