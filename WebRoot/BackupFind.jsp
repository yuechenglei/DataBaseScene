<%@ page language="java" import="java.util.*,java.sql.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
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
<br />
<form name="yhlb">
	<table     width="100%" border="1">
		<tr height="30" style="background-color: #EEE;">
			<td align="center" colspan="5" >备 份 列 表<strong></strong></td>
		</tr>
		<tr height="30" style="background-color: #EEE;">
			<td ><font color="#333">备份名称</font></td>
			<td ><font color="#333">日期</font></td>
			<td ><font color="#333">存储设备</font></td>
			<td ><font color="#333">文件名</font></td>
			<td ><font color="#333">注释</font></td>
		</tr>
<%
	String className="com.mysql.jdbc.Driver";
	String url="jdbc:mysql://localhost:3306/scene";
	String user="root";
	String password=sdu.edu.scene.db.DBInfo.getPassword(), sname;
	Class.forName(className);
	Connection conn=DriverManager.getConnection(url, user, password);
	Statement s = conn.createStatement();
	Statement s1 = conn.createStatement();

	String sql="select name, date, filename, storage_id, description from backuplist"; 
	ResultSet rs1, rs;
	rs = s.executeQuery(sql); 
    while (rs.next()) {
%>   
  		<tr > 
    		<td ><%=rs.getString("name") %></td> 
    		<td ><%=rs.getString("date") %></td> 
    		<%
    			sql = "select name, id from storage where id="+rs.getString("storage_id");
				rs1 = s1.executeQuery(sql); 
				if (rs1.next())
					sname = rs1.getString("name");
				else
					sname = "";
				rs1.close();
    		 %>
    		<td ><%=sname%></td> 
    		<td ><%=rs.getString("filename") %></td> 
    		<td ><%=rs.getString("description")%></td> 
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
