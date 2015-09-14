<%@ page language="java" import="java.util.*,java.sql.*, java.io.*"
	pageEncoding="UTF-8"%>

<%
	String photo_id = request.getParameter("photo_id");
	long k = Math.round(Math.random() * 10000);
	String str = "&x=" + String.valueOf(k);
	String client_width = request.getParameter("client_width");
	int width = Integer.parseInt(client_width) - 145;

	Class.forName("com.mysql.jdbc.Driver");
	Connection conn = DriverManager
	.getConnection("jdbc:mysql://localhost:3306/scene?user=root&password="+sdu.edu.scene.db.DBInfo.getPassword());
	Statement stmt = conn.createStatement();
	String sql;
	sql = "select picture, id, clip_left, clip_top, clip_width, clip_height, angle, saturation, brightness, contrast from photo where id="
	+ photo_id;
	ResultSet rs = stmt.executeQuery(sql);
	rs.next();
	String clip_left = rs.getString("clip_left");
	String clip_top = rs.getString("clip_top");
	String clip_width = rs.getString("clip_width");
	String clip_height = rs.getString("clip_height");
	String angle = rs.getString("angle");
	String saturation = rs.getString("saturation");
	String contrast = rs.getString("contrast");
	String brightness = rs.getString("brightness");
	rs.close();
	conn.close();
%>



<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<title>照片编辑</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<link rel="stylesheet" href="//cdn.bootcss.com/bootstrap/3.3.5/css/bootstrap.min.css">
<meta http-equiv="pragma" content="no-cache" />
<meta http-equiv="cache-control" content="no-cache" />
<meta http-equiv="expires" content="0" />

<script type="text/javascript">
	function verify() {
		if (edit.brightness.value<0 || edit.brightness.value>10) {
			alert("亮度参数应为0-10之间的实数！");
			return false;
		}
		if (edit.contrast.value<0 || edit.contrast.value>10) {
			alert("对比度参数应为0-10之间的实数！");
			return false;
		}
		if (edit.saturation.value<0 || edit.saturation.value>10) {
			alert("饱和度参数应为0-10之间的实数！");
			return false;
		}
		if (edit.clip_left.value<0 || edit.clip_left.value>95) {
			alert("裁剪窗口左侧参数应为0-95之间的整数！");
			return false;
		}
		if (edit.clip_top.value<0 || edit.clip_top.value>95) {
			alert("裁剪窗口上端参数应为0-95之间的整数！");
			return false;
		}
		if (edit.clip_width.value<5 || edit.clip_width.value>100) {
			alert("裁剪窗口宽度参数应为0-95之间的整数！");
			return false;
		}
		if (edit.clip_height.value<5 || edit.clip_left.value>100) {
			alert("裁剪窗口高度参数应为0-95之间的整数！");
			return false;
		}

		edit.submit();
<%String oldvalue = photo_id + "," + clip_left + "," + clip_top + ","
					+ clip_width + "," + clip_height + "," + angle + ","
					+ saturation + "," + contrast + "," + brightness;
			/* int user_id = (Integer) (request.getSession()
					.getAttribute("LoginId")); */
			session.setAttribute("oldvalue", oldvalue);

			//new LogDAO().changelog("update  ", oldvalue, 0 + "", 5,
			//		Integer.parseInt(photo_id));// 将插入照片的参数存入log表中%>
	}
</script>


</head>
<body style="margin:5px auto;">
	<table>
		<tr>
			<td><img width=<%=width%> id="ferret"
				src="/start/servlet/PhotoStream?photo_id=<%=photo_id + str%>"
				title="image select" alt="loading IMG ......" /></td>
			<td>
				<form name='edit' method="post"
					action="/start/jspcl/PhotoModify.jsp?photo_id=<%=photo_id + "&x="%>">
					<table border="1" style="margin:5px">
						<tr>
							<td colspan=2 style="text-algin:center"><center>颜色特性</center></td>
						</tr>
						<tr>
							<td style="width:70px; text-align:center">亮度</td>
							<td><input style="width:30px" name="brightness" type="text"
								value="<%=brightness%>"></input></td>
						</tr>
						<tr>
							<td style="width:70px; text-align:center">对比度</td>
							<td><input style="width:30px" name="contrast" type="text"
								value="<%=contrast%>"></input></td>
						</tr>
						<tr>
							<td style="width:70px; text-align:center">饱和度</td>
							<td><input style="width:30px" name="saturation" type="text"
								value="<%=saturation%>"></input></td>
						</tr>
						<tr>
							<td colspan="2" height=10px></td>
						</tr>
						<tr>
							<td style="width:70px; text-align:center">旋转角度</td>
							<td><input style="width:30px" name="angle" type="text"
								value="<%=angle%>"></input></td>
						</tr>
						<tr>
							<td colspan="2" height=10px><input name="client_width"
								type="hidden" value="<%=client_width%>"></input></td>
						</tr>
						<tr>
							<td colspan=2 style="text-algin:center"><center>裁剪窗口</center></td>
						</tr>
						<tr>
							<td style="width:70px; text-align:center">左端</td>
							<td><input style="width:30px" type="text" id="clip_left"
								name="clip_left" value="<%=clip_left%>" />&nbsp;%</td>
						</tr>
						<tr>
							<td style="width:70px; text-align:center">上端</td>
							<td><input style="width:30px" type="text" id="clip_top"
								name="clip_top" value="<%=clip_top%>" />&nbsp;%</td>
						</tr>
						<tr>
							<td style="width:70px; text-align:center">宽度</td>
							<td><input style="width:30px" type="text" id="clip_width"
								name="clip_width" value="<%=clip_width%>" />&nbsp;%</td>
						</tr>
						<tr>
							<td style="width:70px; text-align:center">高度</td>
							<td><input style="width:30px" type="text" id="clip_height"
								name="clip_height" value="<%=clip_height%>" />&nbsp;%</td>
						</tr>
						<tr>
							<td colspan="2" height=10px></td>
						</tr>
						<tr>
							<td align="center" colspan="2"><input class="button"
								type="button" value=" 提 交 " onclick="verify()" /> <!--  
						<input type="button" value=" 返 回 " onclick="edit.action='bench.jsp';edit.submit();" />
						--> <input type="button" value=" 返 回 "
								onclick="javascript:window.history.back();" /></td>
						</tr>
					</table>
				</form>
			</td>
		</tr>
	</table>


	<script src="js/jquery.js" type="text/javascript"></script>
	<script src="js/jquery.imgareaselect.js" type="text/javascript"></script>
	<script type="text/javascript">
		var container = 800;
		var imageW = 100;
		var imageH = 100;
		var minWidth = 200;
		var minHeight = 250;
		var scale = 0.25;
		function preview(img, selection) {
			imageW = $('#ferret').width();
			imageH = $('#ferret').height();
			var rLeft = Math.round(selection.x1 / imageW * 100);
			var rTop = Math.round(selection.y1 / imageH * 100);
			var rWidth = Math.round(selection.width / imageW * 100);
			var rHeight = Math.round(selection.height / imageH * 100);
			$('input#clip_left').val(rLeft);
			$('input#clip_top').val(rTop);
			$('input#clip_width').val(rWidth);
			$('input#clip_height').val(rHeight);
		}
		$(window).load(function() {
			$('input#cutImageW').val(200);
			$('input#cutImageH').val(250);
			$('input#cutImageX').val(0);
			$('input#cutImageY').val(0);

			imageW = $('#ferret').width();
			imageH = $('#ferret').height();
			$('#oimgW').html(imageW);
			$('#oimgH').html(imageH);
			var imgMax = imageW > imageH ? imageW : imageH;
			if (imgMax > container)
				container = imgMax;
			var minSelW = Math.round(imageW * scale);
			var minSelH = Math.round(imageH * scale);
			$('#imgDiv').css({
				'width' : minSelW + 'px',
				'height' : minSelH + 'px'
			});
			$('img#ferret').imgAreaSelect({
				selectionOpacity : 0,
				outerOpacity : '0.2',
				selectionColor : 'blue',
				onSelectChange : preview,
				minSelW : minSelW,
				minSelH : minSelH,
				aspectRatio : minSelW + ':' + minSelH,
				x1 : 0,
				y1 : 0,
				x2 : minSelW,
				y2 : minSelH
			});
		});
	</script>
</body>
</html>