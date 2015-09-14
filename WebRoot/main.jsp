<%@ page language="java" import="java.util.*,java.sql.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <base href="<%=basePath%>">
    
    <title>现场照片管理系统</title>
    <link rel="stylesheet" href="//cdn.bootcss.com/bootstrap/3.3.5/css/bootstrap.min.css">
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->

	<%
		int	state;
			String account=request.getParameter("account");
			String password=request.getParameter("password");

			Class.forName("com.mysql.jdbc.Driver").newInstance();
			Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/scene?user=root&password="+sdu.edu.scene.db.DBInfo.getPassword());
			Statement s=con.createStatement();
			String sql="select id, password, account from inspector where account="+account;
			ResultSet rs=s.executeQuery(sql);
			if(rs.next())
		if(rs.getString("password").equals(password)) {
			state = 1;
			session.setAttribute("LoginId", rs.getString("id"));
		}
			 	else
			state = 2;
			else
		state = 3;
			rs.close();
			s.close();
			con.close();
			if (state==2 || state==3) {
		response.sendRedirect("login.jsp?first=false");
			}
	%>
  <frameset cols="14%,"  border="2">
  	<frame src="menu.jsp" name="menu" scrolling="yes" />	
  	<frame src="bench.jsp" name="bench" scrolling="yes"/> 
  </frameset> 

</head>
</html>
