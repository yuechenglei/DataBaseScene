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
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css"> 
	-->
<script type="text/javascript">
function CheckAndSubmit()
{
	var date1 = document.getElementById("date1").value;
	var date2 = document.getElementById("date2").value;
	if (date1!="" && !date1.match("\\d{2,4}-\\d{1,2}-\\d{1,2}")) {
		alert("开始日期格式错误！");
		return false;
	}
	if (date2!="" && !date2.match("\\d{2,4}-\\d{1,2}-\\d{1,2}")) {
		alert("结束日期格式错误！");
		return false;
	}
	ajgl.submit();
}
</script>
<%
	String op=request.getParameter("op");
	String name=request.getParameter("name");
	String inspector=request.getParameter("inspector");
	String date1=request.getParameter("date1");
	String date2=request.getParameter("date2");
%>
</head>
  
<body><div><br></div>
<form name="ajgl" action="AnJianGuanLi.jsp" method="post">
	<table width="100%" border="1" align="center" cellpadding="10" style="font-family:幼圆; border-color:blue; border-style:solid; border-width:2px; align:center">
		<tr height="30" style="background-color: rgb(45, 232, 236);">
			<td align="center" colspan="6">查 询 条 件<strong></strong></td>
		</tr>
		<tr height="25" >
			<td >案件名称<input type="text" onblur="validateLength1(this)" value=""  maxlength="30" name="name"></td>
			<td >勘验人<input type="text" onblur="validateLength1(this)" value=""  maxlength="30" name="inspector"></td>
			<td >开始日期<input type="text" onblur="validateLength1(this)" value=""  maxlength="30" name="date1"></td>			
			<td >结束日期<input type="text" onblur="validateLength1(this)" value=""  maxlength="30" name="date2"></td>			
			<td ><input type="hidden" onblur="validateLength1(this)" value="<%=op%>" name="op"></td>			
			<td><input type="button" onclick="CheckAndSubmit()" value="查询"></td>
		</tr>
	</table>
	<br />
	<table width="100%" cellpadding="5" border="1" style="font-family:幼圆">
		<tr height="30" style="background-color: rgb(45, 232, 236);">
			<td align="center" colspan="5" height="30" >案 件 列 表<strong></strong></td>
		</tr>
		<tr height="30" >
			<td height="30" style="background-color: rgb(128, 255, 255);"><font color="#0080ff">案件名称</font></td>
			<td style="background-color: rgb(128, 255, 255);"><font color="#0080ff">立案日期 </font></td>
			<td style="background-color: rgb(128, 255, 255);"><font color="#0080ff">勘验人</font></td>
			<td style="background-color: rgb(128, 255, 255);"><font color="#0080ff">现勘号</font></td>
<%
if (op.equals("2") || op.equals("3"))
	out.print("<td style=\"background-color: rgb(128, 255, 255);\"><font color=#0080ff>操作</font></td>");
%>
		</tr>
			
<%  //把表格第二行的显示放到while循环中，就可以根据查询结果画出表格了。参数则放在<td>内的相应位置。 


	String className="com.mysql.jdbc.Driver";
	String url="jdbc:mysql://localhost:3306/scene";
	String user="root";
	String password=db.DBInfo.getPassword();
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

System.out.println(sql);
	ResultSet rs=s.executeQuery(sql); 
	while (rs.next()) {
%> 
  		<tr height="30" > 
    		<td ><%=rs.getString(1) %></td> 
    		<td ><%=rs.getString(2) %></td> 
    		<td ><%=rs.getString(3) %></td> 
    		<td ><%=rs.getString(4) %></td> 
<%
if (op.equals("2"))
	out.print("<td ><a href=\"AnJianShuXing.jsp?op=modify&id="+rs.getString(5)+"\">修改</a></td>");
if (op.equals("3"))
	out.print("<td ><a href=\"jspcl/ModifyCase.jsp?op=delete&id="+rs.getString(5)+"\">删除</a></td>");
%>
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
