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
  
<body style="background-color:#666666">
<br />
<form name="yhlb">
	<table width="100%" border="1" style="background-color:#dddddd">
		<tr height="30" style="background-color: #EEE;">
			<td align="center" colspan="5" height="30" >存 储 设 备 列 表<strong></strong></td>
		</tr>
		<tr height="30" >
			<td height="30" style="background-color: #EEE;"><font color="#333">存储介质名</font></td>
			<td style="background-color: #EEE;"><font color="#333">类型</font></td>
			<td height="30" style="background-color: #EEE;"><font color="#333">位置</font></td>
			<td style="background-color: #EEE;"><font color="#333">建立日期</font></td>
			<td height="30" style="background-color: #EEE;"><font color="#333">描述</font></td>
		</tr>
<%
	String className="com.mysql.jdbc.Driver";
	String url="jdbc:mysql://localhost:3306/scene";
	String user="root";
	String password=sdu.edu.scene.db.DBInfo.getPassword();
	Class.forName(className);
	Connection conn=DriverManager.getConnection(url, user, password);
	Statement s=conn.createStatement();

	String sql="select name, type, location, date, description from scene.Storage"; 
	ResultSet rs=s.executeQuery(sql); 
    while (rs.next()) {
%>   
  		<tr height="30"> 
    		<td><%=rs.getString(1) %></td> 
    		<td><%=rs.getString(2) %></td> 
    		<td><%=rs.getString(3) %></td> 
    		<td><%=rs.getString(4) %></td> 
    		<td><%=rs.getString(5) %></td> 
    	</tr> 
<%
	} 
%>
	</table>
<br />
<a href="bench.jsp"><font color="#000000">返 回</font></a>
</form>
	
<% 
    rs.close(); 
    conn.close(); 
%>   
</body>
</html>
