<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!--登陆界面  -->
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    <link rel="stylesheet" href="//cdn.bootcss.com/bootstrap/3.3.5/css/bootstrap.min.css">
    <title>登陆案件管理</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
<%
	String first=request.getParameter("first");
	if (first==null){
	}
	else if (first.equals("false")) {
		String   message = "账号或密码错误！";
		out.println("<html>");	
		out.println("<body bgcolor=#000000>");	
    	out.println("<SCRIPT   LANGUAGE='JavaScript'>");   
    	out.println("<!--");   
    	out.println("alert('"+message+"')");   
    	out.println("//-->");   
    	out.println("</SCRIPT>"); 
		out.println("</body>");	
		out.println("</html>");	
	}
%>

        
  </head>

 <body name="登录现勘照片管理系统" bgcolor=#000000>
 <form action="main.jsp" method="post">
 <br/><br/><br/><br/><br/><br/><br/><br/><br/><br/>
  <table align="center" width="300"   border="0" bgcolor="#66CCFF" name="table1">
	<tr>
		<td bgcolor="" align="center" colspan="2">
			<hr/>
			<font>登录现勘照片管理系统</font>
			<hr/>
		</td>
	</tr>
	<tr height="50">
		<td style="text-align:right;"><div style="width:70px;">账号：</td>
		<td width="200" ><input type="text" name="account"/> </td>
	</tr>
	<tr>
		<td style="text-align:right;"><div style="width:70px;">密码：</td>
		<td width="200" ><input name="password"/> </td>
	</tr>
	<tr><td></td><td></td></tr>
	<tr>
		<td></td>
		<td style="text-align:center;" height="50">
			<input type="submit" value="登录">
			<input type="button" onClick="javascript:window.close();" value="关闭">
		</td>					
	</tr>
  </table>
</form>
</body>
</html>

