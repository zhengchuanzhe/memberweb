define(['jquery', 'bootstrap', 'backend', 'table', 'form'], function ($, undefined, Backend, Table, Form) {

    var Controller = {
        index: function () {
            Controller.api.bindevent();
            Form.api.bindevent("form[role='form']", function(){
                location.reload();
            });
        },
        api: {
            bindevent: function () {
                $("#validate").on("click",function(){
                    var re = /.{7}/;
                    if (re.test($("#trans_member").val())) {
                        $.ajax({
                            url: "finance/membertransaction/getUserNameByCode",
                            type: 'post',
                            dataType: 'json',
                            data: {code: $("#trans_member").val()},
                            success: function (ret) {
                                if (ret.code == 1) {
                                    Backend.api.toastr.success(ret.msg);
                                    document.getElementById("trans_name").value=ret.msg;
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
                $("#exchange").on("click",function(){
                        $.ajax({
                            url: "finance/membertransaction/transaction",
                            type: 'post',
                            dataType: 'json',
                            data: {trans_cash: $("#trans_cash").val(),
                                    code: $("#trans_member").val()},
                            success: function (ret) {
                                if (ret.code == 1) {
                                    Backend.api.toastr.success(ret.msg);
                                    window.location.reload();//页面刷新
                                } else {
                                    Backend.api.toastr.error(ret.msg);
                                }
                            }, error: function (e) {
                                Backend.api.toastr.error(e.message);
                            }
                        });
                });
                Form.api.bindevent($("form[role=form]"));
            }
        }
    };
    return Controller;
});