define(['jquery', 'bootstrap', 'backend', 'table', 'form'], function ($, undefined, Backend, Table, Form) {

    var Controller = {
        index: function () {
            Controller.api.bindevent();
            Form.api.bindevent($("form[role=form]"));
        },
        api: {
            bindevent: function () {
            }
        }
    };
    return Controller;
});