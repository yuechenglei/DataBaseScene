<%@ page language="java" import="java.util.*,java.sql.*, java.io.*, java.text.SimpleDateFormat" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'BeiFen.jsp' starting page</title>
    
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
 
	String filename = request.getParameter("filename"); 
	String storage_id = request.getParameter("storage_id"); 
	String name = request.getParameter("name"); 
	String description = request.getParameter("description"); 
 
	// 从数据库导出全部数据到/workdir/backup.sql 
	String inStr, outStr, dbfile; 
	StringBuffer sb = new StringBuffer(""); 
	char cbuf[] = new char[4096]; 
	int	 num; 
	Runtime rt = Runtime.getRuntime(); 
	String	cmd = "mysqldump --hex-blob -uroot -pycl,,123 scene"; 
	Process p = rt.exec(cmd); 
	InputStream in = p.getInputStream();// 控制台的输出信息作为输入流  
 
	InputStreamReader xx = new InputStreamReader(in, "utf8");// 设置输出流编码为utf8。这里必须是utf8，否则从流中读入的是乱码  
	BufferedReader br = new BufferedReader(xx);  
	dbfile = getServletContext().getRealPath("/workdir/"+filename); 
	FileOutputStream fout = new FileOutputStream(dbfile);  
	OutputStreamWriter writer = new OutputStreamWriter(fout, "utf8");  
 
	while ((num=br.read(cbuf, 0, 4096))!=-1) { 
		outStr = String.valueOf(cbuf, 0, num); 
		writer.write(outStr);	//写文件  
		writer.flush();			// 注：这里如果用缓冲方式写入文件的话，会导致中文乱码，用flush()方法则可以避免  
	}  
	in.close();  
	xx.close(); 
	br.close();  
	writer.close();  
	fout.close(); 
%>
<br />
<br />
<br />
<br />
<table align="center">
	<tr>
	<td>按右键点击</td><td><a href="/start/workdir/<%=filename%>">下载</a></td><td>，保存数据库文件</td>
	</tr>
</table>
</body>
</html>
