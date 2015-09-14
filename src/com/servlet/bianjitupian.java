package com.servlet;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException; 
import java.io.InputStream;
//import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.imageio.ImageIO;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

//import com.think.image.RotateImage;
//import com.think.image.Test;

import com.util.DBUtil;
      
public class bianjitupian extends HttpServlet
{
	
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		this.doPost(request, response);
	}

 

	/**
	 * The doPost method of the servlet. <br>
	 *
	 * This method is called when a form has its tag value method equals to post.
	 * 
	 * @param request the request send by the client to the server
	 * @param response the response send by the server to the client
	 * @throws ServletException if an error occurred
	 * @throws IOException if an error occurred
	 */
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String case_id = request.getParameter("case_id");
		String picture = request.getParameter("picture");
		int angle = Integer.parseInt(request.getParameter("zxxRotAngle_"));
		int x = Integer.parseInt(request.getParameter("cropPosX_"));
		int y = Integer.parseInt(request.getParameter("cropPosY_"));
		int w = Integer.parseInt(request.getParameter("cropImageWidth_"));
		int h = Integer.parseInt(request.getParameter("cropImageHeight_"));
		
		//����Ķ�����Ҫ�����Ƕ�ͼƬ���в���
				//��ȡ�ļ�·��
				String filePath = request.getRealPath("")+"/UploadPhoto/"+picture;
				String newFilePath = request.getRealPath("")+"/User/UserHeadImage/"+picture;
				
				BufferedImage src = ImageIO.read(new File(filePath));			
				//��ת
				//BufferedImage des = RotateImage.Rotate(src, angle);
				//�ü�
				//Test.abscut2(des,newFilePath, x, y, w, h,des.getWidth(),des.getHeight());
				//���	
				saveImage(newFilePath);
				//��תҳ��
				response.sendRedirect("/start/uploadimage.jsp?Picurl="+picture+"&step=3");
				
			}
			
			private void saveImage(String filePath) {
				 Connection con = null ;
				 PreparedStatement pstmt = null;
				 try {
			          
			           con= new DBUtil().getConnection();	          
			           String sql = "";
			           //File�Ǹ�ʲô�����أ�����
			           File file = new File(filePath);
			           InputStream photoStream = new FileInputStream(file);	            
			           sql = "INSERT INTO photo (tp) VALUES(?)";
			           pstmt = con.prepareStatement(sql);
			           pstmt.setBinaryStream(1,photoStream,(int)file.length()); 
			           /*pstmt.setInt(2, 5);*/
			           
					//��ô��ȡcase_idֵ������
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
			

	/**
	 * Initialization of the servlet. <br>
	 *
	 * @throws ServletException if an error occurs
	 */
	public void init() throws ServletException {
		// Put your code here
	}

}
