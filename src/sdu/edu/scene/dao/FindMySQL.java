package sdu.edu.scene.dao;

import java.util.Map;

//不能使用  貌似是适用于linux系统
public class FindMySQL {
	public static String getMysqlPath(){
		Map m=System.getenv();
		String s2=(String) m.get("Path");//获取本计算机环境变量中PATH的内容
		String s1=s2.substring(0, s2.indexOf("MySQL"));//截取索引从‘0’到”MySQL“字符串
		String s3=s2.substring(s1.lastIndexOf(":")-1, s2.length());//获取S1字符串中最后一个”：“的索引，然后截取从":"-1 索引处到最后的字符串
		String mySqlPath=s3.substring(0,s3.indexOf("bin")+3);//截取字符串S3 从索引”0“ 到”bin“的字符串。获取完整的mysql安装路径
		return mySqlPath;
	}
	
	public static void main(String[] args){
		String str = getMysqlPath();
		System.out.println(str);
	}
}

