package sdu.edu.scene.db;

import java.awt.image.BufferedImage;
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Iterator;

import javax.imageio.ImageIO;

import sdu.edu.scene.dao.LogDAO;
import sdu.edu.scene.photo.PhotoAttributes;
import sdu.edu.scene.upload.File;
import sdu.edu.scene.upload.Files;

import com.drew.imaging.jpeg.JpegMetadataReader;
import com.drew.imaging.jpeg.JpegProcessingException;
import com.drew.metadata.Directory;
import com.drew.metadata.Metadata;
import com.drew.metadata.Tag;
import com.drew.metadata.exif.ExifDirectory;

public class scene {
	private Connection conn;
	private String url = "jdbc:mysql://localhost:3306/scene";
	private String user = "root";
	private String password = "ycl,,123";
//85262660
	public Connection openConnection() {
		try {
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(url, user, password);
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return conn;
	}

	public InputStream getPhoto(String photo_id, PhotoAttributes pa) {

		scene s = new scene();
		conn = s.openConnection();
		String sql;
		sql = "select picture, id, clip_left, clip_top, clip_width, clip_height, angle, saturation, brightness, contrast from photo where id="
				+ photo_id;
		ResultSet rs;
		Statement stmt;
		try {
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			if (!rs.next())
				return null;
			pa.Angle = Float.parseFloat(rs.getString("angle"));
			pa.Saturation = Float.parseFloat(rs.getString("saturation"));
			pa.Brightness = Float.parseFloat(rs.getString("brightness"));
			pa.Contrast = Float.parseFloat(rs.getString("contrast"));
			pa.ClipLeft = Integer.parseInt(rs.getString("clip_left"));
			pa.ClipTop = Integer.parseInt(rs.getString("clip_top"));
			pa.ClipWidth = Integer.parseInt(rs.getString("clip_width"));
			pa.ClipHeight = Integer.parseInt(rs.getString("clip_height"));
			return rs.getBinaryStream("picture");
		} catch (SQLException e) {
			e.printStackTrace();
			return null;
		}
	}

	public boolean insertPhoto(Files fs, String case_id, int user_id) {

		int n;
		File f;

		n = fs.getCount();
		InputStream is, is1, is_icon;
		BufferedImage bimage, bimage1;
		ByteArrayOutputStream baos;
		PreparedStatement pst;
		int icon_width, icon_height, width, height;
		int i, type, l1 = 0, l2 = 0;
		byte[] b;
		String strPara = "jhhk";
		Connection conn = openConnection();
		for (i = 0; i < n; i++) {
			f = fs.getFile(i);
			if (!f.isMissing()) {
				is = f.getInputStream();
				is1 = f.getInputStream();
				try {
					Metadata metadata = JpegMetadataReader.readMetadata(is1);
					Directory exif = metadata.getDirectory(ExifDirectory.class);
					Iterator tags = exif.getTagIterator();
					while (tags.hasNext()) {
						Tag tag = (Tag) tags.next();
						String str;
						str = tag.toString().substring(7);
						if (str.contains("Description")
								&& str.contains("          "))
							continue;
						strPara = strPara.concat(" [" + str + "]");
					}
				} catch (JpegProcessingException e) {
					e.printStackTrace();
				}

				try {
					is1 = f.getInputStream();
					bimage = ImageIO.read(is1);
					type = bimage.getColorModel().getTransparency();
					width = bimage.getWidth();
					height = bimage.getHeight();
					float r = height / width;
					r = (float) height / width;
					if (r > 0.75) {
						icon_height = 75;
						icon_width = (int) (75 / r);
					} else {
						icon_width = 100;
						icon_height = (int) (100 * r);
					}

					bimage1 = new BufferedImage(icon_width, icon_height, type);
					bimage1.getGraphics().drawImage(bimage, 0, 0, icon_width,
							icon_height, null);

					baos = new ByteArrayOutputStream();
					ImageIO.write(bimage1, "jpg", baos);
					b = baos.toByteArray();
					is_icon = new ByteArrayInputStream(b);
					l1 = is.available();
					l2 = is_icon.available();
				} catch (IOException e) {
					is_icon = null;
					baos = null;
					e.printStackTrace();
				}
				try {
					String sql = "insert into photo(picture, icon, hash, case_id, name, brightness, contrast, saturation, angle, clip_left, clip_top, clip_width, clip_height, para) values(?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
					pst = conn.prepareStatement(sql,
							PreparedStatement.RETURN_GENERATED_KEYS);
					pst.setBinaryStream(1, is, l1);
					pst.setBinaryStream(2, is_icon, l2);
					pst.setInt(3, 10000);
					pst.setString(4, case_id);
					pst.setString(5, f.getFileName());
					pst.setString(6, "1");
					pst.setString(7, "1");
					pst.setString(8, "1");
					pst.setString(9, "0");
					pst.setString(10, "0");
					pst.setString(11, "0");
					pst.setString(12, "100");
					pst.setString(13, "100");
					pst.setString(14, strPara);
					pst.execute();
					ResultSet rs = pst.getGeneratedKeys();
					int photo_id = 0;
					if (rs.next()) {
						photo_id = rs.getInt(1);
					}
					String newValue = photo_id + "," + "0" + "," + "0" + ","
							+ "100" + "," + "100" + "," + "0" + "," + "1" + ","
							+ "1" + "," + "1";
					new LogDAO().changelog("insert", 0 + "", newValue, user_id,2);
				} catch (SQLException e) {
					e.printStackTrace();
				}
				try {
					is.close();
					is_icon.close();
					baos.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			} else
				return false;
		}
		try {
			conn.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return true;
	}
}
