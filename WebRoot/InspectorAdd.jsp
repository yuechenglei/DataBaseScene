<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!-- 添加勘探人 -->
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">

<title>My JSP 'XinJianYongHu.jsp' starting page</title>
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
<script type="text/javascript">
	function ok() {
		if (yonghu.id.value == "") {
			alert("请填写用户编号");
			return false;
		}
		if (yonghu.name.value == "") {
			alert("请填写用户名称");
			return false;
		}
		if (yonghu.pw1.value == "") {
			alert("请填写密码");
			return false;
		}
		if (yonghu.pw2.value == "") {
			alert("请填写勘验人");
			return false;
		}
		if (yonghu.pw1.value != yonghu.pw2.value) {
			alert("两次输入的密码不同，请重新输入");
			return false;
		}
	}
</script>
</head>

<body text="#000000"
	style="background-color:#eee;margin:100px,0px,0px,0px;">
	<form name="yonghu" method="post"
		action="jspcl/ModifyInspector.jsp?op=insert&id=-1">
		<br>
		<center>
			<table class="content" width="35%" border="1" align="center"
				style="font-family:幼圆;font-size=20;text-align:center; background-color: #eee">
				<tr height="50" align="center" style="background-color: #ccc">
					<td class="head" height="35" colspan="3"><strong>用&nbsp;户&nbsp;注&nbsp;册</strong>
					</td>
				</tr>
				<tr>
					<td height="40" align="right" style="font-family:隶书">用户ID：</td>
					<td align="left" width="230">&nbsp;<input type="text"
						name="account" maxlength="18"><font color="red">&nbsp;*</font></td>
				</tr>
				<tr>
					<td height="40" align="right" style="font-family:隶书">姓名：</td>
					<td align="left">&nbsp;<input type="text" name="name"
						maxlength="18"><font color="red">&nbsp;*</font></td>
				</tr>
				<tr>
					<td height="40" align="right" style="font-family:隶书">密码：</td>
					<td align="left">&nbsp;<input type="password" name="pw1"
						maxlength="18"><font color="red">&nbsp;*</font></td>
				</tr>
				<tr>
					<td height="40" align="right" style="font-family:隶书">确认密码：</td>
					<td align="left">&nbsp;<input type="password" name="pw2"
						maxlength="18"><font color="red">&nbsp;*</font></td>
				</tr>
				<tr>
					<td height="50" align="center" colspan="3"
						style="background-color: #EEE;font-family:幼圆">&nbsp;<input
						class="button" type="submit" name="btnSub" value=" 注 册 "
						onclick="return ok()" /> &nbsp;&nbsp;&nbsp;&nbsp; <input type="button"
						onClick="history.go(-1)" value=" 返 回 ">
					</td>
				</tr>
			</table>
		</center>
	</form>

</body>
</html>