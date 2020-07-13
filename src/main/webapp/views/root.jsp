<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<% 
response.setHeader("Cache-Control","no-store"); 
response.setHeader("Pragrma","no-cache"); 
response.setDateHeader("Expires",0); 
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'root.jsp' starting page</title>
    
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
    亲爱的管理员：${ROOT_SESSION.root_name}您好<br>
    <table border="1"> 
    <tbody> 
      <tr> 
        <th>id</th> 
        <th>账号</th> 
        <th>姓名</th>
        <th>操作</th> 
      </tr> 
        <c:forEach items="${customerList}" var="customer"> 
          <tr> 
            <td>${customer.user_id }</td> 
            <td>${customer.user_code }</td>
            <td>${customer.user_name}</td>
            <td> 
              <a href="<%=basePath%>getuser?userid=${customer.user_id}">编辑</a> 
              <a href="<%=basePath%>deleteuser?delet_userid=${customer.user_id}">删除</a> 
            </td> 
          </tr>        
        </c:forEach> 
    </tbody> 
  </table> 
  <a href="index">员工</a>
   <a href="endroot">退出登录</a>
  </body>
</html>
