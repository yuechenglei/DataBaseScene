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
	<table     width="62%" border="1">
		<tr height="30" style="background-color: #EEE;">
			<td align="center" colspan="7" height="30" >用 户 列 表<strong></strong></td>
		</tr>
		<tr height="30" >
			<td style="background-color: #EEE;"><font color="#333">用户名</font></td>
			<td style="background-color: #EEE;"><font color="#333">用户账号</font></td>
			<td style="background-color: #EEE;"><font color="#333">操作</font></td>			
		</tr>
			
<%
				String className="com.mysql.jdbc.Driver";
				String url="jdbc:mysql://localhost:3306/scene";
				String user="root";
				String password=sdu.edu.scene.db.DBInfo.getPassword();
				Class.forName(className);
				Connection conn=DriverManager.getConnection(url, user, password);
				Statement s=conn.createStatement();

				String sql="select account, name, id from scene.inspector"; 
				ResultSet rs=s.executeQuery(sql); 
			    while (rs.next()) {
			%> 
  		<tr > 
    		<td ><%=rs.getString(1) %></td> 
    		<td ><%=rs.getString(2) %></td> 
    		<td ><a href="jspcl/ModifyInspector.jsp?op=delete&id=<%=rs.getString("id")%>">删除</a></td>
    	</tr> 
<%
	} 
%> 
			
	</table>
</form>
	
<% 
    rs.close(); 
    conn.close(); 
%>   
</body>
</html>
