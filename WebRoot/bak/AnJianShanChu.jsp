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
	if (yhlb.ajid.value=="") {
		alert("请输入案件编号");
		return false;
	}	
}
</script>

</head>
  
<body><div><br></div>
<form name="yhlb" action="AnJianShanChu.jsp?" >
	<table width="100%" >
		<tr height="30" style="background-color: rgb(45, 232, 236);">
			<td align="center" colspan="5">查 询 条 件<strong></strong></td>
		</tr>
		<tr height="25" >
			<td  border="1">案件名称<input type="text" onblur="validateLength1(this)" value=""  maxlength="30" name="name"></td>
			<td  border="1">勘验人<input type="text" onblur="validateLength1(this)" value=""  maxlength="30" name="inspector"></td>
			<td  border="1">开始日期<input type="text" onblur="validateLength1(this)" value=""  maxlength="30" name="date1"></td>			
			<td  border="1">结束日期<input type="text" onblur="validateLength1(this)" value=""  maxlength="30" name="date2"></td>			
			<td><input type="submit" value="查询" return onclick="func()"></td>
		</tr>
	</table>
	<table     width="100%" border="1">
		<tr height="30" style="background-color: rgb(45, 232, 236);">
			<td align="center" colspan="7" height="30" >案 件 列 表<strong></strong></td>
		</tr>
		<tr height="30" >
			<td height="30" style="background-color: rgb(128, 255, 255);"><font color="#0080ff">案件名称</font></td>
			<td style="background-color: rgb(128, 255, 255);"><font color="#0080ff">立案日期 </font></td>
			<td style="background-color: rgb(128, 255, 255);"><font color="#0080ff">勘验人</font></td>
			<td style="background-color: rgb(128, 255, 255);"><font color="#0080ff">现勘号</font></td>
			<td style="background-color: rgb(128, 255, 255);" valign="top">操作</td>			
		</tr>
			
<%
				String name=request.getParameter("name");
				String inspector=request.getParameter("inspector");
				String date1=request.getParameter("date1");
				String date2=request.getParameter("date2");
				String className="com.mysql.jdbc.Driver";
				String url="jdbc:mysql://localhost:3306/scene";
				String user="root";
				String password=sdu.edu.scene.db.DBInfo.getPassword();
				Class.forName(className);
				Connection conn=DriverManager.getConnection(url, user, password);
				String id=request.getParameter("id");
				Statement s=conn.createStatement();

				String sql="select name, date, inspector, xkh, id from scene.case "; 
				String	s1="", s2="", s3="", s4="", ss="", str="";

				ss = "";
				if (!name.isEmpty()) {
					str = str + " name='" + name + "'";
					ss = " AND ";
				}
				if (!inspector.isEmpty()) {
					str = str + ss + "inspector='" + inspector + "'";
					ss = " AND ";
				}
				if (!date1.isEmpty()) {
					str = str + ss + "date>='" + date1 + "'";
					ss = " AND ";
				}
				if (!date2.isEmpty())
					str = str + ss + "date<='" + date2 + "'";
				if (!str.isEmpty())
					sql = sql + " where " + str;

				ResultSet rs=s.executeQuery(sql);
			%>
<%
    while (rs.next()) {
%> 
  		<tr > 
    		<td ><%=rs.getString(1) %></td> 
    		<td ><%=rs.getString(2) %></td> 
    		<td  ><%=rs.getString(3) %></td> 
    		<td ><%=rs.getString(4) %></td> 
    		<td ><a href="jspcl/ModifyCase.jsp?op=delete&id=<%=rs.getString(5)%>">删除</a></td>
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
