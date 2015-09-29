<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	String case_id = request.getParameter("case_id");
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>选择上传的图像文件</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<script type="text/javascript">
	function addFile() {
		var myTB = document.getElementById("myTB");
		var rowNum = myTB.rows.length;
		var newRow = myTB.insertRow(rowNum);
		var cells_0 = newRow.insertCell(0);
		cells_0.innerHTML = "上传文件：";
		var cells_1 = newRow.insertCell(1);
		//上传类型为文件
		cells_1.innerHTML = "<input type='file' multiple name='nfile' />";
	}
</script>
</head>

<body>
	<form enctype="multipart/form-data" method="post"
		action="/start/servlet/PicsUpload?case_id=<%=case_id%>">
		<table id="myTB">
			<tr>
				<td>上传文件：</td>
				<td><input type="file" name="nfile" /></td>
			</tr>
		</table>
		<input type="button" value="添加" onclick="addFile()"><br>
		<input type="submit" value="上传">
	</form>
</body>
</html>
