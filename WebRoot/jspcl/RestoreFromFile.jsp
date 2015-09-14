<%@ page language="java" import="java.util.*,java.sql.*, java.io.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'HuiFu.jsp' starting page</title>
    
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
	String inStr, outStr, str1="", str2="";  
	int	num, k=0, count=0, len; 
	byte[]	b = new byte[1024], b1;
	Process child; 

	Runtime rt = Runtime.getRuntime();
	try { 
		child = rt.exec("mysql --default-character-set=utf8 -uroot -pycl,,123 scene");
	} catch(IOException e) {
		System.out.println("请选择合适的数据库文件！");
		response.sendRedirect("BenchPrompt.jsp?result=1003");
		return;
	}  
	OutputStream	outStream = child.getOutputStream();  
	InputStream		inStream = request.getInputStream(); 
  
	while  ((len=inStream.read(b)) > 0 ) { 
		str1 = new String(b, "GB2312");
		k = str1.indexOf("-- MySQL");
		if (k < 0) {
			count ++;
			if (count > 10) {
				out.println("上传文件格式错误！");
				response.sendRedirect("BenchPrompt.jsp?result=110"); 
				return;
			}
			continue;
		}
		break;
	}
	str2 = str1.substring(k);
	b1 = str2.getBytes();
	outStream.write(b1, 0, len-k);	 
	
	while  ((len=inStream.read(b)) > 0 ) { 
		outStream.write(b, 0, len);	 
	} 
	
	inStream.close(); 
	outStream.close();

	response.sendRedirect("BenchPrompt.jsp?result=111"); 

%>
</body>
</html>
