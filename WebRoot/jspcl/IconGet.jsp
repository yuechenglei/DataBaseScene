<%@ page language="java" import="java.util.*, java.sql.*, java.io.*" pageEncoding="ISO-8859-1"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'IconStream.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->

  </head>
  
  <body>
<%
	Class.forName("com.mysql.jdbc.Driver");  
	Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/scene?user=root&password="+sdu.edu.scene.db.DBInfo.getPassword());  
	Statement st = con.createStatement();  
	String sql, photo_id;
	ResultSet rs;
	photo_id = request.getParameter("photo_id");
	sql = "select id, icon from photo where id="+photo_id;
	rs = st.executeQuery(sql);
	if (rs.next()) {
		Blob b = rs.getBlob("icon"); 
		long size = b.length();
		byte[] bs = b.getBytes(1, (int)size);  
		response.setContentType("image/jpeg");   
		OutputStream outs = response.getOutputStream();  
		outs.write(bs); 
		outs.flush();
		out.clear();			//清空缓存的内容。
		out = pageContext.pushBody();	
	}
	rs.close();
	con.close();
%>
  </body>
</html>
