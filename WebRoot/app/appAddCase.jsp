<%@ page language="java"
	import="java.util.*,java.sql.*, java.text.SimpleDateFormat"
	pageEncoding="UTF-8"%>
<%@ page import="sdu.edu.scene.dao.CaseDAO"%>



<%
	String name = request.getParameter("name");
	String inspector = request.getParameter("inspector");
	String xkh = request.getParameter("xkh");
	String date_anfa = request.getParameter("date_anfa");
	String place = request.getParameter("place");
	String desc = request.getParameter("desc");
	System.out.println(date_anfa);
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	java.util.Date currentDate = new java.util.Date();
	String date = sdf.format(currentDate);
	String value = name + ";" + inspector + ";" + xkh + ";" + date_anfa
			+ ";" + place + ";" + desc + ";" + date;
	CaseDAO caseDao = new CaseDAO();
	if (caseDao.insert(value))
		out.print("创建成功");
	else
		out.print("创建失败");
%>


