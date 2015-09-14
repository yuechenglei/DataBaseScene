package servlet;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import sdu.edu.scene.db.scene;

import com.jspsmart.upload.*;

public class PicsUpload extends HttpServlet {

	/**
	 * 
	 */
	
	private String case_id;
	private static final long serialVersionUID = 1L;

	/**
	 * Destruction of the servlet. <br>
	 */
	public void destroy() {
		super.destroy(); // Just puts "destroy" string in log
		// Put your code here
	}

	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		case_id = request.getParameter("case_id");
		return;
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

		SmartUpload su = new SmartUpload();
		su.initialize(getServletConfig(),request,response);
		try {
			//su.setAllowedFilesList("jpg,jpeg,JPG,gif");
			//su.setDeniedFilesList("exe");
			su.setAllowedFilesList("jpg,jpeg,JPG,gif,exe");
			su.setMaxFileSize(1024*1024*20);
			su.setTotalMaxFileSize(1024*1024*100);
			su.upload();
		} catch(Exception e){
			java.io.PrintWriter out = response.getWriter();  
			out.print("<script Lanuage='JavaScript'>window.alert('Only jpg, jpeg, JPG, gif are available! ')</script>");  
			e.printStackTrace();
		}
		case_id = request.getParameter("case_id");
		Files fs = su.getFiles();
		scene s = new scene();
		String user_id1 =(request.getSession().getAttribute("LoginId")).toString();
		int user_id = Integer.parseInt(user_id1);
		//涓嬮潰鐨�闇�鏀规垚涓婇潰鐨剈ser_id
		s.insertPhoto(fs, case_id,user_id);
		response.sendRedirect("/start/jspcl/BenchPrompt.jsp?result=1002");
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
