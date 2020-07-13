<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    
    <title>My JSP 'list.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	<!-- 
		Web路径的问题
		不是以/开头的路径，是以当前的资源路径作为基准的，经常会出现问题
		以/开头的路径，是以服务器的路径作为基准的，就是以http://localhost:8080为基准的
		我们在使用这个路径的时候需要添加项目名称、资源的名称
		一般来说，我们的项目名称不需要写在路径中的，因为JSP中给我们获取了项目的路径
		String path = request.getContextPath();
		我们只需要把这个路径存储在当前页面的属性范围中就可以了，然后需要用的时候我们使用EL表达获取
	 -->
		<%
		String path = request.getContextPath();
		String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
		pageContext.setAttribute("app_path",path);
		%>
	<!-- 引入JQuery的文件 -->
	<script type="text/javascript" src="${app_path}/static/js/jquery-1.12.4.min.js"></script>
	<!-- 引入BootStrap的CSS文件 --> 
 	<link href="${app_path}/static/bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet">
 	<!-- 引入BootStrap的JS文件 -->
 	<script type="text/javascript" src="${app_path}/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
  	<script>
  		$(document).ready(function(){
  		
  			//当页面加载完毕，跳转到第一页
  			to_page(1);
  			//当页面加载完毕，给新增按钮设置点击事件
  			$("#emp_add_btn").click(function(){
  				
  				//首先清空表单数据
  				reset_form("#empAddModel form");
  				//查询所有的部门信息
  				getDepts("#dept_add_select");
  				//弹出模态框
  				$("#empAddModel").modal({
  					backdrop:"static"
  				});
  				//给模态框的保存按钮设置点击事件
  				$("#emp_save_btn").click(function(){
  					//对输入的员工的姓名以及邮箱进行验证
  					if(!validate_add_form()){
  						return false;
  					}
  					//判断按钮的自定义属性
  					if($(this).attr("ajax-va")=="fail"){
  						return false;
  					}
  					//在JQuery中给我们提供了一个方法serialize(),可以将表单中的信息转变为Ajax要传递的参数
  					var data1 = $("#empAddModel form").serialize();
  					$.ajax({
  						url:"${app_path}/emp",
  						type:"POST",
  						data:data1,
  						success:function(result){
  							if(result.code==100){
  								$("#empAddModel").modal("hide");
  								to_page(9999);
  							}else{
  								if(undefined != result.extend.errorFields.empName){
  									validate_status_msg("#empName_add_input", "error", result.extend.errorFields.empName);
  								}
  								if(undefined != result.extend.errorFields.email){
  									validate_status_msg("#email_add_input", "error", result.extend.errorFields.email);
  								}
  							}
  							
  						}
  					});
  				});
  				
  				//编写给模态框中的姓名组件添加改变事件
  				$("#empName_add_input").change(function(){
  					//获取员工的姓名
  					var empName = this.value;
  					$.ajax({
  						url:"${app_path}/checkEmp",
  						data:"empName="+empName,
  						type:"POST",
  						success:function(result){
  							if(result.code==100){
  								validate_status_msg("#empName_add_input", "success", result.extend.va_msg);
  								$("#emp_save_btn").attr("ajax-va","success");
  							}else{
  								validate_status_msg("#empName_add_input", "error", result.extend.va_msg);
  								$("#emp_save_btn").attr("ajax-va","fail");
  							}
  						}
  					});
  				});
  			});
  			//给每一个编辑按钮添加点击事件
  			$(document).on("click",".edit_btn",function(){
  				getDepts("#empUpdateModel select");
  				//获取员工的信息
  				getEmp($(this).attr("edit-id"));
  				//对模态框中的更新按钮设置属性
  				$("#emp_update_btn").attr("edit-id",$(this).attr("edit-id"));
  				//显示模态框
  				$("#empUpdateModel").modal({
  					backdrop:"static"
  				});
  				//给更新按钮设置点击事件
  				$("#emp_update_btn").click(function(){
  					//获取员工的邮箱
		  			var email = $("#email_update_input").val();
		  			//编写验证邮箱格式的正则表达式
		  			var regEmail = /^\w+((-\W+)|(\.\w+))*\@[A-Za-z0-9]+((\.\-)[A-Za-z0-9]+)*\.[A-Za-z0-9]+$/;
		  			if(!regEmail.test(email)){
		  				validate_status_msg("#email_update_input", "error", "邮箱的格式不正确");
		  				return false;
		  			}else{
		  				validate_status_msg("#email_update_input", "success", "");
		  			}
		  			//发送更新员工的数据的Ajax请求
		  			var data1 = $("#empUpdateModel form").serialize();
		  			$.ajax({
		  				url:"${app_path}/emp/"+$(this).attr("edit-id"),
		  				type:"PUT",
		  				data:data1,
		  				success:function(result){
		  					//关闭模态框
		  					$("#empUpdateModel").modal("hide");
		  					to_page(currentPage);
		  				}
		  			});
  				});
  			});
  			//给每一个删除按钮添加点击事件
  			$(document).on("click",".delete_btn",function(){
  				//获取要删除的员工的姓名
  				var empName = $(this).parents("tr").find("td:eq(1)").text();
  				//获取要删除的员工的ID
  				var empId = $(this).attr("delete-id");
  				if(confirm("确定删除"+empName+"吗?")){
  					$.ajax({
  						url:"${app_path}/emp/"+empId,
  						type:"DELETE",
  						success:function(result){
  							to_page(currentPage);
  						}
  					});
  				}
  			});
  			//给全选框和每一个复选框添加点击事件
  			$(".check_all").click(function(){
  				$(".check_item").prop("checked",$(this).prop("checked"));
  			});
  			$(document).on("click",".check_item",function(){
  				//判断当前选择的个数是否是所有的复选框个数
  				var flag = $(".check_item:checked").length==$(".check_item").length;
  				$(".check_all").prop("checked",flag);
  			});
  			//给全选删除的按钮添加点击事件
  			$("#emp_delete_btn").click(function(){
  				//获取要删除的员工的姓名
  				var empNames = "";
  				var del_idstr = "";
  				$.each($(".check_item:checked"),function(){
  					empNames+=$(this).parents("tr").find("td:eq(2)").text()+",";
  					del_idstr += $(this).parents("tr").find("td:eq(1)").text()+"-";
  				});
  				empNames = empNames.substring(0,empNames.length-1);
  				del_idstr = del_idstr.substring(0,del_idstr.length-1);
  				
  				if(confirm("确定要删除"+empNames+"吗?")){
  					$.ajax({
  						url:"${app_path}/emp/"+del_idstr,
  						type:"DELETE",
  						success:function(){
  							to_page(currentPage);
  						}
  					});
  				}
  			});
  		});
  		//编写跳转到某一页的函数
  		function to_page(pn){
  			$.ajax({
  				url:"${app_path}/emps",
  				data:"pn="+pn,
  				type:"GET",
  				success:function(result){
  					//1.解析并显示员工的信息
  					build_emp_table(result);
  					//2.解析并显示分页数据
  					build_page_info(result);
  					build_page_nav(result);
  				}
  			
  			});
  		
  		}
  		//编写解析并显示员工的数据的函数
  		function build_emp_table(result){
  			//由于我们现在使用的是Ajax请求，属于异步刷新的请求，不会将整个HTML页面都进行刷新，所以每次在执行之前，我们都需要先将内容进行清空
  			$("#emps_table tbody").empty();
  			//获取员工的数据
  			var emps = result.extend.pageInfo.list;
  			//遍历员工数据的集合
  			$.each(emps,function(index,item){
  				//创建复选框TD
  				var checkTD = $("<td><input type='checkbox' class='check_item'/></td>")
  				//创建员工的编号的TD
  				var empIdTD = $("<td></td>").append(item.empId);
  				//创建员工姓名的TD
  				var empNameTD = $("<td></td>").append(item.empName);
  				//创建员工的性别的TD
  				var empGenderTD = $("<td></td>").append(item.gender=="M"?"男":"女");
  				//创建员工的邮箱TD
  				var empEmailTD = $("<td></td>").append(item.email);
  				//创建员工的部门名称的TD
  				var empDeptNameTD = $("<td></td>").append(item.department.deptName);
  			
  				$("<tr></tr>").append(checkTD).append(empIdTD).append(empNameTD)
  				.append(empGenderTD).append(empEmailTD)
  				.append(empDeptNameTD)
  				.appendTo("#emps_table tbody");
  				
  				
  			});
  		}
  		//编写解析并显示分页信息的函数
  		var currentPage=1;
  		function build_page_info(result){
  			//由于我们现在使用的是Ajax请求，属于异步刷新的请求，不会将整个HTML页面都进行刷新，所以每次在执行之前，我们都需要先将内容进行清空
  			$("#page_info_area").empty();
  			$("#page_info_area").append("当前第:"+result.extend.pageInfo.pageNum+"页,总共:"+result.extend.pageInfo.pages+"页,总记录数:"+result.extend.pageInfo.total);
  			currentPage=result.extend.pageInfo.pageNum;
  		}
  		//编写解析并显示分页条的函数
  		function build_page_nav(result){
  			//由于我们现在使用的是Ajax请求，属于异步刷新的请求，不会将整个HTML页面都进行刷新，所以每次在执行之前，我们都需要先将内容进行清空
  			$("#page_nav_area").empty();
  			
  			//创建ul标签
  			var ul = $("<ul></ul>").addClass("pagination");
  			//创建首页的LI
  			var firstPageLi = $("<li></li>").append($("<a></a>").append("首页").attr("href","#"));
  			//创建尾页的LI
  			var lastPageLi = $("<li></li>").append($("<a></a>").append("尾页").attr("href","#"));
  			//创建前一页LI
  			var prePageLi = $("<li></li>").append($("<a></a>").append("&laquo;"));
  			//创建下一页LI
  			var nextPageLi = $("<li></li>").append($("<a></a>").append("&raquo;"));
  			//判断是否存在前一页
  			if(result.extend.pageInfo.hasPreviousPage==false){//没有前一页
  				firstPageLi.addClass("disabled");
  				prePageLi.addClass("disabled");
  			}else{
  				//给首页添加点击事件
  				firstPageLi.click(function(){
  					to_page(1);
  				});
  				//给前一页添加点击事件
  				prePageLi.click(function(){
  					to_page(result.extend.pageInfo.pageNum-1);
  				});
  			}
  			//判断是否存在下一页
  			if(result.extend.pageInfo.hasNextPage==false){//没有下一页
  				lastPageLi.addClass("disabled");
  				nextPageLi.addClass("disabled");
  			}else{
  				lastPageLi.click(function(){
  					to_page(result.extend.pageInfo.pages);
  				});
  				nextPageLi.click(function(){
  					to_page(result.extend.pageInfo.pageNum+1);
  				});
  			}
  			//将首页以及前一页添加到UL中
  			ul.append(firstPageLi).append(prePageLi);
  			//创建显示页数的LI
  			$.each(result.extend.pageInfo.navigatepageNums,function(index,item){
  				var numLi = $("<li></li>").append($("<a></a>").append(item));
  				//判断显示的页码是否是当前的页码
  				if(result.extend.pageInfo.pageNum==item){
  					numLi.addClass("active");
  				}
  				//每一个页码添加点击事件
  				numLi.click(function(){
  					to_page(item);
  				});
  				//将页码添加到UL
  				ul.append(numLi);
  			});
  			//将下一页以及尾页添加到UL
  			ul.append(nextPageLi).append(lastPageLi);
  			//创建导航条nav并添加到DIV中
  			var nav = $("<nav></nav>").append(ul);
  			nav.appendTo("#page_nav_area");
  		}
  		//编写查询部门信息的函数
  		function getDepts(ele){
  			$(ele).empty();
  			$.ajax({
  				url:"${app_path}/depts",
  				type:"GET",
  				success:function(result){
  					$.each(result.extend.depts,function(){
  						var option = $("<option></option>").append(this.deptName).attr("value",this.deptId);
  						option.appendTo($(ele));
  					});
  				}
  			});
  		}
  		//编写校验成功或者失败的显示信息的方法、
  		function validate_status_msg(ele,status,msg){
  			//首先将元素的状态清空
  			$(ele).parent().removeClass("has-success has-error");
  			$(ele).next("span").text("");
  			if(status=="success"){
  				//使用BootStrap提供的成功的显示，向输入框的下面添加一个span<span id="helpBlock2" class="help-block">
  				$(ele).parent().addClass("has-success");
  				$(ele).next("span").text(msg);
  			}else{
  				$(ele).parent().addClass("has-error");
  				$(ele).next("span").text(msg);
  			}
  		
  		}
  		//编写验证输入数据的方法
  		function validate_add_form(){
  			//获取员工的姓名
  			var empName = $("#empName_add_input").val();
  			//编写验证员工姓名的正则表达式
  			var regName=/^[0-9a-zA-Z][0-9a-zA-Z_.-]{2,16}[0-9a-zA-Z]$/;
  			if(!regName.test(empName)){
  				validate_status_msg("#empName_add_input", "error", "员工的姓名的格式不正确");
  				return false;
  			}else{
  				validate_status_msg("#empName_add_input", "success", "");
  			}
  			//获取员工的邮箱
  			var email = $("#email_add_input").val();
  			//编写验证邮箱格式的正则表达式
  			var regEmail = /^\w+((-\W+)|(\.\w+))*\@[A-Za-z0-9]+((\.\-)[A-Za-z0-9]+)*\.[A-Za-z0-9]+$/;
  			if(!regEmail.test(email)){
  				validate_status_msg("#email_add_input", "error", "邮箱的格式不正确");
  				return false;
  			}else{
  				validate_status_msg("#email_add_input", "success", "");
  			}
  			return true;
  		}
  		//编写清空表单数据以及状态的方法
  		function reset_form(ele){
  			$(ele)[0].reset();
  			$(ele).find("*").removeClass("has-error has-success");
  			$(ele).find(".help-block").text("");
  		}
  		//添加获取员工的方法
  		function getEmp(id){
  			$.ajax({
  				url:"${app_path}/emp/"+id,
  				type:"GET",
  				success:function(result){
  					//获取查询到的员工
  					var empData = result.extend.emp;
  					$("#empName_update_static").text(empData.empName);
  					$("#empName_update_input").val(empData.empName);
  					$("#email_update_input").val(empData.email);
  					$("#empUpdateModel input[name=gender]").val([empData.gender]);
  					$("#empUpdateModel select").val([empData.dId]);
  				}
  			});
  		}
  	</script>
  
  </head>
  
  <body>
		<!-- 员工添加的模态框 -->
		<div class="modal fade" id="empAddModel" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
		  <div class="modal-dialog" role="document">
		    <div class="modal-content">
		      <div class="modal-header">
		        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
		        <h4 class="modal-title" id="myModalLabel">添加员工</h4>
		      </div>
		      <div class="modal-body">
		        	<!-- 添加表单 -->
		        	<form class="form-horizontal">
						  <div class="form-group">
						    <label  class="col-sm-2 control-label">empName:</label>
						    <div class="col-sm-10">
						      <input type="text" class="form-control" name="empName" id="empName_add_input" placeholder="empName">
						    	<span id="empName_span" class="help-block"></span>
						    </div>
						  </div>
						  <div class="form-group">
						    <label  class="col-sm-2 control-label">email:</label>
						    <div class="col-sm-10">
						      <input type="text" class="form-control" name="email" id="email_add_input" placeholder="email@oracle.com">
						  	<span id="email_span" class="help-block"></span>
						    </div>
						  </div>
						  <div class="form-group">
						    <label  class="col-sm-2 control-label">gender:</label>
						    <div class="col-sm-10">
						     <label class="radio-inline">
							    <input type="radio" name="gender" id="gender1_add_input" value="M" checked>男
							  </label>
							  <label class="radio-inline">
							    <input type="radio" name="gender" id="gender2_add_input" value="F" >女
							  </label>
						    </div>
						  </div>
						   <div class="form-group">
						    <label  class="col-sm-2 control-label">deptName:</label>
						    <div class="col-sm-10">
						     <select class="form-control" name="dId" id="dept_add_select">
							 </select>
						    </div>
						  </div>
						</form>
		      </div>
		      <div class="modal-footer">
		        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
		        <button type="button" class="btn btn-primary" id="emp_save_btn">保存</button>
		      </div>
		    </div>
		  </div>
		</div>
  		<!-- 员工修改的模态框 -->
		<div class="modal fade" id="empUpdateModel" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
		  <div class="modal-dialog" role="document">
		    <div class="modal-content">
		      <div class="modal-header">
		        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
		        <h4 class="modal-title" id="myModalLabel">修改员工</h4>
		      </div>
		      <div class="modal-body">
		        	<!-- 添加表单 -->
		        	<form class="form-horizontal">
						  <div class="form-group">
						    <label  class="col-sm-2 control-label">empName:</label>
						    <div class="col-sm-10">
						     <p class="form-control-static"  id="empName_update_static"></p>
						    	<input type="hidden" name="empName" id="empName_update_input"/>
						    </div>
						  </div>
						  <div class="form-group">
						    <label  class="col-sm-2 control-label">email:</label>
						    <div class="col-sm-10">
						      <input type="text" class="form-control" name="email" id="email_update_input" placeholder="email@oracle.com">
						  	<span id="email_span" class="help-block"></span>
						    </div>
						  </div>
						  <div class="form-group">
						    <label  class="col-sm-2 control-label">gender:</label>
						    <div class="col-sm-10">
						     <label class="radio-inline">
							    <input type="radio" name="gender" id="gender1_update_input" value="M" checked>男
							  </label>
							  <label class="radio-inline">
							    <input type="radio" name="gender" id="gender2_update_input" value="F" >女
							  </label>
						    </div>
						  </div>
						   <div class="form-group">
						    <label  class="col-sm-2 control-label">deptName:</label>
						    <div class="col-sm-10">
						     <select class="form-control" name="dId" id="dept_update_select">
							 </select>
						    </div>
						  </div>
						</form>
		      </div>
		      <div class="modal-footer">
		        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
		        <button type="button" class="btn btn-primary" id="emp_update_btn">更新</button>
		      </div>
		    </div>
		  </div>
		</div>
  
  <div class="container">
  		<div class="row">
		  	<div class="col-md-12">
		  		<H1>SSM-CURD</H1>
		  	</div>
		</div>
		
		<!-- 显示员工的数据 -->
		<div class="row">
		  	<div class="col-md-12">
		  		<table class="table table-hover" id="emps_table">
				 	<thead>
				 		<tr>
				 			<th><input type="checkbox" class="check_all"/></th>
				 			<th>员工的编号:</th>
				 			<th>员工的姓名:</th>
				 			<th>员工的性别:</th>
				 			<th>员工的邮箱:</th>
				 			<th>员工的部门:</th>
				 			<th>操作:</th>
				 		</tr>
				 	</thead>
				 	<tbody>
				 		
				 	</tbody>
				</table>
		  	</div>
		</div>
		<!-- 显示分页的信息 -->
		<div class="row">
			<!-- 分页的文字信息 -->
		  	<div class="col-md-6" id="page_info_area">
		  		
		  	</div>
		  	<!-- 分页条 -->
		  	<div class="col-md-6" id="page_nav_area">
		  		
		  	</div>
		</div>
  	</div>
   
  </body>
</html>
