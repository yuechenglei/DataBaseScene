<%@ page contentType="text/html;charset=gb2312"%>   
<%@ page import="java.sql.*, java.util.*, java.io.*" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'FileSave.jsp' starting page</title>
    
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
  	ResultSet rs;
  	InputStream in=null;
  	FileOutputStream fileOutStream=null;
  	String sql, str_id;
  	int id;

  	str_id = request.getParameter("id");
  	id = Integer.parseInt(str_id);  
  	Class.forName("com.mysql.jdbc.Driver");  
  	Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/scene?user=root&password="+sdu.edu.scene.db.DBInfo.getPassword());  
  	Statement stmt = con.createStatement();
  	sql = "select icon,id FROM photo where id=1";
  	rs=stmt.executeQuery(sql);
  	int	k = 0;
  	while(rs.next()) {
  		DataOutputStream sos=new DataOutputStream(new BufferedOutputStream(new FileOutputStream("img_1234.jpg")));
     		//读出流用getBinaryStream()方法。 
     		in = rs.getBinaryStream("icon");
     		//用缓存数组逐渐输出流
     		int len=0;
     		byte[] b=new byte[1024];
     		while((len = in.read(b))!=-1) {
  	sos.write(b,0,len);
     		}
     		sos.close();
     		in.close();
  	}
  	rs.close();
  	con.close();
  %>               
</body>
</html>
