<%@page import="sdu.edu.scene.db.DBInfo"%>
<%@ page language="java" import="java.util.*,java.sql.*"
	pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>



<%
	int state;
	String account = request.getParameter("account");
	String password = request.getParameter("password");
	String app = request.getParameter("app");
	System.out.print(account);
	System.out.print(password);

	Class.forName("com.mysql.jdbc.Driver").newInstance();
	Connection con = DriverManager
			.getConnection("jdbc:mysql://localhost:3306/scene?user=root&password="
					+ DBInfo.getPassword());
	PreparedStatement s = con
			.prepareStatement("select id, password, account from inspector where account=?");
	/* String sql = "select id, password, account from inspector where account="
	+ account; */
	s.setString(1, account);
	ResultSet rs = s.executeQuery();///出错
	if (rs.next())
		if (rs.getString("password").equals(password)) {
			state = 1;
			System.out.println( rs.getString("id"));
			session.setAttribute("LoginId", rs.getString("id"));
			System.out.println(session.getId());
			//是否为管理员
			if (rs.getString("account").equals("admin"))
				session.setAttribute("admin", "admin");
			if (app != null)
				out.print("登陆成功");
		} else
			state = 2;
	else
		state = 3;
	rs.close();
	s.close();
	con.close();
	if (state == 2 || state == 3) {
		if (app != null)
			out.print("失败");
		else
			response.sendRedirect("login.jsp?first=false");
	}
%>


