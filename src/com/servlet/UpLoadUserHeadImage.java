package com.servlet;

import java.io.FileInputStream;


import java.io.IOException;
import java.sql.PreparedStatement;

import javax.servlet.ServletConfig;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.jspsmart.upload.File;
import com.jspsmart.upload.SmartUpload;
import com.util.DBUtil;
import com.util.ScaleImage;

public class UpLoadUserHeadImage extends HttpServlet {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private ServletConfig config = null;

	@SuppressWarnings({ "deprecation", "static-access" })

	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		SmartUpload mySmartUpload = new SmartUpload();
		mySmartUpload.initialize(config, request, response);
		mySmartUpload.setMaxFileSize(2048 * 3072);
		mySmartUpload.setAllowedFilesList("jpg,JPG,gif,png,jpeg,bmp");
		String case_id = request.getParameter("case_id");
		try {
			mySmartUpload.upload();
			File myFile = mySmartUpload.getFiles().getFile(0);
			if (!myFile.isMissing()) {
System.out.println("11111111111111111111111="+request.getRealPath("/")); 		
				myFile.saveAs("/workdir/upload_temp.jpg", mySmartUpload.SAVE_VIRTUAL);
System.out.println("222222222222222222222222");				
				FileInputStream fis_pic = new FileInputStream(request.getRealPath("/workdir/upload_temp.jpg")); 
System.out.println("33333333333333333333");				
				FileInputStream fis_pic1 = new FileInputStream(request.getRealPath("/workdir/upload_temp.jpg")); 
System.out.println("44444444444444444444");
				ScaleImage.saveImageAsJpg(fis_pic1, request.getRealPath("/workdir/icon_temp.jpg"), 100, 75);
System.out.println("55555555555555");
				FileInputStream fis_icon = new FileInputStream(request.getRealPath("/workdir/icon_temp.jpg")); 
System.out.println("66666666666666666666");				
				String sql="insert into photo(picture, icon, hash, case_id, name, brightness, contrast, saturation, angle, clip_left, clip_top, clip_width, clip_height) values(?,?,?,?,?,?,?,?,?,?,?,?,?)";				
				PreparedStatement pst = new DBUtil().getConnection().prepareStatement(sql);
				pst.setBinaryStream(1, mySmartUpload.get_inputstream(), mySmartUpload.get_inputstream().available());
//				pst.setBinary.setBinaryStream(1, fis_pic, fis_pic.available());
				pst.setBinaryStream(2, fis_icon, fis_icon.available());
				pst.setInt(3,fis_pic.hashCode());
				pst.setString(4,case_id);
				pst.setString(5,myFile.getFileName());
				pst.setString(6,"1");
				pst.setString(7,"1");
				pst.setString(8,"1");
				pst.setString(9,"0");
				pst.setString(10,"0");
				pst.setString(11,"0");
				pst.setString(12,"0");
				pst.setString(13,"0");
				pst.execute(); 
				fis_pic.close();
				fis_pic1.close();
				fis_icon.close();

//				InputStream in = new FileInputStream(request.getRealPath("/") + sPath + "/" + FileName);
//				ScaleImage.saveImageAsJpg(in, request.getRealPath("/") + sPath + "/" + FileName, 150, 200);

				response.sendRedirect("/start/uploadimage.jsp?case_id=" + case_id + "&submit=ok");
			}
			else
				response.sendRedirect("/start/uploadimage.jsp?case_id=" + case_id + "&submit=no");
		}
		catch (Exception e) {
			e.printStackTrace();
			response.sendRedirect("/start/uploadimage.jsp?case_id=" + case_id + "&submit=no");
		}
	}

/*
	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		SmartUpload mySmartUpload = new SmartUpload();
		mySmartUpload.initialize(config, request, response);
		mySmartUpload.setMaxFileSize(2048 * 1024);
		mySmartUpload.setAllowedFilesList("jpg,gif,png,jpeg,bmp");
		String id = request.getParameter("id");
		try {
			mySmartUpload.upload();
			File myFile = mySmartUpload.getFiles().getFile(0);
			if (!myFile.isMissing()) {
				//保存文件
				Date currTime = new Date();
				SimpleDateFormat formatter2 = new SimpleDateFormat("yyyyMMddhhmmssS", Locale.US);
				FileName = new String((formatter2.format(currTime)).getBytes("iso-8859-1"));
				String ext = myFile.getFileExt();
				FileName = FileName + "." + ext;
				myFile.saveAs(sPath + "/" + FileName, mySmartUpload.SAVE_VIRTUAL);
				//文件信息保存进数据库
				FileInputStream str=new FileInputStream(request.getRealPath("/") + sPath + "/" + FileName); 
				FileInputStream str1 = new FileInputStream(request.getRealPath("/") + sPath + "/" + FileName); ;
				String sql="insert into photo(case_id, picture, hash, icon, name, tp_new) values(?,?,?,?,?,?)";
				PreparedStatement pstmt=new DBUtil().getConnection().prepareStatement(sql);
				pstmt.setString(1,id);
				pstmt.setBinaryStream(2,str,str.available());
				pstmt.setInt(3,str.hashCode());
				pstmt.setString(4,sPath + "/" + FileName);
				pstmt.setString(5,myFile.getFileName());
				pstmt.setBinaryStream(6,str1,str1.available());
				pstmt.execute(); 
				str.close();
				str1.close();
				//保存缩略图150*200
				InputStream in = new FileInputStream(request.getRealPath("/") + sPath + "/" + FileName); ;
				ScaleImage.saveImageAsJpg(in, request.getRealPath("/") + sPath + "/" + FileName, 150, 200);
				in.close();
			}
			
			response.sendRedirect("/start/uploadimage.jsp?id=" + id + "&submit=ok");
		} catch (Exception e) {
			e.printStackTrace();
			response.sendRedirect("/start/uploadimage.jsp?id=" + id + "&submit=no");
		}
	}
*/
	public void init(ServletConfig config) throws ServletException {
		this.config = config;
	}

}
