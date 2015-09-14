<%@ page language="java" import="java.util.*,dao.LogDAO" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    <link rel="stylesheet" href="//cdn.bootcss.com/bootstrap/3.3.5/css/bootstrap.min.css">
    <title>恢复操作</title>
    
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
  <%
  	String id1 = request.getParameter("id");
  	int border_id = Integer.parseInt(id1);
  	LogDAO lg = new LogDAO();
  	int max_id = lg.last_id();
  	while(max_id>=border_id){
  		lg.del_and_rec(max_id);
  		max_id--;
  	}
  	out.print("<p>恢复成功！</p>");
  %>
  </body>
</html>
