<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ page import="sdu.edu.scene.upload.SmartUpload"%>
<%@ page import="sdu.edu.scene.upload.Files"%>
<%@ page import="sdu.edu.scene.db.scene"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>


<%
	System.out.println("进入1111");
	SmartUpload su = new SmartUpload();
	su.initialize(getServletConfig(), request, response);
	try {
		// su.setAllowedFilesList("jpg,jpeg,JPG,gif");
		// su.setDeniedFilesList("exe");
		su.setAllowedFilesList("jpg,jpeg,JPG,gif,exe");
		su.setMaxFileSize(1024 * 1024 * 20);
		su.setTotalMaxFileSize(1024 * 1024 * 100);
		su.upload();
	} catch (Exception e) {
		java.io.PrintWriter outprint = response.getWriter();
		out.print("<script Lanuage='JavaScript'>window.alert('Only jpg, jpeg, JPG, gif are available! ')</script>");
		e.printStackTrace();
	}
	/* String case_id = request.getParameter("case_id"); */

	Files fs = su.getFiles();
	scene s = new scene();
	// 检测用户id
	/* String user_id1 = (session.getAttribute("LoginId")).toString();
	int user_id = Integer.parseInt(user_id1); */
	int user_id = 4;
	String case_id = "51";
	System.out.println(case_id + "进入");
	s.insertPhoto(fs, case_id, user_id);
%>