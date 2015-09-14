<%@ page contentType="text/html;charset=gb2312"%>   
<%@ page import="java.sql.*" %> 
<%@ page import="java.util.*"%> 
<%@ page import="java.text.*"%> 
<%@ page import="java.io.*"%>   
<html> 
<body> 
<%
 	Class.forName("com.mysql.jdbc.Driver");   
 	Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/scene?user=root&password="+sdu.edu.scene.db.DBInfo.getPassword());
 	Statement stmt=con.createStatement();  
 	ResultSet rs=null;   
 	int id=Integer.parseInt(request.getParameter("id"));  
 	String sql = "select icon from photo WHERE id="+id+"";   
 	rs=stmt.executeQuery(sql);  
 	if (rs.next()) {  
 		ServletOutputStream sout = response.getOutputStream();  
 		InputStream in = rs.getBinaryStream(1);
 		byte b[] = new byte[512];  
 		for(int i=in.read(b); i!=-1;) {  
 	sout.write(b);   
 	in.read(b);  
 		}  
 		sout.flush();  
 		sout.close();  
 	}
 	rs.close();
 	con.close();
 %> 
</html> 
</html>