package dao;

import java.util.Map;

//����ʹ��  ò����������linuxϵͳ
public class FindMySQL {
	public static String getMysqlPath(){
		Map m=System.getenv();
		String s2=(String) m.get("Path");//��ȡ�����������������PATH������
		String s1=s2.substring(0, s2.indexOf("MySQL"));//��ȡ�����ӡ�0������MySQL���ַ���
		String s3=s2.substring(s1.lastIndexOf(":")-1, s2.length());//��ȡS1�ַ��������һ����������������Ȼ���ȡ��":"-1 �������������ַ���
		String mySqlPath=s3.substring(0,s3.indexOf("bin")+3);//��ȡ�ַ���S3 ��������0�� ����bin�����ַ�������ȡ������mysql��װ·��
		return mySqlPath;
	}
	
	public static void main(String[] args){
		String str = getMysqlPath();
		System.out.println(str);
	}
}

