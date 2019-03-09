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
        		$(document).ready(function(){
        			var old_referee_user_code=document.getElementById("referee_user_code").value
        			//推荐人输入改变
        			$('#referee_user_code').blur(function() { 
        				var re = /.{7}/;
        				var new_referee_user_code=$("#referee_user_code").val();
        				if (old_referee_user_code!=new_referee_user_code&&re.test($("#referee_user_code").val())) {
        					old_referee_user_code=new_referee_user_code;
        					$.ajax({
		                        url: "user/register/checkRefereeUserCode",
		                        type: 'post',
		                        dataType: 'json',
		                        data: {code: $("#referee_user_code").val()},
		                        success: function (ret) {
		                        	if (ret.code == 1) {
		                        		Backend.api.toastr.success(__('The code is correct')+':'+ret.data['user_name']);
		                           	 	document.getElementById("referee_user_name").innerHTML =ret.data['user_name'];
		                           	 	if (ret.data['count']>0) {
											$("#manage_user_code").attr("readOnly",false);
		                           	 		$("#c-user_area").attr("disabled",false);
		                           	 	}else{
		                           	 		$("#manage_user_code").attr("readOnly",true);
		                           	 		document.getElementById('c-user_area').value="A区";
		                           	 		document.getElementById('c-user_area').children[0].selected=true;
		                           	 		$("#c-user_area").attr("disabled",true);
		                           	 		document.getElementById("manage_user_code").value=$("#referee_user_code").val();
		                           	 		document.getElementById("manage_user_name").innerHTML =ret.data['user_name']+"(首次安置)";
		                           	 	}
		                        	} else {
		                        		Backend.api.toastr.error(ret.msg);
		                        		document.getElementById("referee_user_name").innerHTML =ret.msg;
		                        	}
		                        }, error: function (e) {
		                            Backend.api.toastr.error(e.message);
		                        }
		                    });
        				}
        			}); 

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
		                        url: "user/register/checkRefereeUserCode",
		                        type: 'post',
		                        dataType: 'json',
		                        data: {code: $("#referee_user_code").val()},
		                        success: function (ret) {
		                        	if (ret.code == 1) {
		                        		Backend.api.toastr.success(__('The code is correct')+':'+ret.data['user_name']);
		                           	 	document.getElementById("referee_user_name").innerHTML =ret.data['user_name'];
		                           	 	if (ret.data['count']>0) {
											$("#manage_user_code").attr("readOnly",false);
		                           	 		$("#c-user_area").attr("disabled",false);
		                           	 	}else{
		                           	 		$("#manage_user_code").attr("readOnly",true);
		                           	 		document.getElementById('c-user_area').value="A区";
		                           	 		document.getElementById('c-user_area').children[0].selected=true;
		                           	 		$("#c-user_area").attr("disabled",true);
		                           	 		document.getElementById("manage_user_code").value=$("#referee_user_code").val();
		                           	 		document.getElementById("manage_user_name").innerHTML =ret.data['user_name']+"(首次安置)";
		                           	 	}
		                        	} else {
		                        		Backend.api.toastr.error(ret.msg);
		                        		document.getElementById("referee_user_name").innerHTML =ret.msg;
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
		                        		Backend.api.toastr.success(__('The code is correct')+':'+ret.msg);
		                        	} else {
		                        		Backend.api.toastr.error(ret.msg);
		                        	}
		                            document.getElementById("declaration_form_name").innerHTML =ret.msg;
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
		                        url: "user/register/checkManageUserCode",
		                        type: 'post',
		                        dataType: 'json',
		                        data: {code: $("#manage_user_code").val()},
		                        success: function (ret) {
		                        	if (ret.code == 1) {
		                        		Backend.api.toastr.success(__('The code is correct')+':'+ret.data['user_name']);
		                        	} else {
		                        		Backend.api.toastr.error(ret.msg);
		                        	}
		                            document.getElementById("manage_user_name").innerHTML =ret.data['user_name']+'('+ret.data['message']+')';
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
		                        		Backend.api.toastr.success(__('The code is correct')+':'+ret.msg);
		                        	} else {
		                        		Backend.api.toastr.error(ret.msg);
		                        	}
		                            document.getElementById("service_centre_name").innerHTML =ret.msg;
		                            
		                        }, error: function (e) {
		                            Backend.api.toastr.error(e.message);
		                        }
		                    });
						} else {
							Backend.api.toastr.error("会员编号应为7位");
						}
					});
				});
        	}
        }
    };
    return Controller;
});