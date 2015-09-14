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

import com.util.CutImage;
import com.util.DBUtil;
import com.util.FilterImage;
import com.util.HSLFilter;
import com.util.ImageChange;
import com.util.ScaleImage;

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
		// �Ȱ����ݿ��е��ļ�������Ӳ����
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
							+ db.DBInfo.getPassword());
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
			// ͼƬ��ת
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
			// ����ü����ͼƬ
			CutImage o = new CutImage(Math.round(x / scale), Math.round(y
					/ scale), Math.round(width / scale), Math.round(height
					/ scale));
			o.setSrcpath(fileName);
			o.setSubpath(fileName);
			o.cut();
			// ���ȶԱȶ����� ���Ͷ�
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
					h.setSaturation(bhd);// ���Ͷ�
				}
				if (Math.round(brightness) != 0) {
					h.setLightness(brightness);// ����
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
			// �����������
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
			// �����µ�����ͼ
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
			// ɾ����ʱ�ļ�
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
