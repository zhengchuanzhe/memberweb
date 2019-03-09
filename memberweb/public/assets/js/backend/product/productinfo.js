define(['jquery', 'bootstrap', 'backend', 'table', 'form'], function ($, undefined, Backend, Table, Form) {

    var Controller = {
        index: function () {
            // 初始化表格参数配置
            Table.api.init({
                extend: {
                    index_url: 'product/productinfo/index',
                    add_url: 'product/productinfo/add',
                    edit_url: 'product/productinfo/edit',
                    del_url: 'product/productinfo/del',
                    table: 'product_productinfo',
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
                        {field: 'product_type_name', title: __('Product_type'), operate: false, formatter: Table.api.formatter.label},
                        {field: 'name', title: __('Name')},
                        {field: 'units', title: __('Units')},
                        {field: 'price', title: __('Price')},
                        {field: 'real_price', title: __('Real_price')},
                        {field: 'inventory', title: __('Inventory')},
                        {field: 'create_time', title: __('Createtime'), formatter: Table.api.formatter.datetime},
                        {field: 'operate', title: __('Operate'), table: table, 
                            buttons: [{
                                name: 'detail', 
                                title: '详情', icon: 'fa fa-list', classname: 'btn btn-xs btn-primary btn-dialog', 
                                url: 'product/productinfo/detail'
                            }], 
                                events: Table.api.events.operate, 
                                formatter:  Table.api.formatter.operate
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
        },
        api: {
            bindevent: function () {
                Form.api.bindevent($("form[role=form]"));
            }
        }
    };
    return Controller;
});