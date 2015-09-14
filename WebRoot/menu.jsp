<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
           
<%    
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>   
  
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head> 
<title>现场勘查照片管理系统菜单</title>
<link rel="stylesheet" href="//cdn.bootcss.com/bootstrap/3.3.5/css/bootstrap.min.css">
<style> 
<!--  
body{
background-color:#EEEEEE;;
font-family:"Microsoft Yahei";
}
#navigation {
width:150px;
font-family:"幼圆";
background-color:#EEEEEE;
border-bottom:1px solid #999999;
border-top:1px solid #999999;
border-left:1px solid #999999;
border-right:1px solid #999999;
}
#navigation > ul {
list-style-type:none;
margin:0px;
padding:0px;
}
#navigation > ul > li {
border-bottom:1px solid #999999;
}
#navigation > ul > li > a{
display:block;
text-decoration:none;
padding:5px 5px 5px 0.5em;
border-left:12px solid #EEEEEE;
border-right:1px solid #EEEEEE;

}
#navigation > ul > li > a:link, #navigation > ul > li > a:visited{
background-color:#EEEEEE;
color:#333;
}        	  
#navigation > ul > li > a:hover{
	background-color:#EEEEEE;
	color:#333;
}
 a{
	text-decoration:none !important;	
}
#navigation ul li ul{
	list-style-type:none;
	margin:0px 0px 0px 20px;
	padding:0px 0px 0px 0px;
}
<%--
#navigation ul li ul li{
	border-bottom:1px solid #0000cc;
}
--%>
#navigation ul li ul li a{
 	display:block;
	padding:3px 3px 3px 0.5em;
	text-decoration:none;
	border-left:10px solid #EEEEEE;
	border-right:1px solid #EEEEEE;
	text-decoration:underline;
	font-family:"Microsoft Yahei";
	font-size:14px;
	}
#navigation ul li ul li a:link, #navigation ul li ul li a:visited{
	background-color:#EEEEEE;
	color:#333;
}
#navigation ul li ul li a:hover{
	background-color:#EEEEEE;
	color:#333;
}
#navigation ul li ul.myHide{
	display:none;
}
#navigation ul li ul.myShow{
	display:block;
}-->
</style>

<script language="javascript">
function change(){
	//通过父元素li，找到兄弟元素ul
	var oSecondDiv = this.parentNode.getElementsByTagName("ul")[0];
	//CSS交替更换来实现显、隐
	if(oSecondDiv.className == "myHide")
		oSecondDiv.className = "myShow";
	else
		oSecondDiv.className = "myHide";
}
window.onload = function(){
	var oUl = document.getElementById("listUL");
	var aLi = oUl.childNodes;	//子元素
	var oA;
	for(var i=0;i<aLi.length;i++){
		//如果子元素为li，且这个li有子菜单ul
		if(aLi[i].tagName == "LI" && aLi[i].getElementsByTagName("ul").length){
			oA = aLi[i].firstChild;	//找到超链接
			oA.onclick = change;	//动态添加点击函数
		}
	}
};
</script>
</head>
<body>
<div id="navigation">
	<ul id="listUL">  
		<li><a href="#">案件管理</a>
        	<ul class="myHide">
            	<li><a href="AnJianShuXing.jsp?id=-1" target="bench">新建案件</a></li>
            	<li><a href="CaseSelect.jsp?op=case_query&name=&inspector=&xkh=&date1=30140101&date2=" target="bench">查询案件</a></li>
                <li><a href="CaseSelect.jsp?op=case_modify&name=&inspector=&xkh=&date1=30140101&date2=" target="bench">修改案件</a></li>
                <li><a href="CaseSelect.jsp?op=case_delete&name=&inspector=&xkh=&date1=30140101&date2=" target="bench">删除案件</a></li>
            </ul> 
        </li>
		<li><a href="#">照片管理</a>
        	<ul class="myHide">
            	<li><a href="CaseSelect.jsp?op=pic_display&name=&inspector=&xkh=&date1=30140101&date2=" target="bench">案件照片</a></li>
            	<li><a href="CaseSelect.jsp?op=pic_upload&name=&inspector=&xkh=&date1=30140101&date2=" target="bench">上传照片</a></li>
                <li><a href="CaseSelect.jsp?op=pic_edit&name=&inspector=&xkh=&date1=30140101&date2=" target="bench">照片编辑</a></li>
                <li><a href="CaseSelect.jsp?op=pic_delete&name=&inspector=&xkh=&date1=30140101&date2=" target="bench">删除照片</a></li>
            </ul>    
        </li>
		<li><a href="#">系统管理</a>
        	<ul class="myHide">
            	<li><a href="YongHuShuXing.jsp" target="bench">增加用户</a></li>
                <li><a href="YongHuChaXun.jsp" target="bench">查询用户</a></li>
            	<li><a href="YongHuShanChu.jsp" target="bench">删除用户</a></li>
       			<li><a href="CunChuShuXing.jsp" target="bench">添加存储器</a></li>
           		<li><a href="CunChuChaXun.jsp" target="bench">查询存储器</a></li>
       			<li><a href="CunChuShanChu.jsp" target="bench">删除存储器</a></li>
       			<li><a href="/start/servlet/Beifen" target="bench">新备份</a></li>
       			<li><a href="BeiFenChaXun.jsp" target="bench">备份查询</a></li>
       			<li><a href="ShuJuKuHuanYuan.jsp" target="bench">数据库还原</a></li>
       			<li><a href="data_recovery.jsp" target="bench">数据恢复</a></li>
             </ul>
        </li>
		<li><a href="MiMaXiuGai.jsp" target="bench">修改密码</a></li>
		<li><a href="#" onclick="javascript:top.close();">退出</a></li>
	</ul>
</div>
</body>
</html>