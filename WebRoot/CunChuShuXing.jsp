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
		if (form1.name.value=="") {
			alert("请输入介质名称");
			return false;
		}
		if (form1.type.value=="") {
			alert("请输入介质类型");
			return false;
		}
		if (form1.location.value=="") {
			alert("请输入存放地点");
			return false;
		}
		if (form1.description.value=="") {
			alert("请简单描述一下");
			return false;
		}		
	}
	</script>
</head>
  
 <body text="#000000"  style="background-color:#888888; margin:80px">
 <%
 	Class.forName("org.gjt.mm.mysql.Driver").newInstance(); 
	String url="jdbc:mysql://localhost/scene?user=root&password=ycl,,123&useUnicode=true&characterEncoding=8859_1" ;
	Connection conn= DriverManager.getConnection(url); 
	Statement stmt=conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE); 
%>
 <form name="form1" method="post" action="jspcl/ModifyStorage.jsp?op=insert">
		<table class="content"   width="48%" height="352" border="1" align="center" style="background-color:#aaffff;">
			<tr align="center" style="background-color: #EEE;">
				<td class="head" height="40" colspan="3"> 
					<strong>存 储 介 质 属 性</strong> &nbsp;  
				</td>
			</tr>
			<tr>
				<td height="30" style="text-align:right">介质名称：</td>
				<td height="30" align="left"><input type="text"  size="40" name="name" style="margin:5px"><font color="red">*</font></td>
			</tr>
			<tr>
				<td height="30" align="right">介质类型：</td>
				<td height="30" align="left" width="200px"><select name="type" id="experttype" style="margin:5px"> 
						<% 
							String sql="SELECT * FROM scene.storage_media "; 
       						ResultSet rs=stmt.executeQuery(sql); 
					    	while(rs.next()){
					    %> 
							<option value="<%=rs.getString(1)%>">
								<%=rs.getString(2)%>
							</option>
						<%
							}
						%>
					</select>
				</td>
			</tr>
			<tr>
				<td height="30" align="right">存储地点：</td>
				<td height="30" align="left"><input type="text" name="location" size="40"  style="margin:5px"><font color="red">&nbsp;*</font></td>
			</tr>
			<tr>
				<td height="60" align="right">简单描述：</td>
				<td align="left"><textarea style="width:98%; height:100%;" name="description" style="margin:0px,0px,0px,5px"> </textarea ></td>
			</tr>
			<tr align="center">
				<td height="30" align="center" colspan="3">
					<input class="button" type="submit" name="btnSub" value="添 加"
						onclick="return func()" />
					&nbsp;&nbsp;&nbsp;&nbsp;
					<input type="reset" name="reset" value="返 回" class="button" onclick="form1.action='bench.jsp';form1.submit();">
				</td>
			</tr>
		</table>
</form>
  
 </body>
</html>
