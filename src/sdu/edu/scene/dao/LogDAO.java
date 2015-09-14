package sdu.edu.scene.dao;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.io.IOException;
import java.sql.*;

import sdu.edu.scene.util.DBUtil;

public class LogDAO {

	Connection conn = null;
	Statement st;
	ResultSet rs;

	public String get_valueofcase(String id) {
		conn = DBUtil.getConnection();
		String sql = "select * from scene.case where id=" + id;
		String str = "";
		try {
			st = conn.createStatement();
			rs = st.executeQuery(sql);
			rs.next();
			str += rs.getString(1) + ";";
			str += rs.getString(2) + ";";
			str += rs.getString(4) + ";";
			str += rs.getString(5) + ";";
			str += rs.getString(8) + ";";
			str += rs.getString(9) + ";";
			str += rs.getString(10);

			rs.close();
			conn.close();

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return str;
	}

	public String get_valueofphoto(String photo_id) {
		conn = DBUtil.getConnection();
		String sql = "select picture, id, clip_left, clip_top, clip_width, clip_height, "
				+ "angle, saturation, brightness, contrast from photo where id="
				+ photo_id;
		String str = "";
		try {
			st = conn.createStatement();
			rs = st.executeQuery(sql);
			rs.next();

			str += rs.getString("id") + ",";
			str += rs.getString("clip_left") + ",";
			str += rs.getString("clip_top") + ",";
			str += rs.getString("clip_width") + ",";
			str += rs.getString("clip_height") + ",";
			str += rs.getString("angle") + ",";
			str += rs.getString("saturation") + ",";
			str += rs.getString("contrast") + ",";
			str += rs.getString("brightness");

			rs.close();
			conn.close();

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return str;
	}

	// 鍚憀log琛ㄤ腑娣诲姞鏁版嵁
	public void changelog(String op, String oldvalue, String newvalue,
			int userid,int obj) {

		conn = DBUtil.getConnection();
		Date d = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String time = sdf.format(d);
		String sql = "insert into `log` (`when`,`operation`,`oldvalue`,`newvalue`,`user_id`,`obj`) values('"
				+ time
				+ "','"
				+ op
				+ "','"
				+ oldvalue
				+ "','"
				+ newvalue
				+ "','" + userid + "','"+obj+"')";
		System.out.println(sql);
		try {
			st = conn.createStatement();
			st.execute(sql);
			conn.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	//查询log表所有信息
	public ResultSet query_all(){
		conn = DBUtil.getConnection();
		String sql = "select * from log";
		try {
			st = conn.createStatement();
			rs = st.executeQuery(sql);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return rs;
	}
	
	public void del_and_rec(int id){
		conn = DBUtil.getConnection();
		String sql = "select * from log where id='"+id+"'";
		try {
			st = conn.createStatement();
			rs = st.executeQuery(sql);
			if(!rs.next())//没有这一列 直接返回
				return;
			else{
				int obj = rs.getInt(7);
				String operation = rs.getString(3);
				String oldvalue = rs.getString(4);
				String newvalue = rs.getString(5);
				if(obj==1){//恢复的是案件
					CaseDAO ca = new CaseDAO();
					if(operation.equals("insert")){
						ca.delete(newvalue);
					}
					else if(operation.equals("update")){
						ca.update(oldvalue);
					}
					else if(operation.equals("delete")){
						ca.insert(oldvalue);
					}
					else{
						System.out.println("在LogDAO的del_and_rec方法中出现错误");
					}
				}
				else if(obj==2){//恢复的是照片的属性  不能恢复删除的照片
					PhotoDAO pd = new PhotoDAO();
					if(operation.equals("update")){
						pd.update(oldvalue);
					}
					
				}
				else
					return;
				String sql1 = "delete from log where id='"+id+"'";
				st.executeUpdate(sql1);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	//查询log表最大的id值
	public int last_id(){
		conn = DBUtil.getConnection();
		int id=0;
		String sql = "select id from log order by id desc limit 0,1";
		try {
			st = conn.createStatement();
			rs = st.executeQuery(sql);
			rs.next();
			id = rs.getInt(1);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return id;
	}
	
	public void delete_all(){
		conn = DBUtil.getConnection();
		String sql = "delete from log where 1=1";
		try {
			st = conn.createStatement();
			st.executeUpdate(sql);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return;
	}
	/*
	public static void main(String[] args){
		LogDAO ld = new LogDAO();
		ResultSet rs = ld.query_all();
		try {
			while(rs.next()){
				System.out.print(rs.getString(2));
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	*/
}
