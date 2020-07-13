<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'user_zhuce.jsp' starting page</title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache, must-revalidate">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->

  </head>
  
  <body>
		<form action="createuser"  method="get">
			<div>
			用户名字:<input type="text" id="newUserName" name="username">
			</div>
			<div>
			用户账号:<input type="text" id="newUserCode" name="usercode" maxlength="11">
			</div>
			<div>
			用户密码:<input type="text" id="newUserPassword" name="userpassword" maxlength="11" >
			</div>
			<div>
			用户年龄:<input type="text" id="newUserAge" name="userage">
			</div>
			<div>
			用户性别:<input type="text" id="newUserSex" name="usersex">
			</div>
			<div>
			<button type="submit" onclick="createUser()">创建客户</button>
			<button type="reset">清空</button>
		    </div>
	   </form>
  </body>
</html>
