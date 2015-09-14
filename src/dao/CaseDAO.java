package dao;
import com.util.DBUtil;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.io.IOException;
import java.sql.*;
public class CaseDAO {
	Connection conn = null;
	Statement st;
	ResultSet rs;
	
	public void update(String oldvalue){
		conn = DBUtil.getConnection();
		String[] str = oldvalue.split(";");
		String sql = "update `case` set `name`='"+str[1]+
				"' , `inspector`='"+str[2]+
				"' , `xkh`='"+str[3]+
				"' , `date_anfa`='"+str[4]+
				"' , `place`='"+str[5]+
				"' , `desc`='"+str[6]+"' where `id`='"+str[0]+"'";
		try {
			st = conn.createStatement();
			st.executeUpdate(sql);
			return;
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	public void delete(String newvalue){
		conn = DBUtil.getConnection();
		String[] str = newvalue.split(";");
		String sql = "delete from case where id='"+str[0]+"'";
		try {
			st = conn.createStatement();
			st.executeUpdate(sql);
			return;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	public void insert(String oldvalue){
		conn = DBUtil.getConnection();
		String[] str = oldvalue.split(";");
		String sql = "insert into `case`(`name`,`inspector`,`xkh`,`date_anfa`,`place`,`desc`) "
				+ "values('"+str[1]+"','"+str[2]+"','"+str[3]+"','"+str[4]+"','"+str[5]+"','"+str[6]+"')";
		try {
			st = conn.createStatement();
			st.executeUpdate(sql);
			return;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}
