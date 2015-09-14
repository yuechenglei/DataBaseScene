package dao;
import com.util.DBUtil;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.io.IOException;
import java.sql.*;
public class PhotoDAO {

	Connection conn = null;
	Statement st ;
	ResultSet rs ;
	
	public void update(String oldvalue){
		conn = DBUtil.getConnection();
		String[] str = oldvalue.split(",");
		String sql = "update photo set clip_left='"+str[1]+
				"' , clip_top='"+str[2]+
				"' , clip_width='"+str[3]+
				"' , clip_height='"+str[4]+
				"' , angle='"+str[5]+
				"' , saturation='"+str[6]+
				"' , contrast='"+str[7]+
				"' , brightness='"+str[8]+"' where id='"+str[0]+"'";
		System.out.println(sql);
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
