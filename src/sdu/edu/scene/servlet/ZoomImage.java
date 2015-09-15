package sdu.edu.scene.servlet;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.imageio.ImageIO;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import sdu.edu.scene.util.DBUtil;

//import com.think.image.RotateImage;
//import com.think.image.Test;

public class ZoomImage extends HttpServlet {

	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		this.doPost(request, response);
	}

	// private static final long serialVersionUID = 1L;

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String case_id = request.getParameter("case_id");
		String picture = request.getParameter("picture");
		int angle = Integer.parseInt(request.getParameter("zxxRotAngle_"));
		int x = Integer.parseInt(request.getParameter("cropPosX_"));
		int y = Integer.parseInt(request.getParameter("cropPosY_"));
		int w = Integer.parseInt(request.getParameter("cropImageWidth_"));
		int h = Integer.parseInt(request.getParameter("cropImageHeight_"));
		/*
		 * System.out.println(request.getParameter("zxxRotAngle_"));
		 * System.out.println(request.getParameter("cropPosX_"));
		 * System.out.println(request.getParameter("cropPosY_"));
		 * System.out.println(request.getParameter("cropImageWidth_"));
		 * System.out.println(request.getParameter("cropImageHeight_"));
		 */

		/*
		 * System.out.println("x : "+x); System.out.println("y : "+y);
		 * System.out.println("w : "+w); System.out.println("h : "+h);
		 * System.out.println("picture : "+picture);
		 */

		// 下面的东西主要工作是对图片进行操作
		// 获取文件路径
		String filePath = request.getRealPath("") + "/UploadPhoto/" + picture;
		String newFilePath = request.getRealPath("") + "/User/UserHeadImage/"
				+ picture;

		BufferedImage src = ImageIO.read(new File(filePath));
		// 旋转
		// /BufferedImage des = RotateImage.Rotate(src, angle);
		// 裁剪
		// Test.abscut2(des,newFilePath, x, y, w,
		// h,des.getWidth(),des.getHeight());
		// 入库
		saveImage(newFilePath);
		// 跳转页面
		response.sendRedirect("/start/uploadimage.jsp?Picurl=" + picture
				+ "&step=3");

	}

	private void saveImage(String filePath) {
		Connection con = null;
		PreparedStatement pstmt = null;
		try {

			con = new DBUtil().getConnection();
			String sql = "";
			File file = new File(filePath);
			InputStream photoStream = new FileInputStream(file);
			sql = "INSERT INTO photo (tp) VALUES(?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setBinaryStream(1, photoStream, (int) file.length());
			/* pstmt.setInt(2, 5); */

			// 怎么获取case_id值并插入
			// pstmt.setInt(2, "case_id");
			pstmt.execute();

		} catch (Exception e) {
			System.err.println("Error");
			e.printStackTrace();
		} finally {
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			if (con != null) {
				try {
					con.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		}
	}

}
