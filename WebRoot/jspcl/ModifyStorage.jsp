<%@ page language="java" import="java.util.*,java.sql.*, java.text.SimpleDateFormat" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'Storagecl.jsp' starting page</title>
    
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
	int ret;
	String className="com.mysql.jdbc.Driver";
	String url="jdbc:mysql://localhost:3306/scene";
	String user="root";
	String password=sdu.edu.scene.db.DBInfo.getPassword();
	Connection conn; 
    Statement st;
	Class.forName(className);
	conn=DriverManager.getConnection(url, user, password);
	st = conn.createStatement();   
	
	String id, sql; 
	String op=request.getParameter("op");
	if (op.equals("delete")) {
		id = request.getParameter("id");
		sql="DELETE FROM `scene`.`Storage` WHERE `id`='"+id+"';";
		ret = 70;
	}
	else {
		String location=request.getParameter("location");
		String name=request.getParameter("name");
		String type=request.getParameter("type");
		String description= request.getParameter("description");
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		java.util.Date currentDate = new java.util.Date();
		String date = sdf.format(currentDate);
		sql="INSERT INTO `scene`.`storage` (`name`, `type`, `location`, `description`,`date`) VALUES ('"+name+"', '"+type+"', '"+location+"', '"+description+"', '"+date+"' )";
		ret = 80;
	}
	
	ret = ret + st.executeUpdate(sql);
	String	arg = String.valueOf(ret);
	response.sendRedirect("BenchPrompt.jsp?result="+arg);
	conn.close();   //关闭数据库连接
%>	  
sql=<%=sql %>    
  </body>
</html>
