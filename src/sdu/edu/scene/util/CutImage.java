package sdu.edu.scene.util;

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
//图片裁剪
public class CutImage {
	//===源图片路径名称如:c:\1.jpg     
    private  String srcpath ;   
    // ===剪切图片存放路径名称.如:c:\2.jpg    
    private  String subpath ;   
    // ===剪切点x坐标    
    private   int  x ;   
    private   int  y ;       
    // ===剪切点宽度    
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
    * 对图片裁剪，并把裁剪完蛋新图片保存 。  
  */    
    public   void  cut()  throws  IOException {    
           
       FileInputStream is  =   null  ;   
       ImageInputStream iis  = null  ;   
       
        try {      
           is  =   new  FileInputStream(srcpath);    
              
           /*   
            * 返回包含所有当前已注册 ImageReader 的 Iterator，这些 ImageReader   
            * 声称能够解码指定格式。 参数：formatName - 包含非正式格式名称 .  
            *（例如 "jpeg" 或 "tiff"）等 。   
        */    
           Iterator < ImageReader >  it  =  ImageIO.getImageReadersByFormatName( "jpg" );     
           ImageReader reader  =  it.next();
           iis  =  ImageIO.createImageInputStream(is);
           reader.setInput(iis, true ) ;   
           ImageReadParam param  =  reader.getDefaultReadParam();    
           Rectangle rect  =   new  Rectangle(x, y, width, height);    
           param.setSourceRegion(rect);    

           /*   
            * 使用所提供的 ImageReadParam 读取通过索引 imageIndex 指定的对象，并将  
            * 它作为一个完整的 BufferedImage 返回。  
              */    
            BufferedImage bi  =  reader.read( 0 ,param);                   
         
             // 保存新图片     
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
