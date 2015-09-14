<%@ page contentType="text/html;charset=gb2312"%>
<%@ page import="java.sql.*, java.util.*, java.io.*"%>
<html>
<head>
<title>案 件 照 片</title>
<link rel="stylesheet"
	href="//cdn.bootcss.com/bootstrap/3.3.5/css/bootstrap.min.css">
</head>
<body>
	<%
		Class.forName("com.mysql.jdbc.Driver");
			Connection con = DriverManager
			.getConnection("jdbc:mysql://localhost:3306/scene?user=root&password="
					+ sdu.edu.scene.db.DBInfo.getPassword());
			Statement stmt = con.createStatement();
			String sql, case_id, photo_id, client_width;
			int client_column;
			case_id = request.getParameter("case_id");
			client_width = request.getParameter("client_width");
			client_column = (Integer.parseInt(client_width) - 90) / 120;

			sql = "select icon, id, case_id from photo where case_id="
			+ case_id;
			ResultSet rs = stmt.executeQuery(sql);
			int k = 0;
	%>
	<form name="form1" id="form1" method="post" action="jspcl/PicKill.jsp">
		<table>
			<tr>
				<td align="center" colspan="20">
					<hr /> <font>删 除 案 件 照 片</font>
					<hr />
				</td>
			</tr>
			<%
				out.print("<tr>");
				while (rs.next()) {
					photo_id = rs.getString("id");
					out.print("<td style=\"width:100px\"><input type=\"checkbox\" name=\"cList\" value=\""
							+ photo_id + "\" /></td>");
					out.print("<td style=\"width:20px\"><img src=\"jspcl/IconGet.jsp?photo_id="
							+ photo_id + "\"></td>");
					k++;
					if (k % client_column == 0)
						out.print("</tr><tr>");
				}
				out.print("</tr>");
				rs.close();
				con.close();
			%>
			<tr>
				<td colspan="20"><hr /></td>
			</tr>
			<tr>
				<td colspan="20" align="right"><input type="submit" name="OK"
					value="确  定" /> <input type="button" onClick="history.go(-1)"
					value=" 返 回 "></td>
			</tr>
		</table>
	</form>
</body>
</html>
