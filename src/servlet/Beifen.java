package servlet;

import java.io.IOException;
import java.io.File;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.swing.JFileChooser;
import javax.swing.JOptionPane;
import java.util.*;
import java.text.*;
import dao.LogDAO;

import db.FrameTest1;

public class Beifen extends HttpServlet {

	/**
	 * Constructor of the object.
	 */
	private static final long serialVersionUID = 1L;

	public Beifen() {
		super();
	}

	/**
	 * Destruction of the servlet. <br>
	 */
	public void destroy() {
		super.destroy(); // Just puts "destroy" string in log
		// Put your code here
	}

	/**
	 * The doGet method of the servlet. <br>
	 *
	 * This method is called when a form has its tag value method equals to get.
	 * 
	 * @param request the request send by the client to the server
	 * @param response the response send by the server to the client
	 * @throws ServletException if an error occurred
	 * @throws IOException if an error occurred
	 */
	public void doGet(HttpServletRequest request, HttpServletResponse response)	throws ServletException, IOException
	{
/*
		JFileChooser dialog = new JFileChooser();
		String str = "scene"+DateFormat.getInstance().format(new Date());
		String fName = str.split(" ")[0]+".sql";
		dialog.setSelectedFile(new File(fName));
		dialog.showOpenDialog(null);

		File f = dialog.getSelectedFile();
		String pName = f.getAbsolutePath();
		if (pName.contains(" ")) {
			JOptionPane.showMessageDialog(null,"文件路径名中不能包含空格！");
			response.sendRedirect("/start/jspcl/BenchPrompt.jsp?result=100");
			return;
		}
		f = new File(pName);
		if (f.exists()) {
			JOptionPane.showMessageDialog(null,"该文件在备份存储器上已经存在，请指定另外的文件名！");
			response.sendRedirect("/start/jspcl/BenchPrompt.jsp?result=100");
			return;
		}

		FrameTest1 BeiFenFrame = new FrameTest1(pName);
*/
		FrameTest1 BeiFenFrame = new FrameTest1("d:\\a.sql");

/*		
		JFileChooser dialog = new JFileChooser();
		String str = "scene"+DateFormat.getInstance().format(new Date());
		String fName = str.split(" ")[0]+".sql";
		dialog.setSelectedFile(new File(fName));
		dialog.showOpenDialog(null);

		File f = dialog.getSelectedFile();
		String pName = f.getAbsolutePath();
		if (pName.contains(" ")) {
			JOptionPane.showMessageDialog(null,"文件路径名中不能包含空格！");
			response.sendRedirect("/start/jspcl/BenchPrompt.jsp?result=100");
			return;
		}
		f = new File(pName);
		if (f.exists()) {
			JOptionPane.showMessageDialog(null,"该文件在备份存储器上已经存在，请指定另外的文件名！");
			response.sendRedirect("/start/jspcl/BenchPrompt.jsp?result=100");
			return;
		}
		String stmt="C:\\Program Files\\MySQL\\MySQL Server 5.6\\bin\\mysqldump scene --hex-blob -uroot -p85262660 --result-file="+pName;
		System.out.println("------------------------------------------ "+stmt);
		try {
			Runtime.getRuntime().exec(stmt);
			response.sendRedirect("/start/jspcl/BenchPrompt.jsp?result=101");
		}
		catch (IOException e) {
			e.printStackTrace();
			response.sendRedirect("/start/jspcl/BenchPrompt.jsp?result=100");
		}
*/
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
	public void doPost(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException
	{
		JFileChooser dialog = new JFileChooser();
		String str = "scene"+DateFormat.getInstance().format(new Date());
		String fName = str.split(" ")[0]+".sql";
		dialog.setSelectedFile(new File(fName));
		dialog.showOpenDialog(null);

		File f = dialog.getSelectedFile();
		String pName = f.getAbsolutePath();
		if (pName.contains(" ")) {
			JOptionPane.showMessageDialog(null,"文件路径名中不能包含空格！");
			response.sendRedirect("/start/jspcl/BenchPrompt.jsp?result=100");
			return;
		}
		f = new File(pName);
		if (f.exists()) {
			JOptionPane.showMessageDialog(null,"该文件在备份存储器上已经存在，请指定另外的文件名！");
			response.sendRedirect("/start/jspcl/BenchPrompt.jsp?result=100");
			return;
		}
		String stmt="C:\\Program Files\\MySQL\\MySQL Server 5.6\\bin\\mysqldump scene --hex-blob -uroot -pycl,,123 --result-file="+pName;
		System.out.println("------------------------------------------ "+stmt);
		try {
			Runtime.getRuntime().exec(stmt);
			response.sendRedirect("/start/jspcl/BenchPrompt.jsp?result=101");
		}
		catch (IOException e) {
			e.printStackTrace();
			response.sendRedirect("/start/jspcl/BenchPrompt.jsp?result=100");
		}
		LogDAO ld = new LogDAO();
		ld.delete_all();
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
