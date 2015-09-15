package sdu.edu.scene.photo;

//import com.sun.org.apache.commons.collections.BinaryHeap;

public class Picture {
	private int id;
	private int case_id;
	private byte[] bt;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public byte[] getBt() {
		return bt;
	}
	public void setBt(byte[] bt) {
		this.bt = bt;
	}
	public int getCase_id() {
		return case_id;
	}
	public void setCase_id(int case_id) {
		this.case_id = case_id;
	}

}
