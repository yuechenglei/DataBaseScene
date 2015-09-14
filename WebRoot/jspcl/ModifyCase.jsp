<%@ page language="java" import="java.util.*,java.sql.*, java.text.SimpleDateFormat" pageEncoding="UTF-8"%>
<%@ page import="sdu.edu.scene.dao.LogDAO" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
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
		String className="com.mysql.jdbc.Driver";
	 	String url="jdbc:mysql://localhost:3306/scene";
		String user="root";
		String password=sdu.edu.scene.db.DBInfo.getPassword();
		Connection conn; 
		Statement st;
		Class.forName(className);
		conn=DriverManager.getConnection(url, user, password);
		st = conn.createStatement();   
		String	sql, id;
		String sql2="";
		int	ret;
		String op=request.getParameter("op");
		
		LogDAO log = new LogDAO();
		String operation = "";
		
		if (op.equals("delete")) {
			id = request.getParameter("id");
			sql="DELETE FROM `scene`.`photo` WHERE `case_id`='"+id+"';";
			st.executeUpdate(sql);
			sql="DELETE FROM `scene`.`case` WHERE `id`='"+id+"';";
			ret = 10;
			operation = "delete";
		}
		else {
			String name=request.getParameter("name");
			String inspector=request.getParameter("inspector");
			String xkh=request.getParameter("xkh");
			String date_anfa=request.getParameter("date_anfa");
			String place=request.getParameter("place");
			String desc=request.getParameter("desc");
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			java.util.Date currentDate = new java.util.Date();
			String date = sdf.format(currentDate);
			if (op.equals("insert")) {
		sql="INSERT INTO `scene`.`case` (`name`, `date`, `inspector`, `xkh`, `m`, `date_anfa`, `place`,`desc`) VALUES ('"+name+"', '"+date+"', '"+inspector+"', '"+xkh+"','a','"+date_anfa+"', '"+place+"', '"+desc+"')";
		sql2="select * from scene.case where name='"+name+"'";
		ret = 30;
		operation = "insert";
			}
			else {
		id = request.getParameter("id");
		sql="update `scene`.`case` set `name`='"+name+"', `inspector`='"+inspector+"', `xkh`='"+xkh+"', `m`='a', `date_anfa`='"+date_anfa+"', `place`='"+place+"', `desc`='"+desc+"' where `id`='"+id+"'";
		ret = 20;
		operation = "update";
			}
		}
		String oldvalue,newvalue;
		if(operation.equals("insert")){
			oldvalue = "";
		}else{
			oldvalue = log.get_valueofcase(request.getParameter("id"));
		}
		
		
		ret = ret + st.executeUpdate(sql);
		
		String id2 = "";
		if(operation.equals("delete")){
			newvalue = "";
		}
		else if(operation.equals("insert") || operation.equals("update")){
			if(operation.equals("insert")){
		ResultSet rs=st.executeQuery(sql2);
		rs.next();
		id2 = rs.getString(1);
		//System.out.println("新建案件的id为："+id2);
		newvalue = log.get_valueofcase(id2);
			}
			else{
		newvalue = log.get_valueofcase(request.getParameter("id"));
			}
		}
		else{newvalue="error";}
		String userid1 = session.getAttribute("LoginId").toString();
		int user_id = Integer.parseInt(userid1);
		if(operation.equals("insert") || operation.equals("update") || operation.equals("delete")){
			log.changelog(operation, oldvalue, newvalue, user_id,1);
			//System.out.println("修改log表。");
			//插入到log表中
			//delete没有记录照片的删除。。。未实现
		}
		
		String	arg = String.valueOf(ret);
		
		//新增部分
		if(sql2!=""){
			
			response.sendRedirect("BenchPrompt.jsp?result="+arg+"&id="+id2);
			//用来插入案件成功后直接跳转到上传图片
		}
		else{
			response.sendRedirect("BenchPrompt.jsp?result="+arg);
		}
		conn.close();   //关闭数据库连接
	%>

</head>
  
    
<body>

</body>
</html>
