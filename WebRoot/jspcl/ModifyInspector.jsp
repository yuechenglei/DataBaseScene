<%@ page language="java"
	import="java.util.*,java.sql.*, java.text.SimpleDateFormat"
	pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!-- 管理员修改Inspector的信息 -->
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">

<title>modify case</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->


<%
	String sql = "", id;
	String account;
	int ret = 0;
	Class.forName("com.mysql.jdbc.Driver").newInstance();
	Connection con = DriverManager
			.getConnection("jdbc:mysql://localhost:3306/scene?user=root&password="
					+ sdu.edu.scene.db.DBInfo.getPassword());
	String op = request.getParameter("op");
	Statement s = con.createStatement();
	ResultSet rs;
	if (op.equals("delete")) {
		id = request.getParameter("id");
		sql = "DELETE FROM `scene`.`inspector` WHERE `id`='" + id
				+ "';";
		ret = 50;
	} else {
		if (op.equals("insert")) {
			String name = request.getParameter("name");
			account = request.getParameter("account");
			String pw1 = request.getParameter("password");
			sql = "INSERT INTO `scene`.`inspector` (`account`, `name`, `password`) VALUES ('"
					+ account + "', '" + name + "', '" + pw1 + "')";
			ret = 60;
		} else {
			if (op.equals("modify")) {
				sql = "select * from inspector where id='"
						+ session.getAttribute("LoginId")
						+ "' AND password='"
						+ request.getParameter("oldPwd") + "'";
				rs = s.executeQuery(sql);
				if (!rs.next()) {
					response.sendRedirect("BenchPrompt.jsp?result=1");
					return;
				}
				sql = "update inspector set password='"
						+ request.getParameter("newPwd")
						+ "' where id='"
						+ session.getAttribute("LoginId") + "'";
				ret = 90;
			} else {
				con.close();
				response.sendRedirect("BenchPrompt.jsp?result=0");
			}
		}
	}
	s.executeUpdate(sql);
	ret = ret + s.getUpdateCount();
	String arg = String.valueOf(ret);
	con.close();
	response.sendRedirect("BenchPrompt.jsp?result=" + arg);
%>

</head>
<body>
	sql =
	<%=sql%>
</body>
</html>
