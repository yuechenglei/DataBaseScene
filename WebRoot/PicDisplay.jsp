<%@ page contentType="text/html;charset=gb2312"%>   
<%@ page import="java.sql.*, java.util.*, java.io.*" %> 
<html> 
<head> 
<title>案 件 照 片</title>
<link rel="stylesheet" href="//cdn.bootcss.com/bootstrap/3.3.5/css/bootstrap.min.css">
<script type="text/javascript">
photo.width = 500;
function resize(obj)
{
	w = document.body.clientWidth-12;
	h = document.body.clientHeight-18;
	if (obj.width/obj.height > w/h ) {
		obj.width = w;
	}
	else {
		obj.height = h;
	}
}
</script>

</head> 
<body style="margin:3px"> 
<table>
	<tr>
<%
	String	photo_id, para, client_width, sql;
	int	w;
	photo_id = request.getParameter("photo_id");
	client_width = request.getParameter("client_width");
	w = Integer.parseInt(client_width)-11;
	client_width = String.valueOf(w);
	out.print("<td colspan=\"3\" align=\"center\"><img id=\"photo\" src='/start/servlet/PhotoStream?photo_id="+photo_id+"' onload=resize(this)></td>");
//	out.print("<td colspan=\"3\" align=\"center\"><img id=\"photo\" width="+client_width+" src='/start/servlet/PhotoStream?photo_id="+photo_id+"'></td>");

	Class.forName("com.mysql.jdbc.Driver");  
	Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/scene?user=root&password="+db.DBInfo.getPassword());  
	Statement stmt=con.createStatement();  
	sql= "select id, para from photo where id="+photo_id;  
	ResultSet rs=stmt.executeQuery(sql);
	rs.next();
	para = rs.getString("para");
	rs.close();
	con.close();
%>
	</tr>
	<tr>
<%
	out.print("<td style=\"WORD-WRAP: break-word;width:"+Integer.toString(w-200)+"\">");
	out.print(para);
	out.print("</td>");
%>
	<td align="center" valign="top" style="width:80;valign:top">
<%
	out.print("<a href='javascript:history.back();'> 原始图像 </a>"); 
%>
	</td>
	<td align="center" valign="top" style="width:80;valign:top">
<%
	out.print("<a href='javascript:history.back();'> 返回 </a>"); 
%>
	</td>
</table>
</body>
</html> 