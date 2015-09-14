<%@ page language="java" import="java.util.*,java.sql.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>details for anjian</title>
    <link rel="stylesheet" href="//cdn.bootcss.com/bootstrap/3.3.5/css/bootstrap.min.css">
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
  		String id = request.getParameter("id");
  	    	String className="com.mysql.jdbc.Driver";
  	    	String url="jdbc:mysql://localhost:3306/scene";
  	    	String user="root";
  	    	String password=sdu.edu.scene.db.DBInfo.getPassword();
  	    	Connection conn; 
  	    	Statement st;
  	    	Class.forName(className);
  	    	conn=DriverManager.getConnection(url, user, password);
  	    	String sql = "select * from scene.case where id='"+id+"'";
  	    	st = conn.createStatement();
  	    	ResultSet rs = st.executeQuery(sql);
  	    	rs.next();
  	    	String name = rs.getString(2);
  	    	String date = rs.getString(3);
  	    	String inspector = rs.getString(4);
  	    	String xkh = rs.getString(5);
  	    	String date_anfa = rs.getString(8);
  	    	String place = rs.getString(9);
  	    	String desc = rs.getString(10);
  	%>
  	
  	<div name="main">
  		<table border="1" align="center" bordercolor="blue" cellspacing="1" cellpadding="10" style="background-color:#ccccff; border-color:blue; border-style:double; border-width:3px; width:800; align:center">
  		<tr>
  		<td align="center">案件ID</td>
  		<td align="center">案件名称</td>
  		<td align="center">勘验人</td>
  		<td align="center">现堪号</td>
  		<td align="center">立案时间</td>
  		<td align="center">案发时间</td>
  		<td align="center">案发地点</td>
  		</tr>
  		<tr>
  		<td align="center"><%=id %></td>
  		<td><%=name %></td>
  		<td align="center"><%=inspector %></td>
  		<td align="center"><%=xkh %></td>
  		<td align="center"><%=date %></td>
  		<td align="center"><%=date_anfa %></td>
  		<td><%=place %></td>
  		</tr>
  		<tr >
  		<td align="center">简要说明</td>
  		<td colspan="6" align="center"><%=desc %></td>
  		</tr>
  		</table><br /><hr /><br />
  		
  		<%
  		String sql2, case_id, photo_id, ref, op, para, client_width;
  		int	client_column;
  		//case_id = request.getParameter("case_id");
  		client_width = request.getParameter("client_width");
  		client_column = (Integer.parseInt(client_width)-90)/100; 
  		sql2= "select icon, id, case_id, para from photo where case_id="+id;  
  		ResultSet rs2=st.executeQuery(sql2);
  		int		k=0;
  		%>
  		<table>
	<tr>
<% 
	while (rs2.next()) {
		photo_id = rs2.getString("id");
		session.setAttribute("photo_id", photo_id);  
		para = rs2.getString("para");
		//if (op.equals("pic_display"))
			//ref = "PicDisplay.jsp?photo_id="+photo_id+"&client_width="+client_width;
		//else
			ref = "PicEdit.jsp?photo_id="+photo_id+"&client_width="+client_width;
		out.print("<td align=\"center\" style=\"width:100px\"><a href="+ref+"><img src=jspcl/IconGet.jsp?photo_id="+photo_id+"></td>");
		k++;
		if (k%client_column == 0)
			out.print("</tr><tr>");
	}			
	out.print("</tr>");
	rs2.close();
	conn.close();
	out.print("<tr>");
%>
<% 
	//if (k == 0)
		//response.sendRedirect("jspcl/BenchPrompt.jsp?result=1001");
%>
</table> 
  	</div>
  </body>
</html>
