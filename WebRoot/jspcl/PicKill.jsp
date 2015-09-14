<%@ page language="java"
	import="java.util.*,java.sql.*, java.text.SimpleDateFormat"
	pageEncoding="UTF-8"%>
<%@ page import="sdu.edu.scene.dao.LogDAO"%>
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
	String className = "com.mysql.jdbc.Driver";
	String url = "jdbc:mysql://localhost:3306/scene";
	String user = "root";
	String password = sdu.edu.scene.db.DBInfo.getPassword();
	Connection conn;
	Statement st;
	Class.forName(className);
	conn = DriverManager.getConnection(url, user, password);
	st = conn.createStatement();
	String sql = "", id;
	int ret = 0;

	String s[] = request.getParameterValues("cList");
	for (int i = 0; i < s.length; i++) {
		LogDAO dao = new LogDAO();
		String oldvalue = dao.get_valueofphoto(s[i]);
		String user_id1 = (request.getSession().getAttribute("LoginId")).toString();
		int user_id = Integer.parseInt(user_id1);
		dao.changelog("delete", oldvalue, 0 + "", user_id,2);
		sql = "DELETE FROM `scene`.`photo` WHERE `id`='" + s[i] + "';";
		ret = ret + st.executeUpdate(sql);
	}

	if (ret == s.length)
		ret = 121;
	else
		ret = 120;
	String arg = String.valueOf(ret);
	response.sendRedirect("BenchPrompt.jsp?result=" + arg);
	conn.close(); //关闭数据库连接
%>

</head>


<body>
</body>
</html>
