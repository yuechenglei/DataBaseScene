<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">
<link rel="stylesheet"
	href="//cdn.bootcss.com/bootstrap/3.3.5/css/bootstrap.min.css">
<title>现场照片管理系统</title>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">

<%
	//response.sendRedirect("PicEdit.jsp?photo_id=1");
%>
<%
	//response.sendRedirect("login.jsp?first=true");
%>
</head>
<frameset rows="50,*" frameborder="no" border="0">
	<frame src="topmenu.jsp" name="topmenu" scrolling="no" />
	<frameset cols="163,*" frameborder="no" border="0">
		<frame src="menu.jsp" name="menu" scrolling="yes" marginwidth="5"
			marginheight="5" />
		<frame src="bench.jsp" id="bench-id" name="bench" scrolling="yes"
			marginwidth="0" marginheight="0" />
	</frameset>
</frameset>
</html>

