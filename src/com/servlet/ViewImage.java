package com.servlet;

import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.sql.Blob;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import sdu.edu.scene.util.DBUtil;

public class ViewImage extends HttpServlet {

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
		//getParameter():指定请求参数名称，以取得对应的设定值
		String id = request.getParameter("img_id");
		//Connection 对象代表打开的、与数据源的连接
		Connection conn = null;
		//Statement 是 Java 执行数据库操作的一个重要方法，用于在已经建立数据库连接的基础上，向数据库发送要执行的SQL语句。Statement对象，用于执行不带参数的简单SQL语句
		Statement stmt = null;
		//ResultSet表示数据库结果集的数据表，通常通过执行查询数据库的语句生成
		ResultSet rs = null;
		try {
			conn = new DBUtil().getConnection();
			stmt = conn.createStatement();
			String sql = " SELECT * FROM PHOTO WHERE id = " + id;
			rs = stmt.executeQuery(sql);
			if (rs.next()) {
				//BLOB (binary large object)，二进制大对象
				Blob b = rs.getBlob("tp");
				//length()返回此 Blob 对象指定的 BLOB 值中的字节数
				long size = b.length();
				//getBytes()以 byte 数组的形式获取此 Blob 对象表示的全部或部分 BLOB 值,byte 数组包含从位置 pos 开始的 length 个连续字节
				byte[] bs = b.getBytes(1, (int) size);
				response.setContentType("image/jpeg");
				OutputStream outs = response.getOutputStream();
				//输出byte[]
				outs.write(bs);
				//刷新此输出流并强制写出所有缓冲的输出字节
				outs.flush();
				outs.close();
			} else {				
				response.sendRedirect("/start/error.jsp");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			if (rs != null) {
				try {
					rs.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			if (stmt != null) {
				try {
					stmt.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			if (conn != null) {
				try {
					conn.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		}
	}

}
