<%@ page  language="java" import="java.util.*" contentType="text/html;charset=gb2312"%>   
<%@ page import="java.sql.*, java.util.*, java.io.*" %> 
<html> 
<head> 
<title>°¸ ¼þ ÕÕ Æ¬</title>
<link rel="stylesheet" href="//cdn.bootcss.com/bootstrap/3.3.5/css/bootstrap.min.css">
</head> 
<body> 
<%   
	Class.forName("com.mysql.jdbc.Driver");  
	Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/scene?user=root&password="+db.DBInfo.getPassword());  
	Statement stmt=con.createStatement();  
	String sql, case_id, photo_id, ref, op, para, client_width;
	int	client_column;
	case_id = request.getParameter("case_id");
	client_width = request.getParameter("client_width");
	client_column = (Integer.parseInt(client_width)-90)/100; 
	sql= "select icon, id, case_id, para from photo where case_id="+case_id;  
	ResultSet rs=stmt.executeQuery(sql);
	int		k=0;
	op = request.getParameter("op");
%>
<table>
	<tr>
<% 
	while (rs.next()) {
		photo_id = rs.getString("id");
		session.setAttribute("photo_id", photo_id);  
		para = rs.getString("para");
		if (op.equals("pic_display"))
			ref = "PicDisplay.jsp?photo_id="+photo_id+"&client_width="+client_width;
		else
			ref = "PicEdit.jsp?photo_id="+photo_id+"&client_width="+client_width;
		out.print("<td align=\"center\" style=\"width:100px\"><a href="+ref+"><img src=jspcl/IconGet.jsp?photo_id="+photo_id+"></td>");
		k++;
		if (k%client_column == 0)
			out.print("</tr><tr>");
	}			
	out.print("</tr>");
	rs.close();
	con.close();
	out.print("<tr>");
%>
</table> 
<% 
	if (k == 0)
		response.sendRedirect("jspcl/BenchPrompt.jsp?result=1001");
%>
</body> 
</html> 