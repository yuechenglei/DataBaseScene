package com.servlet;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.UUID;

import javax.imageio.ImageIO;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import sdu.edu.scene.util.CutImage;
import sdu.edu.scene.util.DBUtil;
import sdu.edu.scene.util.FilterImage;
import sdu.edu.scene.util.HSLFilter;
import sdu.edu.scene.util.ImageChange;
import sdu.edu.scene.util.ScaleImage;

public class SaveCutImage extends HttpServlet {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String sPath = "/UploadPhoto";

	@SuppressWarnings("deprecation")
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		int x = Integer
				.valueOf(request.getParameter("imgTop") != null ? request
						.getParameter("imgTop") : "0");
		int y = Integer
				.valueOf(request.getParameter("imgLeft") != null ? request
						.getParameter("imgLeft") : "0");
		int width = Integer
				.valueOf(request.getParameter("imgWidth") != null ? request
						.getParameter("imgWidth") : "0");
		int height = Integer
				.valueOf(request.getParameter("imgHeight") != null ? request
						.getParameter("imgHeight") : "0");
		float scale = Float
				.valueOf(request.getParameter("imgScale") != null ? request
						.getParameter("imgScale") : "0");
		float bhd = Float.valueOf(request.getParameter("bhd") != null ? request
				.getParameter("bhd") : "0");
		float imgrol = Float
				.valueOf(request.getParameter("imgrol") != null ? request
						.getParameter("imgrol") : "0");
		String icon = "";
		String id = request.getParameter("id");
		String caseid = request.getParameter("caseid");
		//先把数据库中的文件导出到硬盘中
		String fileName = request.getRealPath("/") + sPath + "/tempImage.jpg";
		Connection con;
		Statement stmt;
		ResultSet rs;
		OutputStream os = null;
		BufferedImage srcImage;
		InputStream in = null;
		FileInputStream str = null;
		try {
			Class.forName("com.mysql.jdbc.Driver");
			con = DriverManager
					.getConnection("jdbc:mysql://localhost:3306/scene?user=root&password="
							+ sdu.edu.scene.db.DBInfo.getPassword());
			stmt = con.createStatement();
			String sql;
			sql = "select tp_new,icon from photo where id=" + id;
			rs = stmt.executeQuery(sql);
			while (rs.next()) {
				byte[] b = rs.getBytes("tp_new");
				icon = rs.getString("icon");
				if (null != b && b.length > 1) {
					os = new FileOutputStream(new File(fileName));
					os.write(b);
					os.close();
				}
			}
			rs.close();
			//图片旋转ת
			if (Math.round(imgrol) > 0) {
				if (in != null) {
					in.close();
				}
				in = new FileInputStream(fileName);
				srcImage = javax.imageio.ImageIO.read(in);
				if (in != null) {
					in.close();
				}
				in = ImageChange.rotateImg(srcImage, Math.round(imgrol * 90),
						null);
				ImageIO.write(javax.imageio.ImageIO.read(in), "jpg", new File(
						fileName));
			}
			//保存裁剪后的图片
			CutImage o = new CutImage(Math.round(x / scale), Math.round(y
					/ scale), Math.round(width / scale), Math.round(height
					/ scale));
			o.setSrcpath(fileName);
			o.setSubpath(fileName);
			o.cut();
			 //亮度对比度设置 饱和度
			float brightness = Float
					.valueOf(request.getParameter("liandu") != null ? request
							.getParameter("liandu") : "0");
			float contrast = Float
					.valueOf(request.getParameter("duibi") != null ? request
							.getParameter("duibi") : "0");
			if (in != null) {
				in.close();
			}
			in = new FileInputStream(fileName);
			srcImage = javax.imageio.ImageIO.read(in);
			if (Math.round(bhd) != 0 || Math.round(brightness) != 0) {
				HSLFilter h = new HSLFilter();
				if (Math.round(bhd) != 0) {
					h.setSaturation(bhd);//饱和度
				}
				if (Math.round(brightness) != 0) {
					h.setLightness(brightness);// 亮度
				}
				srcImage = h.filter(srcImage, srcImage);
				ImageIO.write(srcImage, "jpg", new File(fileName));
			}
			if (Math.round(contrast) != 1) {
				FilterImage f = new FilterImage();
				f.setContrast(contrast);// �Աȶ�
				srcImage = f.filter(srcImage, srcImage);
			}
			ImageIO.write(srcImage, "jpg", new File(fileName));
			 //保存相关数据
			str = new FileInputStream(fileName);
			sql = "update photo set tp_new = ?, width=?, height=?, bhd=?, angle=?, dbd=?, ld=?, x1=?,y1=? where id="
					+ id;
			PreparedStatement pstmt = new DBUtil().getConnection()
					.prepareStatement(sql);
			pstmt.setBinaryStream(1, str, str.available());
			pstmt.setFloat(2, width);
			pstmt.setFloat(3, height);
			pstmt.setFloat(4, bhd);
			pstmt.setFloat(5, imgrol);
			pstmt.setFloat(6, contrast);
			pstmt.setFloat(7, brightness);
			pstmt.setFloat(8, Math.round(x / scale));
			pstmt.setFloat(9, Math.round(y / scale));
			pstmt.execute();
			//生成新的缩略图
			String newFileName = request.getRealPath("") + icon;
			in.close();
			in = new FileInputStream(fileName);
			;
			ScaleImage.saveImageAsJpg(in, newFileName, 150, 200);
			in.close();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (os != null) {
				os.close();
			}
			if (in != null) {
				in.close();
			}
			if (str != null) {
				str.close();
			}
			//删除临时文件
			File file = new File(fileName);
			file.delete();
			response.sendRedirect("/start/PicEdit.jsp?id=" + id + "&caseid="
					+ caseid + "&submit=ok&temp="
					+ UUID.randomUUID().toString());

		}
	}

	public void init(ServletConfig config) throws ServletException {
	}

}
