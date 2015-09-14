<%@ page language="java" import="java.util.*,java.sql.*, java.io.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'BeiFen.jsp' starting page</title>
    <link rel="stylesheet" href="//cdn.bootcss.com/bootstrap/3.3.5/css/bootstrap.min.css">
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->

</head>

<%
String stmt="C:\\Program Files\\MySQL\\MySQL Server 5.6\\bin\\mysqldump scene --hex-blob -uroot -pycl,,123 --result-file=d:x.sql";
System.out.println(stmt);
System.out.println(basePath);
try {
	Runtime.getRuntime().exec(stmt);
}
catch (IOException e) {
	e.printStackTrace();
}
%>
  
<body>
</body>
</html>
