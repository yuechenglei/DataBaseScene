<%@ page language="java"
	import="java.util.*, java.sql.*, java.text.SimpleDateFormat"
	pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">

<title>My JSP 'BeiFenShuXing.jsp' starting page</title>
<link rel="stylesheet"
	href="//cdn.bootcss.com/bootstrap/3.3.5/css/bootstrap.min.css">
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
</head>

<body style="background-color:#888888; margin:80px">
	<form name="form1" action="/start/servlet/Beifen" method="post">
		<table align="center" style="background-color: rgb(128, 255, 255)"
			width="430" cellpadding="10">
			<tr height="30" style="background-color: #EEE;">
				<td align="center" colspan="2" height="30"><strong>数 据
						库 备 份</strong></td>
			</tr>
			<tr style="height:30">
				<td align="right">备份名称：</td>
				<td align="left" width="300"><input
					style="width:300; height:25" type="text" name="name"></td>
			</tr>
			<tr align="center">
				<td height="30" align="right" width="">存储介质：</td>
				<td height="30" align="left" style="width:300px"><select
					name="storage_id" id="experttype">
						<%
							Class.forName("com.mysql.jdbc.Driver").newInstance();
							Connection con = DriverManager
									.getConnection("jdbc:mysql://localhost:3306/scene?user=root&password="
											+ db.DBInfo.getPassword());
							String op = request.getParameter("op");
							Statement s = con.createStatement();
							String sql = "SELECT * FROM storage";
							ResultSet rs = s.executeQuery(sql);
							while (rs.next()) {
						%>
						<option value="<%=rs.getString("id")%>">
							<%=rs.getString("name")%>
						</option>
						<%
							}
							rs.close();
							con.close();
						%>
				</select></td>
			</tr>
			<tr style="height:30">
				<td align="right">文件名：</td>
				<td align="left" width="300"><input
					style="width:300; height:25" type="text" name="filename"
					value="<%="scene"
					+ new SimpleDateFormat("yyyy-MM-dd")
							.format(new java.util.Date()) + ".sql"%>"></td>
			</tr>
			<tr>
				<td align="right" valign="top">备份描述：</td>
				<td><input type="text" style="width:300; height:100"
					name="description"></td>
			</tr>
			<tr style="height:40">
				<td align="right" colspan="2"><input type="submit"
					name="Submit" value=" 备  份  "> <input type="button"
					name="return" value=" 返  回 "
					onclick="form1.action='bench.jsp';form1.submit();"></td>
			</tr>
		</table>
	</form>

</body>
</html>
