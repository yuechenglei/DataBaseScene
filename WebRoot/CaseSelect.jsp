<%@ page language="java" import="java.util.*,java.sql.*"
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

<title>My JSP 'ChaXunAnJian.jsp?hello' starting page</title>
<link rel="stylesheet" href="//cdn.bootcss.com/bootstrap/3.3.5/css/bootstrap.min.css">
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<script src="js/jquery.js"></script>
<script src="js/main.js"></script>
<!--
	<link rel="stylesheet" type="text/css" href="styles.css"> 
	-->
<script type="text/javascript">
	function CheckAndSubmit() {
		var date1 = document.getElementById("date1").value;
		var date2 = document.getElementById("date2").value;
		if (date1 != "" && !date1.match("\\d{2,4}-\\d{1,2}-\\d{1,2}")) {
			alert("开始日期格式错误！");
			return false;
		}
		if (date2 != "" && !date2.match("\\d{2,4}-\\d{1,2}-\\d{1,2}")) {
			alert("结束日期格式错误！");
			return false;
		}
		document.getElementById("client_width").value = document.body.clientWidth;
		ajgl.submit();
	}
</script>
<%
	String op = request.getParameter("op");
	String name = request.getParameter("name");
	String inspector = request.getParameter("inspector");
	String xkh = request.getParameter("xkh");
	String date1 = request.getParameter("date1");
	String date2 = request.getParameter("date2");
	String client_width = request.getParameter("client_width");
%>
<style>
table td{
padding:7px 10px;
}
</style>
</head>

<body>
	<div>
		<br>
	</div>
	<form name="ajgl" action="CaseSelect.jsp" method="post">
		<table width="100%" border="1" align="center" cellpadding="10"
			style="font-family:幼圆; border-color:blue; border-style:solid; border-width:1px; align:center">
			<tr height="30" style="background-color: #EEE;">
				<td align="center" colspan="9">查 询 条 件<strong></strong></td>
			</tr>
			<tr height="25">
				<td align="center">案件名称</td>
				<td align="center">勘验人</td>
				<td align="center">现堪号</td>
				<td align="center">开始日期</td>
				<td align="center">结束日期</td>
				<td><input type="hidden" onblur="validateLength1(this)"
					name="op" value="<%=op%>"></td>
				<td><input type="hidden" onblur="validateLength1(this)"
					name="client_width" value="111" id="client_width"></td>
				<td rowspan="2"><input type="button" onclick="CheckAndSubmit()"
					value="查询"></td>
			</tr>
			<tr>
				<td align="center"><input type="text"
					onblur="validateLength1(this)" value="" maxlength="30" name="name"></td>
				<td align="center"><input type="text"
					onblur="validateLength1(this)" value="" maxlength="30"
					name="inspector"></td>
				<td align="center"><input type="text"
					onblur="validateLength1(this)" value="" maxlength="30" name="xkh"></td>
				<td align="center"><input type="text"
					onblur="validateLength1(this)" value="" maxlength="30" name="date1"
					id="date1"></td>
				<td align="center"><input type="text"
					onblur="validateLength1(this)" value="" maxlength="30" name="date2"
					id="date2"></td>
				<td></td>
				<td></td>
			</tr>
		</table>
		<br />
		<%
			int l;
			if(op.equals("case_query") ){
				l=5;
			}
			else{
				l=6;
			}
		%>
		<table width="100%" cellpadding="5" border="1" style="font-family:幼圆">
			<tr height="30" style="background-color: #EEE;">
				<td align="center" colspan="<%=l %>" height="30">案 件 列 表<strong></strong></td>
			</tr>
			<tr height="30">
				<td align="center" width="30%" height="30"
					style="background-color: #EEE;"><font
					color="#333">案件名称</font></td>
				<td align="center" style="background-color: #EEE;"><font
					color="#333">立案日期 </font></td>
				<td align="center" style="background-color: #EEE;"><font
					color="#333">勘验人</font></td>
				<td align="center" style="background-color: #EEE;"><font
					color="#333">现勘号</font></td>
				<td align="center" width="10%" style="background-color: #EEE;"><font
					color="#333">照片数目</font></td>
				<%
					if (!op.equals("case_query"))
						out.print("<td align=\"center\" style=\"background-color: #EEE;\"><font color=#333>操作</font></td>");
				%>
			</tr>

			<%
				//把表格第二行的显示放到while循环中，就可以根据查询结果画出表格了。参数则放在<td>内的相应位置。 

					String className = "com.mysql.jdbc.Driver";
					String url = "jdbc:mysql://localhost:3306/scene";
					String user = "root";
					String password = sdu.edu.scene.db.DBInfo.getPassword();
					Class.forName(className);
					Connection conn = DriverManager.getConnection(url, user, password);
					String id = request.getParameter("id");
					Statement s = conn.createStatement();

					//String sql = "select scene.case.name, date, inspector, xkh, scene.case.id ,count(case_id) from scene.case,scene.photo ";
					String sql = "select cc.name, cc.date, cc.inspector, cc.xkh, cc.id ,pp.num "
							+ "from scene.case cc left join (select case_id,count(case_id) as num from scene.photo group by case_id) pp on pp.case_id=cc.id";
					String s1 = "", s2 = "", s3 = "", s4 = "", ss = "", str = "";

					ss = "";
					if (!name.isEmpty()) {
						str = str + " cc.name='" + name + "'";
						ss = " AND ";
					}
					if (!inspector.isEmpty()) {
						str = str + ss + "cc.inspector='" + inspector + "'";
						ss = " AND ";
					}
					if (!xkh.isEmpty()) {
						str = str + ss + "cc.xkh='" + xkh + "'";
						ss = " AND ";
					}

					if (!date1.isEmpty()) {
						str = str + ss + "cc.date>='" + date1 + "'";
						ss = " AND ";
					}
					if (!date2.isEmpty())
						str = str + ss + "cc.date<='" + date2 + "'";
					if (!str.isEmpty())
						sql = sql + " where " + str + "";

					ResultSet rs = s.executeQuery(sql);
					while (rs.next()) {
			%>
			<tr height="30">
				<%
					if (op.equals("case_query")) {
				%>
				<td align="center"><a
					href="anjiandetail.jsp?id=<%=rs.getString(5)%>&client_width=<%=client_width%>"><%=rs.getString(1)%></a></td>
				<%
					} else {
				%>
				<td align="center"><%=rs.getString(1)%></td>
				<%
					}
				%>
				<td align="center"><%=rs.getString(2)%></td>
				<td align="center"><%=rs.getString(3)%></td>
				<td align="center"><%=rs.getString(4)%></td>
				<%
					if (rs.getString(6) == null) {
				%>
				<td align="center">0</td>
				<%
					} else {
				%>
				<td align="center"><%=rs.getString(6)%></td>
				<%
					}
						if (op.equals("case_modify"))
							out.print("<td align=\"center\"><a href=AnJianShuXing.jsp?op=modify&id="
									+ rs.getString(5) + ">修改</a></td>");
						if (op.equals("case_delete"))
							out.print("<td align=\"center\"><a href=jspcl/ModifyCase.jsp?op=delete&id="
									+ rs.getString(5) + ">删除</a></td>");
						if (op.equals("pic_display"))
							out.print("<td align=\"center\"><a href=PicList.jsp?op=pic_display&case_id="
									+ rs.getString("id")
									+ "&client_width="
									+ client_width + ">查看照片</a></td>");
						if (op.equals("pic_upload"))
							out.print("<td align=\"center\"><a href=photo/PicsSelect.jsp?case_id="
									+ rs.getString("id") + ">上传照片</a></td>");
						if (op.equals("pic_edit"))
							out.print("<td align=\"center\"><a href=PicList.jsp?op=pic_edit&case_id="
									+ rs.getString("id") + "&client_width="
									+ client_width + ">编辑照片</a></td>");
						if (op.equals("pic_delete"))
							out.print("<td align=\"center\"><a href=PicRemove.jsp?case_id="
									+ rs.getString("id") + "&client_width="
									+ client_width + ">删除照片</a></td>");
				%>
			</tr>
			<%
				}
			%>
		</table>
	</form>

	<%
		rs.close();
		conn.close();
	%>
</body>
</html>
