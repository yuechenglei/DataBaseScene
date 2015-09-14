package db;

import java.awt.event.ActionEvent;

import java.awt.event.ActionListener;


import javax.swing.JButton;
import javax.swing.JRadioButton;
import javax.swing.ButtonGroup;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JOptionPane;
import javax.swing.JPanel;
import javax.swing.JTextField;
import java.io.IOException;

public class FrameTest1 extends JFrame
{
	private JFrame jf = new JFrame("数据库备份");
	private JPanel jp =new JPanel();
	private JLabel l_name = new JLabel("备份名称:");
	static JTextField t_name = new JTextField(48);
	private JLabel path_name1 = new JLabel("文件路径名:");
	private JLabel path_name2 = new JLabel("---------------------");
	private JLabel l_abbs = new JLabel("备份内容摘要:");
	private JLabel l_type = new JLabel("存储器类型:");
	static JTextField t_abbs = new JTextField(256);
	private JButton ok = new JButton("ok");
	private JButton cancel = new JButton("cancel");
	private static final long serialVersionUID = 1L;
	JRadioButton	rb1 = new JRadioButton("硬盘");   
	JRadioButton	rb2 = new JRadioButton("U盘");   
	JRadioButton	rb3 = new JRadioButton("光盘");   
	JRadioButton	rb4 = new JRadioButton("磁带");   
	ButtonGroup		group = new ButtonGroup();
	String	filename;
	
public FrameTest1(String fn)
{
   ok.addActionListener(new okListener());
   cancel.addActionListener(new cancelListener());
   path_name2.setText(fn);

   filename=fn;
   
   this.setVisible(true);
   int	width_w = 550;
   int	height_w = 400;
   int	width_b = 400;
   int	height_b = 320;
   int	start_x, start_y, end_x;
   int	label_h=30, label_w=100;
   int	text_w=300, text_h=100;
   int	delta = 20;
   int	radio_w = 60;
   
   start_x = (width_w - width_b)/2;
   end_x = start_x + width_b;
   start_y = (height_w - height_b)/2;

   l_name.setBounds(start_x, start_y, label_w, label_h);
   t_name.setBounds(start_x+label_w, start_y, text_w, label_h);
   path_name1.setBounds(start_x, start_y+label_h+delta, label_w, label_h);
   path_name2.setBounds(start_x+label_w, start_y+label_h+delta, text_w, label_h);
   l_type.setBounds(start_x, start_y+2*(label_h+delta), label_w, label_h);
   l_abbs.setBounds(start_x, start_y+3*(label_h+delta), label_w, label_h);
   t_abbs.setBounds(start_x+label_w, start_y+3*(label_h+delta), text_w, text_h);
   ok.setBounds(end_x-2*label_w, start_y+3*(label_h+delta)+text_h+delta, label_w, label_h);
   cancel.setBounds(end_x-label_w, start_y+3*(label_h+delta)+text_h+delta, label_w, label_h);

   rb1.setBounds(start_x+label_w, start_y+2*(label_h+delta), radio_w, label_h);
   rb2.setBounds(start_x+label_w+radio_w, start_y+2*(label_h+delta), radio_w, label_h);
   rb3.setBounds(start_x+label_w+2*radio_w, start_y+2*(label_h+delta), radio_w, label_h);
   rb4.setBounds(start_x+label_w+3*radio_w, start_y+2*(label_h+delta), radio_w, label_h);
   
   group.add(rb1);
   group.add(rb2);
   group.add(rb3);
   group.add(rb4);   
 
   jp.setLayout(null);
   jp.add(l_name);
   jp.add(t_name);
   jp.add(path_name1);
   jp.add(path_name2);
   jp.add(l_abbs);
   jp.add(l_type);
   jp.add(t_abbs);
   jp.add(ok);
   jp.add(cancel);

   jp.add(rb1);   
   jp.add(rb2);   
   jp.add(rb3);   
   jp.add(rb4);  
   
   jf.add(jp);

   jf.setVisible(true);
   jf.setSize(width_w,height_w);
   jf.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
   jf.setLocationRelativeTo(null);	// 居中
}
class okListener implements ActionListener{
@Override
public void actionPerformed(ActionEvent arg0) {
// TODO Auto-generated method stub
check();

String stmt="C:\\Program Files\\MySQL\\MySQL Server 5.6\\bin\\mysqldump scene --hex-blob -uroot -pycl,,123 --result-file="+filename;
System.out.println("------------------------------------------ "+stmt);
try {
	Runtime.getRuntime().exec(stmt);
}
catch (IOException e) {
	e.printStackTrace();
}
}
}

class cancelListener implements ActionListener{
@Override
public void actionPerformed(ActionEvent arg0) {
// TODO Auto-generated method stub
// System.exit(0);

}

}

public static void check()
{
	if(t_name.getText().equals("")) {
		JOptionPane.showMessageDialog(null, "请输入备份名称!","error",JOptionPane.ERROR_MESSAGE);
	}
	else {

	}
}
}
