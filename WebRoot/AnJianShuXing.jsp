<%@ page language="java" import="java.util.*,java.sql.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>AnJianShuXing.jsp' starting page</title>
    <link rel="stylesheet" href="//cdn.bootcss.com/bootstrap/3.3.5/css/bootstrap.min.css">
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">

	<link rel="stylesheet" type="text/css" href="myform1.css">

<script type="text/javascript">
function func()
{		
	if (anjian.id.value=="") {
		alert("请填写案件编号");
		return false;
	}
	if (anjian.name.value=="") {
		alert("请填写案件名称");
		return false;
	}
	/*if (anjian.date.value=="") {
		alert("请填写立案日期");
		return false;
	}*/
	if (anjian.inspector.value=="") {
		alert("请填写勘验人");
		return false;
	}
	if (anjian.xkh.value=="") {
		alert("请填写现勘号");
		return false;
	}
	if (anjian.date_anfa.value=="") {
		alert("请填写案发时间");
		return false;
	}
	if (anjian.place.value=="") {
		alert("请填写案发地点");
		return false;
	}
	if (anjian.desc.value=="") {
		alert("请填写简要说明");
		return false;
	}
}
</script>
</head>
  
<body text="#000000" style="background-color:#eee;margin:100px,0px,0px,0px;">
<%
	String name, xkh, inspector, op, date_anfa, place, desc;
	String id=request.getParameter("id");
	if (id.equals("-1")) {
		name = "";
		inspector = "";
		xkh = "";
		op = "insert";
		date_anfa = "";
		place = "";
		desc = "";
	}
	else {
		String className="com.mysql.jdbc.Driver";
		String url="jdbc:mysql://localhost:3306/scene";
		String user="root";
		String password=sdu.edu.scene.db.DBInfo.getPassword();
		Connection conn; 
		Statement st;
		Class.forName(className);
		conn=DriverManager.getConnection(url, user, password);
		String sql="select * from scene.case where id='"+id+"'"; 
		Statement s=conn.createStatement();
    	ResultSet rs=s.executeQuery(sql); 
		rs.next();
		name = rs.getString(2);
		inspector = rs.getString(4);
		xkh = rs.getString(5);
		date_anfa = rs.getString(8);
		place = rs.getString(9);
		desc = rs.getString(10);
		op = "modify";
	}
%>

<form name="anjian" method="post" action="jspcl/ModifyCase.jsp?op=<%=op %>&id=<%=id %>">
	<table class="content table" border="1" align="center" bordercolor="#CCC" cellspacing="1" cellpadding="10" style="  width:550; align:center">
			<tr style="height:60; background-color:#ccccff">
				<td class="head" colspan="3" style="font-family:幼圆;font-size=20;text-align:center"> 
					案 件 信 息
				</td>
			</tr>
			<tr style="height:50">
				<td style="margin:10;font-size=16;font-family:幼圆;text-align:right;">
					案件名称
				</td>
				<td align="left" width="" >
					<input type="text" name="name" maxlength="64" size="40" value="<%=name%>">
					<font color="red">*</font>
				</td>
			</tr>
			<tr style="height:50">
				<td style="margin:10;font-size=16;font-family:幼圆;text-align:right"> 
					勘验人
				</td>
				<td align="left">
					<input type="text" name="inspector" maxlength="16" size="40" value="<%=inspector%>">
					<font color="red"> *</font>
				</td>
			</tr>
			<tr style="height:50">
				<td style="margin:30px;font-size=16;font-family:幼圆;text-align:right"> 
					现勘号 
				</td>
				<td height="30" align="left" width=“”>
					<input type="text" name="xkh" maxlength="64" size="40" value="<%=xkh%>">
					<font color="red">*</font>
				</td>
			</tr>
			<tr style="height:50">
				<td style="margin:30px;font-size=16;font-family:幼圆;text-align:right"> 
					案发时间 
				</td>
				<td height="30" align="left" width=“”>
					<input type="text" name="date_anfa" maxlength="64" size="40" value="<%=date_anfa%>">
					<font color="red">*</font><font size="1">(格式：XXXX-XX-XX)</font>
				</td>
			</tr>
			<tr style="height:50">
				<td style="margin:30px;font-size=16;font-family:幼圆;text-align:right"> 
					案发地点
				</td>
				<td height="30" align="left" width=“”>
					<input type="text" name="place" maxlength="64" size="40" value="<%=place%>">
					<font color="red">*</font>
				</td>
			</tr>
			<tr style="height:50">
				<td style="margin:30px;font-size=16;font-family:幼圆;text-align:right"> 
					简要说明
				</td>
				<td height="30" align="left" width=“”>
					<input type="text" name="desc" maxlength="64" size="40" value="<%=desc%>">
					<font color="red">*</font>
				</td>
			</tr>
			<tr style="height:60">
				<td align="center" colspan="3">
					<input class="button" type="submit" name="btnSub" value=" 提 交 "
						onclick="return func()" />
					&nbsp;&nbsp;&nbsp;&nbsp;
					<input type="button" onClick="history.go(-1)" value=" 返 回 ">
				</td>
			</tr>
	</table>
</form>
  
</body>
</html>
