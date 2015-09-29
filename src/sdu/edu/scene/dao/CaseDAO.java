package sdu.edu.scene.dao;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Iterator;
import java.util.List;
import java.util.ListIterator;

import net.sf.json.JSONArray;
import sdu.edu.scene.dto.ListBean;
import sdu.edu.scene.util.DBUtil;

/**
 * 对案件的数据库的操作DAO层
 * 
 * @author Halo
 *
 */
public class CaseDAO {
	Connection conn = null;
	Statement st;
	ResultSet rs;

	public void update(String oldvalue) {
		conn = DBUtil.getConnection();
		String[] str = oldvalue.split(";");
		String sql = "update `case` set `name`='" + str[1]
				+ "' , `inspector`='" + str[2] + "' , `xkh`='" + str[3]
				+ "' , `date_anfa`='" + str[4] + "' , `place`='" + str[5]
				+ "' , `desc`='" + str[6] + "' where `id`='" + str[0] + "'";
		try {
			st = conn.createStatement();
			st.executeUpdate(sql);
			return;

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	public void delete(String newvalue) {
		conn = DBUtil.getConnection();
		String[] str = newvalue.split(";");
		String sql = "delete from case where id='" + str[0] + "'";
		try {
			st = conn.createStatement();
			st.executeUpdate(sql);
			return;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	public boolean insert(String oldvalue) {
		conn = DBUtil.getConnection();
		String[] str = oldvalue.split(";");
		String sql = "insert into `case`(`name`,`inspector`,`xkh`,`date_anfa`,`place`,`description`,`date`) "
				+ "values('"
				+ str[0]
				+ "','"
				+ str[1]
				+ "','"
				+ str[2]
				+ "','"
				+ str[3]
				+ "','"
				+ str[4]
				+ "','"
				+ str[5]
				+ "','"
				+ str[6]
				+ "')";
		try {
			st = conn.createStatement();
			st.executeUpdate(sql);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {

			try {
				conn.close();
				st.close();
				return true;
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return false;
	}

	public String getCase(String xkh) {
		conn = DBUtil.getConnection();
		String sql = "select id,name,description from scene.case where xkh='"
				+ xkh + "'";
		// String sql = "select desc from scene.case where id=18";
		try {
			st = conn.createStatement();
			System.out.println(sql);
			ResultSet rs = st.executeQuery(sql);
			List<ListBean> list = new ArrayList<ListBean>();
			while (rs.next()) {
				ListBean bean = new ListBean(rs.getInt("id"),
						rs.getString("name"), rs.getString("description"));
				list.add(bean);
			}
			JSONArray array = JSONArray.fromObject(list);
			return array.toString();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "";
	}
}
