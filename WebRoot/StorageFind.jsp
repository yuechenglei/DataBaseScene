<%@ page language="java" import="java.util.*,java.sql.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'ChaXunAnJian.jsp' starting page</title>
    <link rel="stylesheet" href="//cdn.bootcss.com/bootstrap/3.3.5/css/bootstrap.min.css">
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
<script type="text/javascript">
function func()
{
	if (Storage.name.value=="") {
		alert("请输入案件编号");
		return false;
	}	
}
</script>
</head>
  
<body><div><br></div>
<form name="Storage" action="StorageFind.jsp?">
	<table    width="100%" >
		<tr height="30" style="background-color: #EEE;">
			<td align="center" colspan="5">查询条件<strong></strong></td>
		</tr>
		<tr height="25" >
			<td  border="1">案件名称<input type="text" onblur="validateLength1(this)" value=""  maxlength="30" name="name"></td>
			
			<td  border="1">开始日期<input type="text" onblur="validateLength1(this)" value=""  maxlength="30" name="date1"></td>			
			<td  border="1">结束日期<input type="text" onblur="validateLength1(this)" value=""  maxlength="30" name="date2"></td>			
			<td><input type="submit" value="查询" return onclick="func()"></td>
		</tr>
	</table>
	<table     width="100%"  border="1">
		<tr height="30" style="background-color: #EEE;">
			<td align="center" colspan="4" height="30" >案 件 列 表<strong></strong></td>
		</tr>
		<tr height="30" >
			<td height="30" style="background-color: #EEE;" width="200"><font color="#333">介质名称</font></td>
			<td style="background-color: #EEE;" width="280"><font color="#333">备份日期 </font></td>
			<td style="background-color: #EEE;" width="280"><font color="#333">介质类型</td>
			<td style="background-color: #EEE;" ><font color="#333">存放地点</font></td>
		</tr>
		</table>
	<div style="overflow-x: auto; overflow-y: auto; height: 350; width:100%;">
	<table     width="100%"  border="1">			
<%  //把表格第二行的显示放到while循环中，就可以根据查询结果画出表格了。参数则放在<td>内的相应位置。 

	String name=request.getParameter("name");
	String location=request.getParameter("location");
	String date1=request.getParameter("date1");
	String date2=request.getParameter("date2");

	String className="com.mysql.jdbc.Driver";
	String url="jdbc:mysql://localhost:3306/scene";
	String user="root";
	String password="ycl,,123";
	Class.forName(className);
	Connection conn=DriverManager.getConnection(url, user, password);
	String id=request.getParameter("id");
	Statement s=conn.createStatement();

	String sql="select name, date, type, location, id from scene.storage "; 
	String	s1="", s2="", s3="", s4="", ss="", str="";

	ss = "";
	
	if (name!=""||!name.isEmpty()) {
		str = str + " name='" + name + "'";
		ss = " AND ";
	}
	
	if (date1!=""||!date1.isEmpty()) {
		str = str + ss + "date>='" + date1 + "'";
		ss = " AND ";
	}
	if (date2!=""||!date2.isEmpty())
		str = str + ss + "date<='" + date2 + "'";
	if (str!=""||!str.isEmpty())
		sql = sql + " where " + str;
	
	ResultSet rs=s.executeQuery(sql); 
	while (rs.next()) {
%> 
  		<tr height="30" > 
    		<td width="200"><%=rs.getString(1) %></td> 
    		<td width="280"><%=rs.getString(2) %></td> 
    		<td  width="280"><%=rs.getString(3) %></td> 
    		<td ><%=rs.getString(4) %></td> 
    	</tr> 
<%
	} 
%> 			
	</table>
	</div>
</form>
	
<% 
    rs.close(); 
    conn.close(); 
%>   
</body>
</html>
