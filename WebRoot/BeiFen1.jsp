<%@ page language="java" import="java.util.*,java.sql.*, java.io.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'BeiFen.jsp' starting page</title>
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

String inStr; 
StringBuffer sb = new StringBuffer("");
String outStr;
char cbuf[] = new char[1024];
int	 num;

Runtime rt = Runtime.getRuntime();
String	cmd = "mysqldump --hex-blob -uroot -pycl,,123 a";
Process p = rt.exec(cmd);
InputStream in = p.getInputStream();// 控制台的输出信息作为输入流 
InputStreamReader xx = new InputStreamReader(in, "utf8");// 设置输出流编码为utf8。这里必须是utf8，否则从流中读入的是乱码 
BufferedReader br = new BufferedReader(xx);
//while ((inStr = br.readLine()) != null) 
//	sb.append(inStr + "\r\n");
while ((num=br.read(cbuf, 0, 1024))!=-1)
	sb.append(cbuf, 0, num);
outStr = sb.toString();//备份出来的内容是一个字条串 
// 要用来做导入用的sql目标文件： 
FileOutputStream fout = new FileOutputStream("d:\\aa.sql"); 
OutputStreamWriter writer = new OutputStreamWriter(fout, "utf8"); 
writer.write(outStr);//写文件 
writer.flush();// 注：这里如果用缓冲方式写入文件的话，会导致中文乱码，用flush()方法则可以避免 
in.close(); 
xx.close();
br.close(); 
writer.close(); 
fout.close();
%>











</body>
</html>
