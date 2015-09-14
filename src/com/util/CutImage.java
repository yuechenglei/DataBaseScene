package com.util;

import java.awt.Rectangle;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.util.Iterator;

import javax.imageio.ImageIO;
import javax.imageio.ImageReadParam;
import javax.imageio.ImageReader;
import javax.imageio.stream.ImageInputStream;
//ͼƬ�ü�
public class CutImage {
	//===ԴͼƬ·��������:c:\1.jpg     
    private  String srcpath ;   
    // ===����ͼƬ���·������.��:c:\2.jpg    
    private  String subpath ;   
    // ===���е�x����    
    private   int  x ;   
    private   int  y ;       
    // ===���е���    
    private   int  width ;   
    private   int  height ;   
    public  CutImage()  {   
   }      
    public  CutImage( int  x, int  y, int  width, int  height)  {   
         this .x  =  x ;   
         this .y  =  y ;   
         this .width  =  width ;      
         this .height  =  height ;   
   }    
      
 /**    
    * ��ͼƬ�ü������Ѳü��군��ͼƬ���� ��  
  */    
    public   void  cut()  throws  IOException {    
           
       FileInputStream is  =   null  ;   
       ImageInputStream iis  = null  ;   
       
        try {      
           is  =   new  FileInputStream(srcpath);    
              
           /*   
            * ���ذ������е�ǰ��ע�� ImageReader �� Iterator����Щ ImageReader   
            * �����ܹ�����ָ����ʽ�� ������formatName - ��������ʽ��ʽ���� .  
            *������ "jpeg" �� "tiff"���� ��   
        */    
           Iterator < ImageReader >  it  =  ImageIO.getImageReadersByFormatName( "jpg" );     
           ImageReader reader  =  it.next();
           iis  =  ImageIO.createImageInputStream(is);
           reader.setInput(iis, true ) ;   
           ImageReadParam param  =  reader.getDefaultReadParam();    
           Rectangle rect  =   new  Rectangle(x, y, width, height);    
           param.setSourceRegion(rect);    

           /*   
            * ʹ�����ṩ�� ImageReadParam ��ȡͨ������ imageIndex ָ���Ķ��󣬲���  
            * ����Ϊһ�������� BufferedImage ���ء�  
              */    
            BufferedImage bi  =  reader.read( 0 ,param);                   
         
             // ������ͼƬ     
            ImageIO.write(bi,  "jpg" ,  new  File(subpath));        
        }  finally {   
             if (is != null )   
               is.close() ;          
             if (iis != null )   
               iis.close();     
        }     
    }    
 
     public   int  getHeight()  {   
         return  height;   
    }    
 
     public   void  setHeight( int  height)  {   
         this .height  =  height;   
    }    
     public  String getSrcpath()  {   
         return  srcpath;   
    }    
 
     public   void  setSrcpath(String srcpath)  {   
         this .srcpath  =  srcpath;   
    }    
     public  String getSubpath()  {   
         return  subpath;   
    }    
     public   void  setSubpath(String subpath)  {   
         this .subpath  =  subpath;   
    }    
     public   int  getWidth()  {   
         return  width;   
    }    
     public   void  setWidth( int  width)  {   
         this .width  =  width;   
    }    
     public   int  getX()  {   
         return  x;   
    }    
     public   void  setX( int  x)   {   
         this .x  =  x;   
    }    
     public   int  getY()   {   
         return  y;   
    }    
     public   void  setY( int  y)  {   
         this .y  =  y;   
    }     
     public   static   void  main(String[] args) throws  Exception  {   
           
        String name  =   "d:/2005121210161588950.jpg" ;    
           
        CutImage o  =   new  CutImage( 100 , 100 , 100 , 100 );   
        o.setSrcpath(name);     
        o.setSubpath( "D:/2.jpg" );   
        o.cut() ;     
             
    }    

}
