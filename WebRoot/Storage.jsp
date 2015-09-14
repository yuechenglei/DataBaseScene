<%@ page language="java" import="java.util.*,java.sql.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'Storage.jsp' starting page</title>
    <link rel="stylesheet" href="//cdn.bootcss.com/bootstrap/3.3.5/css/bootstrap.min.css">
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
 <script type="text/javascript">
 
	function func()
	{
		if (bf.name.value=="")
		{
		alert("请输入介质名称");
		return false;
		}
		if (bf.type.value=="")
		{
		alert("请输入介质类型");
		return false;
		}
		if (bf.location.value=="")
		{
		alert("请输入存放地点");
		return false;
		}
		if (bf.description.value=="")
		{
		alert("请简单描述一下");
		return false;
		}
		
		
	}
	</script>
  </head>
  
 <body text="#000000">
 <%Class.forName("org.gjt.mm.mysql.Driver").newInstance(); 
  String url="jdbc:mysql://localhost/scene?user=root&password=1234&useUnicode=true&characterEncoding=8859_1" ;
  //testDB为你的数据库名 
   //String kyid=request.getParameter("kyid");

     //String name=request.getParameter("name");
  Connection conn= DriverManager.getConnection(url); 
  Statement stmt=conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE); 
 
 
   %>
 <hr/>
 <font ><b>案件备份&gt;&gt;&gt;</b></font>
 <hr/>
 <form name="bf" method="post" action="Storagecl.jsp">
			<br>
			<center>
				<table class="content"   width="75%" height="352" border="1" align="center">
					<tr align="center" style="background-color: #EEE;">
						<td class="head" height="40" colspan="3"> 
							<strong>备 份</strong> &nbsp;  
						</td>
					</tr>
					<tr align="center">
						<td height="30" align="left" width="150" style="background-color: rgb(206, 255, 255);">  
							&nbsp;&nbsp;&nbsp; 介质名称：&nbsp;&nbsp;  
						</td>
						<td height="30" align="left" width="">
							<input type="text"  size="40" name="name"><font color="red"> *</font>
						</td>
						
						
					</tr>
				
					<tr align="center">
						<td height="30" align="left" width="" style="background-color: rgb(206, 255, 255);">  
							&nbsp;&nbsp;&nbsp; 介质类型：&nbsp;&nbsp;  
						</td>
						<td height="30" align="left" width="">&nbsp; 
						<select name="type" id="experttype"> 
						<% 
	
    //把表格第二行的显示放到while循环中，就可以根据查询结果画出表格了。参数则放在<td>内的相应位置。 
   
		  String sql="SELECT * FROM scene.storage_media "; 
  
       ResultSet rs=stmt.executeQuery(sql); 
    
    while(rs.next()){%> 
						<option value="<%=rs.getString(1)%>"><%=rs.getString(2)%></option>
						<%}%>
						
						</select>
						<font color="red">*&nbsp;</font>
						</td>
					</tr>
					<tr align="center">
						<td height="30" align="left" width="" style="background-color: rgb(206, 255, 255);">  
							&nbsp;&nbsp;&nbsp; 存储地点：&nbsp;&nbsp;  
						</td>
						<td height="30" align="left" width="">
							<input type="text" name="location" size="40" >
							<font color="red">*&nbsp;</font>
						</td>
					</tr>
					<tr align="center">
						<td height="30" align="left" width="" style="background-color: rgb(206, 255, 255);">  
							&nbsp;&nbsp;&nbsp; 简单描述：&nbsp;&nbsp;  
						</td>
						<td align="left">
							<textarea style="width:100%; height:100%; " name="description"> </textarea ></td>
					</tr>
					
					
					
					<tr align="center">
						<td height="30" align="center" colspan="3" style="background-color: rgb(206, 255, 255);">
							<input class="button" type="submit" name="btnSub" value=" 备 份"
								onclick="return func()" />
							&nbsp;&nbsp;&nbsp;&nbsp;
							<input type="reset" name="reset" value=" 重 置" class="button">
						</td>
						
					</tr>
				</table>
			</center>
		</form>
  
 </body>
</html>
