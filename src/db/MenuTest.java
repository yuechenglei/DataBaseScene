package db;
import java.awt.BorderLayout;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import javax.swing.JFrame;
import javax.swing.JMenu;
import javax.swing.JMenuBar;
import javax.swing.JMenuItem;
import javax.swing.JOptionPane;

public class MenuTest { /**  * @param args  */ 
	JFrame frame; 
	JMenuBar mb;
	JMenu m;
	JMenuItem mi1;
	JMenuItem mi2;
	public MenuTest()
	{
		initFrame();
		initAction();
	}
	public void initFrame()
	{
		frame = new JFrame();
		mb = new JMenuBar();
		m = new JMenu("ѧ����ѯ");
		mi1 = new JMenuItem("ȷ��");
		mi2 = new JMenuItem("ȡ��");
		m.add(mi1);
		m.add(mi2);
		mb.add(m);
		frame.add(mb, BorderLayout.NORTH);
		frame.setSize(300, 300);
		frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		frame.setVisible(true);
	}
	public void initAction()
	{
		mi1.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) { // TODO Auto-generated method stub
				System.out.println("click");
				JOptionPane.showMessageDialog(null, "������ȷ����ť");	}});
		mi2.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {    // TODO Auto-generated method stub
				JOptionPane.showMessageDialog(null, "������ȡ����ť");   }  }); }
	public static void main(String[] args) {  // TODO Auto-generated method stub  new MenuTest(); }}}
	}
}
