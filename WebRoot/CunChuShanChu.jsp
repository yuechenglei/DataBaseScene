<%@ page language="java" import="java.util.*,java.sql.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>XiuGaiAnJian.jsp' starting page</title>
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
  
<body><div><br></div>
<form name="yhlb" action="jspcl/ModifyInspector.jsp?" >
	<table     width="100%" border="1">
		<tr height="30" style="background-color: #EEE;">
			<td align="center" colspan="7" height="30" >存 储 介 质 列 表<strong></strong></td>
		</tr>
		<tr height="30" >
			<td height="30" style="background-color: #EEE;"><font color="#333">存储介质名称</font></td>
			<td style="background-color: #EEE;"><font color="#333">类型</font></td>
			<td height="30" style="background-color: #EEE;"><font color="#333">位置</font></td>
			<td style="background-color: #EEE;"><font color="#333">建立日期</font></td>
			<td style="background-color: #EEE;" valign="top">操作</td>			
		</tr>
			
<% 
	String className="com.mysql.jdbc.Driver";
	String url="jdbc:mysql://localhost:3306/scene";
	String user="root";
	String password=db.DBInfo.getPassword();
	Class.forName(className);
	Connection conn=DriverManager.getConnection(url, user, password);
	Statement s=conn.createStatement();

	String sql="select name, type, location, date, id from scene.Storage"; 
	ResultSet rs=s.executeQuery(sql); 
    while (rs.next()) {
%> 
  		<tr > 
    		<td ><%=rs.getString(1) %></td> 
    		<td ><%=rs.getString(2) %></td> 
    		<td ><%=rs.getString(3) %></td> 
    		<td ><%=rs.getString(4) %></td> 
    		<td ><a href="jspcl/ModifyStorage.jsp?op=delete&id=<%=rs.getString(5)%>">删除</a></td>
    	</tr> 
<%
	} 
%> 
			
	</table>
</form>
<br />
<a href="bench.jsp"><font color="#000000">返 回</font></a>
	
<% 
    rs.close(); 
    conn.close(); 
%>   
</body>
</html>
