<%-- 
    Document   : pwd_change
    Created on : 2011-12-4, 10:56:48
    Author     : Administrator
--%>
<%@page contentType="text/html" pageEncoding="GB2312"%>
<%@page import="java.sql.*" %>
<%
    request.setCharacterEncoding("GB2312");
    response.setCharacterEncoding("GB2312");
    response.setContentType("text/html; charset=GB2312");
%>
<!DOCTYPE html>
<html>
<head>
        <meta http-equiv="Content-Type" content="text/html; charset=GB2312">
        <title>�޸�</title>
        <link rel="stylesheet" href="//cdn.bootcss.com/bootstrap/3.3.5/css/bootstrap.min.css">
        <link href="CSS/style.css" rel="stylesheet" type="text/css" />
<script language="javascript">
        function checkForm(form1){
            if(form1.oldPwd.value==""){
                alert("�������ԭ����!");form1.oldPwd.focus();return false;
            }
            if(form1.oldPwd.value!=form.holdPwd.value){
                alert("�������ԭ���벻��ȷ������������!");form1.oldPwd.value="";
                form1.oldPwd.focus();return false;
            }
            if(form1.newPwd.value==""){
                alert("�������������!");form1.newPwd.focus();return false;
            }
            if (form1.newPwd.value.length>25) { 
                alert("�����볤�Ȳ���̫����!");form1.newPwd.focus();return false;
            }
            if(form1.newPwdConfirm.value==""){
                alert("��ȷ��������!");form1.newPwdConfirm.focus();return false;
            }
            if(form1.newPwd.value!=form.newPwdConfirm.value){
                alert("����������������벻һ�£�����������!");
                form1.newPwd.value="";form1.newPwdConfirm.value="";
                form1.newPwd.focus();return false;
            }
        }
</script>
</head>
<body>
<form name="form1" action="jspcl/ModifyInspector.jsp?op=modify" method="post">
	<br/><br/><br/><br/><br/><br/><br/><br/><br/><br/>
  	<table align="center" width="360"   border="0" bgcolor="#66CCFF">
		<tr>
			<td bgcolor="" align="center" colspan="2">
				<hr/>�� �� �� �� �� �� <hr/>
			</td>
		</tr>
		<tr height="50"><td align="right">����ԭ���룺</td><td><input type="password" name="oldPwd" /></td></tr>
		<tr height="50"><td align="right">���������룺</td><td><input type="password" name="newPwd" /></td></tr>
		<tr height="50"><td align="right">�����������룺</td><td><input type="password" name="newPwdConfirm" /></td></tr>
		<tr height="50">
			<td align="right"><input type="submit" value="ȷ���޸�" name="submit" onClick="return checkForm(pwd_change_form);"></td>
			<td align="left">&nbsp;&nbsp;&nbsp;&nbsp;<input type="button" name="return" value="�� ��" onclick="form1.action='bench.jsp';form1.submit();"></td>
		</tr>
	</table>
</form>
</body>
</html>

