<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">

<title>My JSP 'root_login.jsp' starting page</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
<title>ROOT登录页面</title>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<script src="${pageContext.request.contextPath}/js/jquery-1.11.3.min.js">
</script>
<meta content="MSHTML 6.00.2600.0" name=GENERATOR>
<script>
// 判断是登录账号和密码是否为空
function check(){
    var usercode = $("#usercode").val();
    var password = $("#password").val();
    if(usercode=="" || password==""){
    	$("#message").text("账号或密码不能为空！");
        return false;
    }  
    return true;
}
</script>
<script type="text/javascript">
//让登录界面无法后退
$(function(){
		　　if(window.history && window.history.pushState){
		　　		$(window).on("popstate", function(){
			　　		window.history.pushState("forward", null, "#");
			　　		window.history.forward(1);
		　　		});
		　　}
		　　window.history.pushState("forward", null, "#"); //在IE中必须得有这两行
		　　window.history.forward(1);
		});
</script>
</head>
<body>
	<div align="center">
		<table border="0" width="1140px" cellspacing="0" cellpadding="0"
			id="table1">
			<tr>
				<td class="login_msg" width="400" align="center">
					<!-- margin:0px auto; 控制当前标签居中 --> 管理员登录界面
					<fieldset style="width: auto; margin: 0px auto;">
						<font color="red"> <%-- 提示信息--%> <span id="message">${msg}</span>
						</font>

						<form action="root_login" method="post" onsubmit="return check()">
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<br />
							<br /> 账&nbsp;号：<input id="usercode" type="text" name="rootcode" />
							<br />
							<br /> 密&nbsp;码：<input id="password" type="password"
								name="rootpassword" /> <br />
							<br /> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 验证码：<input
								type="text" name="verifycode" style="width: 150px"> <a
								href="javascript:refreshCode()"> <img
								src="${pageContext.request.contextPath}/checkCode" id="vcode" />
							</a><br /> <br /> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <input
								type="submit" value="登录" />
						</form>
					</fieldset>
				</td>
			</tr>
		</table>
	</div>
</body>
</html>
