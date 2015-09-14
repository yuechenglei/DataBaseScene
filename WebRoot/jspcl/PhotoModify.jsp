<%@ page language="java" import="java.util.*,java.sql.*, java.io.*"
	pageEncoding="UTF-8"%>
<%@ page import="dao.LogDAO"%>
<%
	String photo_id = request.getParameter("photo_id");
	String brightness = request.getParameter("brightness");
	String saturation = request.getParameter("saturation");
	String contrast = request.getParameter("contrast");
	String angle = request.getParameter("angle");
	String clip_left = request.getParameter("clip_left");
	String clip_top = request.getParameter("clip_top");
	String clip_width = request.getParameter("clip_width");
	String clip_height = request.getParameter("clip_height");
	String client_width = request.getParameter("client_width");

	Class.forName("com.mysql.jdbc.Driver");
	Connection conn = DriverManager
			.getConnection("jdbc:mysql://localhost:3306/scene?user=root&password="+db.DBInfo.getPassword());
	Statement stmt = conn.createStatement();
	String newvalue = photo_id + "," + clip_left + "," + clip_top + ","
			+ clip_width + "," + clip_height + "," + angle + ","
			+ saturation + "," + contrast + "," + brightness;
	String oldvalue = (String) session.getAttribute("oldvalue");
	String sql;
	sql = "update `scene`.`photo` set `brightness`='" + brightness
			+ "', `contrast`='" + contrast + "', `saturation`='"
			+ saturation + "', `angle`='" + angle + "', `clip_left`='"
			+ clip_left + "', `clip_top`='" + clip_top
			+ "', `clip_width`='" + clip_width + "', `clip_height`='"
			+ clip_height + "' where `id`='" + photo_id + "'";
	String user_id1 =  session.getAttribute("LoginId").toString(); 
	int user_id = Integer.parseInt(user_id1);
	new LogDAO().changelog("update", oldvalue, newvalue, user_id,2
			);// 将插入照片的参数存入log表中
	int k = stmt.executeUpdate(sql);
	conn.close();
	response.sendRedirect("../PicEdit.jsp?photo_id=" + photo_id
			+ "&client_width=" + client_width);
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
</head>
<body style="margin:5px auto;">

</body>

</html>