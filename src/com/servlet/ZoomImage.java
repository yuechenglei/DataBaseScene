package com.servlet;

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

import com.jspsmart.upload.Request;
//import com.think.image.RotateImage;
//import com.think.image.Test;
import com.util.*;

public class ZoomImage extends HttpServlet
{
	
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		this.doPost(request, response);
	}
	
	//private static final long serialVersionUID = 1L;

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException
	{

		String case_id = request.getParameter("case_id");
		String picture = request.getParameter("picture");
		int angle = Integer.parseInt(request.getParameter("zxxRotAngle_"));
		int x = Integer.parseInt(request.getParameter("cropPosX_"));
		int y = Integer.parseInt(request.getParameter("cropPosY_"));
		int w = Integer.parseInt(request.getParameter("cropImageWidth_"));
		int h = Integer.parseInt(request.getParameter("cropImageHeight_"));
		/*
		System.out.println(request.getParameter("zxxRotAngle_"));
		System.out.println(request.getParameter("cropPosX_"));
		System.out.println(request.getParameter("cropPosY_"));
		System.out.println(request.getParameter("cropImageWidth_"));
		System.out.println(request.getParameter("cropImageHeight_"));*/
		
		/*System.out.println("x : "+x);
		System.out.println("y : "+y);
		System.out.println("w : "+w);
		System.out.println("h : "+h);
		System.out.println("picture : "+picture);	*/			
		
		//涓嬮潰鐨勪笢瑗夸富瑕佸伐浣滄槸瀵瑰浘鐗囪繘琛屾搷浣�
		//鑾峰彇鏂囦欢璺緞
		String filePath = request.getRealPath("")+"/UploadPhoto/"+picture;
		String newFilePath = request.getRealPath("")+"/User/UserHeadImage/"+picture;
		
		BufferedImage src = ImageIO.read(new File(filePath));			
		//鏃嬭浆
		//BufferedImage des = RotateImage.Rotate(src, angle);
		//瑁佸壀
		//sTest.abscut2(des,newFilePath, x, y, w, h,des.getWidth(),des.getHeight());
		//鍏ュ簱	
		saveImage(newFilePath);
		//璺宠浆椤甸潰
		response.sendRedirect("/start/uploadimage.jsp?Picurl="+picture+"&step=3");
		
	}
	
	private void saveImage(String filePath) {
		 Connection con = null ;
		 PreparedStatement pstmt = null;
		 try {
	          
	           con= new DBUtil().getConnection();	          
	           String sql = "";
	           //File鏄釜浠�箞涓滆タ鍛紵锛燂紵
	           File file = new File(filePath);
	           InputStream photoStream = new FileInputStream(file);	            
	           sql = "INSERT INTO photo (tp) VALUES(?)";
	           pstmt = con.prepareStatement(sql);
	           pstmt.setBinaryStream(1,photoStream,(int)file.length()); 
	           /*pstmt.setInt(2, 5);*/
	           
			//鎬庝箞鑾峰彇case_id鍊煎苟鎻掑叆
	           //pstmt.setInt(2, "case_id");
	           pstmt.execute();
	           
	        } catch (Exception e) {
	                System.err.println("Error");
	                e.printStackTrace();
	        }finally{
	        	if(pstmt!=null){
	        		try {
						pstmt.close();
					} catch (SQLException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
	        	}
	        	if(con!=null){
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
