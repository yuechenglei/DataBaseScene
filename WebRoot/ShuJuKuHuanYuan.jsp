<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'ShuJuKuHuanYuan.jsp' starting page</title>
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
  
<body bgcolor=#000000>
<br />
<br />
<br />

<form  method='POST' enctype="multipart/form-data" action="jspcl/RestoreFromFile.jsp?op=abc">
<table class="content" border="1" align="center" bordercolor="#333" cellspacing="1" cellpadding="10" style="background-color:#eee;   border-width:1px; width:500; align:center" >
	<tr>
		<td align="center" style="margin:5px">数 据 恢 复</td>
	</tr>
	<tr style="height:60">
		<td>
		注意：恢复数据库操作将破坏当前正在运行的数据
		</td>	
	</tr>
	<tr style="height:60">
		<td >选择用于恢复的文件
		<input type="file" name="fname"></td>
	</tr>
	<tr style="height:60">
		<td align="right" ><input type=submit value=" 上  传 "></td>
	</tr>
</table>
</form>
  </body>
</html>
