<%@ page language="java" import="java.util.*,sdu.edu.scene.dao.LogDAO,java.sql.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>数据恢复</title>
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
  
  <body>
  <table width="100%" cellpadding="5" border="1" style="font-family:幼圆">
  <tr><td colspan="7" align="center">操作日志</td></tr>
  <tr>
  <td>ID</td>
  <td>操作时间</td>
  <td>操作符</td>
  <td>旧属性</td>
  <td>新属性</td>
  <td>操作员</td>
  <td>恢复点</td>
  </tr>
  	<%
  		LogDAO ld = new LogDAO();
  		ResultSet rs = ld.query_all();
  	%>
  	<% 
  		while(rs.next()){
  			String id = rs.getString(1);
  			String time = rs.getString(2);
  			String operation = rs.getString(3);
  			String oldvalue = rs.getString(4);
  			String newvalue = rs.getString(5);
  			String user_id = rs.getString(6);
  	%>
  	<tr>
  	<td><%=id %></td>
  	<td><%=time %></td>
  	<td><%=operation %></td>
  	<td><%=oldvalue %></td>
  	<td><%=newvalue %></td>
  	<td><%=user_id %></td>
  	<td><a href="recovery.jsp?id=<%=id%>">恢复</a></td>
  	</tr>
  	<%
  		}
  	%>
  	</table>
  </body>
</html>
