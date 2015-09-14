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

import com.util.DBUtil;

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
		//getParameter():ָ������������ƣ���ȡ�ö�Ӧ���趨ֵ
		String id = request.getParameter("img_id");
		//Connection �������򿪵ġ�������Դ������
		Connection conn = null;
		//Statement �� Java ִ�����ݿ������һ����Ҫ�������������Ѿ��������ݿ����ӵĻ����ϣ������ݿⷢ��Ҫִ�е�SQL��䡣Statement��������ִ�в��������ļ�SQL���
		Statement stmt = null;
		//ResultSet��ʾ���ݿ����������ݱ�ͨ��ͨ��ִ�в�ѯ���ݿ���������
		ResultSet rs = null;
		try {
			conn = new DBUtil().getConnection();
			stmt = conn.createStatement();
			String sql = " SELECT * FROM PHOTO WHERE id = " + id;
			rs = stmt.executeQuery(sql);
			if (rs.next()) {
				//BLOB (binary large object)�������ƴ����
				Blob b = rs.getBlob("tp");
				//length()���ش� Blob ����ָ���� BLOB ֵ�е��ֽ���
				long size = b.length();
				//getBytes()�� byte �������ʽ��ȡ�� Blob �����ʾ��ȫ���򲿷� BLOB ֵ,byte ���������λ�� pos ��ʼ�� length �������ֽ�
				byte[] bs = b.getBytes(1, (int) size);
				response.setContentType("image/jpeg");
				OutputStream outs = response.getOutputStream();
				//���byte[]
				outs.write(bs);
				//ˢ�´��������ǿ��д�����л��������ֽ�
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
