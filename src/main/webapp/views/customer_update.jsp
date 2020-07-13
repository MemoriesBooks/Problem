<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'customer_update.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->

  </head>
  
  <body>
  <form action="customer_update_get" method="get">
   <input type="hidden" name="user_id" value="${customer_user.user_id}" /><br>
    用户账号:<input type="text" name="user_code" value="${customer_user.user_code}"/><br>
    用户名称：<input type="text" name="user_name" value="${customer_user.user_name}"/><br>
    用户密码：<input type="text" name="user_password" value="${customer_user.user_password}"/><br>
    用户状态:<input type="text" name="user_state" value="${customer_user.user_state}"/><br>
    用户年龄:<input type="text" name="user_age" value="${customer_user.user_age}"/><br>
    用户性别：<input type="text" name="user_sex" value="${customer_user.user_sex}"/><br>        
    	<input type="submit" value="提交"/>    
  </form>
  </body>
</html>
