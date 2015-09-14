<%@ page language="java" pageEncoding="UTF-8"%>

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




<%@page import="java.awt.Color"%>
<%@page import="java.awt.Font"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.text.NumberFormat"%>
<%@page import="java.io.FileOutputStream"%>


<%
  /********基础数据**********/
  
  
  double[] value = { 584373,1389175,2132387,820757,804882};
  String[] keys = { "华北", "华中", "华东","东北","西北" };
  String chartTitle = "等级分布图";
  int width = 470;
  int height = 350;
  /*****************/


  DefaultPieDataset dataset = new DefaultPieDataset();
  for (int i = 0; i < value.length; i++) {
    dataset.setValue(keys[i], value[i]);
  }


  JFreeChart chart =ChartFactory.createPieChart("",dataset,false,true,true);


  chart.setTextAntiAlias(false);
  PiePlot piePlot=(PiePlot)chart.getPlot();
  piePlot.setBackgroundPaint(null);//背景色


  PiePlot plot = (PiePlot) chart.getPlot();
  // 图片中显示百分比:默认方式
   
  
  
            plot.setSectionPaint("华北", Color.decode("#24F4DB"));  
            plot.setSectionPaint("华中", Color.decode("#7979FF"));  
            plot.setSectionPaint("华东", Color.decode("#00BF00"));  
            plot.setSectionPaint("东北", Color.decode("#F8D661")); 
            plot.setSectionPaint("西北", Color.decode("#F284DC")); 
  // 指定饼图轮廓线的颜色
  plot.setBaseSectionOutlinePaint(Color.white);
  plot.setBaseSectionPaint(Color.white);


  // 设置无数据时的信息
 // plot.setNoDataMessage("无对应的数据，请重新查询。");




  // 图片中显示百分比:自定义方式，{0} 表示选项， {1} 表示数值， {2} 表示所占比例 ,小数点后两位
  plot.setLabelGenerator(new StandardPieSectionLabelGenerator("{0} {1}(㎡)  ({2})", NumberFormat
      .getNumberInstance(), new DecimalFormat("0.00%")));
  // 图例显示百分比:自定义方式， {0} 表示选项， {1} 表示数值， {2} 表示所占比例
  plot.setLegendLabelGenerator(new StandardPieSectionLabelGenerator("{0}={1}({2})"));


  //图片说明显示格式
  //plot.setLabelFont(new Font("隶书", Font.TRUETYPE_FONT, 18));
  plot.setLabelFont(new Font("宋体", 0, 14));   


  // 指定图片的透明度(0.0-1.0)
  plot.setForegroundAlpha(1.0f);
  // 指定显示的饼图上圆形(true)还椭圆形(false)
  plot.setCircular(true, true);


  // 设置第一个 饼块section 的开始位置，默认是12点钟方向
  plot.setStartAngle(45);




  ChartRenderingInfo info = new ChartRenderingInfo(new StandardEntityCollection());


  String filename = ServletUtilities.saveChartAsPNG(chart, width, height, info, session);


  String graphURL = request.getContextPath() + "/servlet/DisplayChart?filename=" + filename;




%>


<HTML>
 <HEAD>
  <TITLE>Welcome to Jfreechart !</TITLE>
 </HEAD>
 <BODY>
  <P ALIGN="left">
   <img src="<%=graphURL%>" width=<%=width%> height=<%=height%> border=0
    usemap="#<%= filename %>">
  </P>
 </BODY>
</HTML>


