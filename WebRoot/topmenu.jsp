<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<html>
<style type="text/css">
body {
	background-color: #EEE !important;
}

table {
	letter-spacing: 3px;
	back-ground: #EEE;
	margin-top: 15px;
}

td {
	width: 100px;
	align: center;
}

td a {
	color: #333;
	text-decoration: none!impoatant;
}

td a:hover {
	color: #333;
	text-decoration: none!impoatant;
}
</style>
<head>
<style type="text/css">
body {
	filter: progid:DXImageTransform.Microsoft.gradient(startcolorstr=#bbbbff,
		endcolorstr=white, gradientType=0);
}
</style>
<link rel="stylesheet"
	href="//cdn.bootcss.com/bootstrap/3.3.5/css/bootstrap.min.css">
</head>
<body>
	<table>
		<tr>
		<!-- 	<td><a href='ZhaiYao.jsp' target="bench">档案摘要 </a></td> -->
			<td><a href="ChangeScene.jsp?id=-1" target="bench">新建案件</a></td>
			<td><a
				href="CaseSelect.jsp?op=case_query&name=&inspector=&xkh=&date1=30140101&date2="
				target="bench">档案查询</a></td>
			<!-- <td><a href="/start/servlet/Beifen" target="bench">档案备份</a></td> -->
			<td>档案备份</td>
			<td><a
				href="CaseSelect.jsp?op=pic_edit&name=&inspector=&xkh=&date1=30140101&date2="
				target="bench">照片编辑</a></td>
			<td><a href="data_recovery.jsp" target="bench">系统回档</a></td>
			<td>系统设置</td>
		</tr>
	</table>
</body>
</html>