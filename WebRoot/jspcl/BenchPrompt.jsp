<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>Modify Case Result</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	
<%	
	String	prompt;
	String	s = request.getParameter("result");
	int	ret = Integer.parseInt(s);
	switch(ret) {
	case 0:
		prompt = "没有定义的操作 ！";
		break;
	case 1:
		prompt = "用户账号或密码不正确 ！";
		break;
	case 10:
		prompt = "删除案件失败 ！";
		break;
	case 11:
		prompt = "删除案件成功 ！";
		break;
	case 20:
		prompt = "修改案件失败 ！";
		break;
	case 21:
		prompt = "修改案件成功 ！";
		break;
	case 30:
		prompt = "插入案件失败 ！";
		break;
	case 31:
		prompt = "插入案件成功 ！";
		String id = request.getParameter("id");
		response.sendRedirect("../photo/PicsSelect.jsp?case_id="+id);
		break;
	case 50:
		prompt = "删除用户失败 ！";
		break;
	case 51:
		prompt = "删除用户成功 ！";
		break;
	case 60:
		prompt = "增加用户失败 ！";
		break;
	case 61:
		prompt = "增加用户成功 ！";
		break;
	case 70:
		prompt = "删除存储介质失败 ！";
		break;
	case 71:
		prompt = "删除存储介质成功 ！";
		break;
	case 80:
		prompt = "增加存储介质失败 ！";
		break;
	case 81:
		prompt = "增加存储介质成功 ！";
		break;
	case 90:
		prompt = "修改密码失败 ！";
		break;
	case 91:
		prompt = "修改密码成功 ！";
		break;
	case 100:
		prompt = "数据库备份失败 ！";
		break;
	case 101:
		prompt = "数据库备份成功 ！";
		break;
	case 110:
		prompt = "数据库恢复失败 ！";
		break;
	case 111:
		prompt = "数据库恢复成功 ！";
		break;
	case 120:
		prompt = "照片删除失败 ！";
		break;
	case 121:
		prompt = "照片删除成功 ！";
		break;
	case 1001:
		prompt = "案件中暂时没有照片 ！";	// from PicList.jsp
		break;
	case 1002:
		prompt = "上传图片成功 ！";		// from PicList.jsp
		break;
	case 1003:
		prompt = "请选择合适的数据库文件 ！";		// from RestoreFromFile.jsp
		break;
	default:
		prompt = "系统需要维护， 请联系软件维护人员";
		break;
	}
%>

  </head>
  
  <body>
  <br/>
  <br/>
  <br/>
  <br/>
  <br/>
  <br/>
  <br/>
  	<table align="center">
  	<tr>
    <td style="font-size:20; fontfamily:隶书"><strong><%=prompt%></strong></td>
    </tr>
    </table>
  <br/>
  </body>
</html>
