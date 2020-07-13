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
  </head>
  
  <body>
  <div class="container">
  		<div class="row">
		  	<div class="col-md-12">
		  		<H1>SSM-CURD</H1>
		  	</div>
		</div>
		<div class="row">
		  	<div class="col-md-4 col-md-offset-10">
		  		<button type="button" class="btn btn-primary">新建</button>
		  		<button type="button" class="btn btn-danger">删除</button>
		  	</div>
		</div>
		<!-- 显示员工的数据 -->
		<div class="row">
		  	<div class="col-md-12">
		  		<table class="table table-hover">
				 	<thead>
				 		<tr>
				 			<th>员工的编号:</th>
				 			<th>员工的姓名:</th>
				 			<th>员工的性别:</th>
				 			<th>员工的邮箱:</th>
				 			<th>员工的部门:</th>
				 			<th>操作:</th>
				 		</tr>
				 	</thead>
				 	<tbody>
				 		<c:forEach items="${pageInfo.list }" var="emp">
				 			<tr>
				 			<th>${emp.empId}</th>
				 			<th>${emp.empName}</th>
				 			<th>${emp.gender=="M"?"男":"女"}</th>
				 			<th>${emp.email}</th>
				 			<th>${emp.department.deptName}</th>
				 			<th>
				 				<button type="button" class="btn btn-success"><span class="glyphicon glyphicon-pencil" aria-hidden="true">修改</span></button>
				 				<button type="button" class="btn btn-danger"><span class="glyphicon glyphicon-trash" aria-hidden="true">删除</span></button>
				 			</th>
				 		</tr>
				 		</c:forEach>
				 	</tbody>
				</table>
		  	</div>
		</div>
		<!-- 显示分页的信息 -->
		<div class="row">
			<!-- 分页的文字信息 -->
		  	<div class="col-md-6">
		  		当前第:${pageInfo.pageNum}页,总共:${pageInfo.pages}页，总记录数:${pageInfo.total}
		  	</div>
		  	<!-- 分页条 -->
		  	<div class="col-md-6">
		  		<nav aria-label="Page navigation">
				  <ul class="pagination">
				   		<li><a href="${app_path}/emps?pn=1">首页</a></li>
				   		<c:if test="${pageInfo.hasPreviousPage}">
				   			<li>
						      <a href="${app_path}/emps?pn=${pageInfo.pageNum-1}" aria-label="Previous">
						        <span aria-hidden="true">&laquo;</span>
						      </a>
						    </li>
				   		</c:if>
				   		<c:forEach items="${pageInfo.navigatepageNums}" var="pageNum">
				   			<c:if test="${pageNum==pageInfo.pageNum}">
				   				<li class="active"><a href="#">${pageNum}</a></li>
				   			</c:if>
				   			<c:if test="${pageNum!=pageInfo.pageNum}">
				   				<li><a href="${app_path}/emps?pn=${pageNum}">${pageNum}</a></li>
				   			</c:if>
				   		</c:forEach>
				   		<c:if test="${pageInfo.hasNextPage}">
				   			<li>
						      <a href="${app_path}/emps?pn=${pageInfo.pageNum+1}" aria-label="Next">
						        <span aria-hidden="true">&raquo;</span>
						      </a>
						    </li>
				   		</c:if>
				   		<li><a href="${app_path}/emps?pn=${pageInfo.pages}">尾页</a></li>
				  </ul>
				</nav>
		  	</div>
		</div>
  	</div>
   
  </body>
</html>
