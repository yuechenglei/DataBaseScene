<%@ page language="java" import="java.util.*,java.sql.*" pageEncoding="UTF-8"%>

<%@page import="org.jfree.chart.ChartUtilities"%>
<%@page import="org.jfree.chart.ChartFactory"%>
<%@page import="org.jfree.chart.JFreeChart"%>
<%@page import="org.jfree.chart.labels.StandardPieSectionLabelGenerator"%>
<%@page import="org.jfree.chart.plot.PiePlot"%>
<%@page import="org.jfree.chart.title.TextTitle"%>
<%@page import="org.jfree.data.general.DefaultPieDataset"%>
<%@page import="org.jfree.chart.ChartRenderingInfo"%>
<%@page import="org.jfree.chart.entity.StandardEntityCollection"%>
<%@page import="org.jfree.chart.servlet.ServletUtilities"%>
<%@page import="java.awt.BasicStroke"%>
<%@page import="java.awt.Color"%>
<%@page import="java.awt.Font"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.text.NumberFormat"%>
<%@page import="java.io.FileOutputStream"%>
<%@page import="java.io.File"%>


<%
  double[] value = { 584373,1389175,2132387};
  String[] keys = { "磁盘空闲", "本系统占用", "其他"};
  String chartTitle = "等级分布图";
  int width = 400;
  int height = 400;

  File file = new File("c:");  
  long totalSpace = file.getTotalSpace();  
  long freeSpace = file.getFreeSpace();  
  long usedSpace = totalSpace - freeSpace;
  value[0] = freeSpace/1024/1024/1024;
  value[1] = 25;
  value[2] = totalSpace/1024/1024/1024 - value[0] - value[1];
  
  DefaultPieDataset dataset = new DefaultPieDataset();
  for (int i = 0; i < value.length; i++) {
    dataset.setValue(keys[i], value[i]);
  }

  JFreeChart chart =ChartFactory.createPieChart("",dataset,false,true,true);


  chart.setTextAntiAlias(false);
//  chart.setBorderVisible(false);   
  PiePlot piePlot=(PiePlot)chart.getPlot();

  PiePlot plot = (PiePlot) chart.getPlot();
  
  // 图片中显示百分比:默认方式
  plot.setOutlineVisible(false);  
  plot.setSectionPaint("磁盘空闲", Color.decode("#BBFFBB"));  
  plot.setSectionPaint("本系统占用", Color.decode("#FFBBBB"));  
  plot.setSectionPaint("其他", Color.decode("#BBBBFF"));  
  
  // 饼图轮廓线
  plot.setBaseSectionPaint(Color.white);
  plot.setBaseSectionOutlinePaint(Color.GRAY);
  plot.setBaseSectionOutlineStroke(new BasicStroke(0));

  // 设置背景色
  plot.setBackgroundPaint(Color.white);

  // 图片中显示百分比:自定义方式，{0} 表示选项， {1} 表示数值， {2} 表示所占比例 ,小数点后两位
  plot.setLabelGenerator(new StandardPieSectionLabelGenerator("{0} {1}(GB)  ({2})", NumberFormat.getNumberInstance(), new DecimalFormat("0.00%")));
  // 图例显示百分比:自定义方式， {0} 表示选项， {1} 表示数值， {2} 表示所占比例
  plot.setLegendLabelGenerator(new StandardPieSectionLabelGenerator("{0}={1}({2})"));

  //图片说明显示格式
  //plot.setLabelFont(new Font("隶书", Font.TRUETYPE_FONT, 18));
  plot.setLabelFont(new Font("宋体", 0, 14));   

  // 指定图片的透明度(0.0-1.0)
  plot.setForegroundAlpha(1.0f);
  // 指定显示的饼图上圆形(true)还是椭圆形(false)
  plot.setCircular(true, true);

  // 设置第一个 饼块section 的开始位置，默认是12点钟方向
  plot.setStartAngle(0);
  ChartRenderingInfo info = new ChartRenderingInfo(new StandardEntityCollection());
  String filename = ServletUtilities.saveChartAsPNG(chart, width, height, info, session);
  String graphURL = request.getContextPath() + "/servlet/DisplayChart?filename=" + filename;

%>
<script type="text/javascript">
function resize(obj)
{
	w = (document.body.clientWidth-100)/3;
	document.getElementById("img1").width = w;
	document.getElementById("img1").height = w;
	document.getElementById("img2").width = w;
	document.getElementById("img2").height = w;
	document.getElementById("img3").width = w;
	document.getElementById("img3").height = w;
}
</script>

<%
	Class.forName("com.mysql.jdbc.Driver");  
	Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/scene?user=root&password="+sdu.edu.scene.db.DBInfo.getPassword());  
	Statement stmt=con.createStatement();  
	String sql;
	int	c_num, p_num;
	sql= "select id from scene.case";  
	ResultSet rs=stmt.executeQuery(sql);
	rs.last();
	c_num = rs.getRow();
	rs.close();
	sql= "select id from scene.photo";  
	rs=stmt.executeQuery(sql);
	rs.last();
	p_num = rs.getRow();
	rs.close();
	con.close();
%>
<head>
<style>
</style>
<link rel="stylesheet" href="//cdn.bootcss.com/bootstrap/3.3.5/css/bootstrap.min.css">
</head>
<BODY onload="resize()" bgcolor=#FFFFFF>
<table>
	<tr style="height:200">
		<td style="align:center; width:500; height:50">
		</td>
		<td style="align:center; width:500; height:50">
		</td>
		<td style="align:center; width:500; height:50">
		</td>
	</tr>
	<tr>
		<td align="center">
   			<img id="img1" src="<%=graphURL%>" border=0 usemap="#<%= filename %>">
		</td>
		<td align="center">
  			<img id="img2" src="<%=graphURL%>" border=0 usemap="#<%= filename %>">
		</td>
		<td align="center">
  			<img id="img3" src="<%=graphURL%>" border=0 usemap="#<%= filename %>">
		</td>
	</tr>
	<tr>
	<td align="center" style="height:30">系统案件数量：<%=c_num%>
	</td>
	</tr>
	<tr>
	<td align="center" style="height:30">系统照片数量：<%=p_num%>
	</td>
	</tr>
</table>
</BODY>
</HTML>


