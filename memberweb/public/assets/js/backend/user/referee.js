define(['jquery', 'bootstrap', 'backend', 'table', 'form'], function ($, undefined, Backend, Table, Form) {

    var Controller = {
        index: function () {
            // 初始化表格参数配置
            Table.api.init({
                extend: {
                    index_url: 'user/referee/index'
                }
            });

            var table = $("#table");

            // 初始化表格
            table.bootstrapTable({
                url: $.fn.bootstrapTable.defaults.extend.index_url,
                showToggle:false,
                showColumns:false,
                showExport:false,
                search:false,
                commonSearch:false,
                operate:false,
                columns: [
                    [
                        {field: 'state', checkbox: true, },
                        {field: 'id', title: 'ID'},
                        {field: 'user_code', title: __('User code')},
                        {field: 'user_name', title: __('User name')},
                        {field: 'grade_name', title: __('Grade code'), operate:false, formatter: Table.api.formatter.label},
                        {field: 'referee_user_code', title: __('Referee user code')},
                        {field: 'operate', title: __('Operate'), table: table, buttons: [
                                {name: 'son', text: '下一级',  icon: 'fa fa-list', classname: 'btn btn-xs btn-primary btn-myajax'}
                            ], events: Controller.api.operate, formatter: Table.api.formatter.operate}
                    ]
                ]
            });

            // 为表格绑定事件
            Table.api.bindevent(table);
        },
        api:{
            operate:{
                'click .btn-myajax': function (e, value, row, index) {
                    e.stopPropagation();
                    e.preventDefault();
                    var table = $(this).closest('table');
                    var options = table.bootstrapTable('getOptions');
                    var param_user_code = row['user_code'];
                    options.queryParams = function (params) {
                        return {
                            search: params.search,
                            sort: params.sort,
                            order: params.order,
                            filter: JSON.stringify({user_code: param_user_code}),
                            offset: params.offset,
                            limit: params.limit,
                        };
                    };
                    table.bootstrapTable('refresh', {});
                }
            },
        }

    };
    return Controller;
});