<%@ page language="java" import="java.util.*,java.sql.*"
	pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">

<title>XiuGaiAnJian.jsp' starting page</title>
<link rel="stylesheet"
	href="//cdn.bootcss.com/bootstrap/3.3.5/css/bootstrap.min.css">
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
<style>
table {
	margin-top: 20px;
	margin: auto;
}
</style>
</head>

<body
	style="background=#aaaaaa; text-align:center; margin:80px,0px,0px,0px;">
	<form name="yhlb">
		<table width="40%" border="1"
			style="text-align:center;background-color:#cccccc">
			<tr height="30" style="background-color: #EEE;">
				<td align="center" colspan="2" height="30">用 户 列 表<strong></strong></td>
			</tr>
			<tr height="30">
				<td width="50%" style="background-color: #EEE;"><font
					color="#333">用户账号</font></td>
				<td width="50%" style="background-color: #EEE;"><font
					color="#333">用户名</font></td>
			</tr>
			<%
				String className = "com.mysql.jdbc.Driver";
				String url = "jdbc:mysql://localhost:3306/scene";
				String user = "root";
				String password = db.DBInfo.getPassword();
				Class.forName(className);
				Connection conn = DriverManager.getConnection(url, user, password);
				Statement s = conn.createStatement();

				String sql = "select account, name, id from scene.inspector";
				ResultSet rs = s.executeQuery(sql);
				while (rs.next()) {
			%>
			<tr>
				<td><%=rs.getString(1)%></td>
				<td><%=rs.getString(2)%></td>
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
	<a href="bench.jsp">返 回</a>
</body>
</html>
