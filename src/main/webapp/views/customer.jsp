<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	String path = request.getContextPath();
String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<%
	response.setHeader("Cache-Control", "no-store");
response.setHeader("Pragrma", "no-cache");
response.setDateHeader("Expires", 0);
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache, must-revalidate">
<meta http-equiv="expires" content="0">
<title>用户界面</title>
<script src="${pageContext.request.contextPath}/js/jquery-1.11.3.min.js">
	
</script>
<script language="JavaScript">
	window.onpageshow = function(event) {
		if (event == 0) {
			window.location.reload()
		}
	};
</script>
</head>

<body>
	用户姓名:${USER_SESSION.user_name}
	<br> 用户年龄:${USER_SESSION.user_age}
	<br> 用户性别:${USER_SESSION.user_sex}
	<br>
	<a href="indexLimit">员工</a>
	<a href="enduser">退出登录</a>
</body>
</html>