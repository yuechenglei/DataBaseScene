package photo;

import java.io.IOException;
import java.io.InputStream;
import java.io.BufferedInputStream;
import java.awt.image.*;
import java.awt.Color;
import javax.imageio.*;

import photo.PhotoAttributes;

public class FilterPhoto {
	public BufferedImage getFilteredImage(InputStream is, PhotoAttributes pa) {
		BufferedInputStream bis = new BufferedInputStream(is); //Éú³É»º´æÊäÈëÁ÷  
		BufferedImage bimage;
		int	width, height, type;
		try {
			bimage = ImageIO.read(bis);
			width = bimage.getWidth();
			height = bimage.getHeight();
			type = bimage.getColorModel().getTransparency();  
		} catch (IOException e) {
			return null;
		}
		int	max = (int)Math.sqrt(width*width+height*height);

		int[] pixels = new int[(max+1)*(max+1)];  
		bimage.getRGB(0, 0, width, height, pixels, 0, width);

		if (pa.Angle >= 2 || pa.Angle <= -2) {
			// find the box of new picture, create the destination image frame
			double[]	x = new double[4], rx = new double[4];
			double[]	y = new double[4], ry = new double[4];	
			x[0] = -width/2;	y[0] = height/2; 
			x[1] = -width/2;	y[1] = -height/2; 
			x[2] = width/2;		y[2] = -height/2; 
			x[3] = width/2;		y[3] = height/2; 
			double	cos = Math.cos(Math.toRadians(pa.Angle));
			double	sin = Math.sin(Math.toRadians(pa.Angle));
			for (int i=0; i<4; i++) {
				rx[i] = x[i]*cos + y[i]*sin;
				ry[i] = -x[i]*sin + y[i]*cos;
			}
			int	max_w = (int)Math.max(Math.abs(rx[0]-rx[2]), Math.abs(rx[1]-rx[3]));
			int	max_h = (int)Math.max(Math.abs(ry[0]-ry[2]), Math.abs(ry[1]-ry[3]));
			// rotate
			int[] inPixels = new int[width*height];
	        bimage.getRGB(0, 0, width, height, inPixels, 0, width);
			cos = Math.cos(Math.toRadians(-pa.Angle));
			sin = Math.sin(Math.toRadians(-pa.Angle));
			int	i, j, ri, rj;
			for (j=0; j<max_h; j++)
				for (i=0; i<max_w; i++) {
					ri = (int)Math.round(max_w/2 + (i-max_w/2)*cos + (j-max_h/2)*sin);
					rj = (int)Math.round(max_h/2 - (i-max_w/2)*sin + (j-max_h/2)*cos);
					if (ri>(max_w-width)/2 && ri<width+(max_w-width)/2 && rj>(max_h-height)/2 && rj<height+(max_h-height)/2) {
						int s = ri-(max_w-width)/2;
						int t = rj-(max_h-height)/2;
						if (s<0 || s>=width || t<0 || t>=height)
							pixels[j*max_w+i] = 0;
						else
							pixels[j*max_w+i] = inPixels[t*width+s];
					}
					else
						pixels[j*max_w+i] = 0;
				}
			width = max_w;
			height = max_h;
		}

		// Í¼Æ¬²Ã¼ô
		if (pa.ClipWidth > 3 && pa.ClipHeight > 3) {
			int s = (int)(width*pa.ClipLeft*0.01);
			int t = (int)(height*pa.ClipTop*0.01);
			int w = (int)(pa.ClipWidth*width*0.01);
			int h = (int)(pa.ClipHeight*height*0.01);
			for (int j=0; j<h; j++)
				for (int i=0; i<w; i++)
					pixels[j*w+i] = pixels[(t+j)*width+s+i];
			width = w;
			height = h;
		}

		if (pa.Brightness!=1 || pa.Contrast!=0) {
	        // calculate RED, GREEN, BLUE means of pixel  
	        int index = 0;  
	        int[] rgbmeans = new int[3];  
	        double redSum = 0, greenSum = 0, blueSum = 0;  
	        double total = height * width;  
	        for(int row=0; row<height; row++) {  
	            int tr = 0, tg = 0, tb = 0;  
	            for(int col=0; col<width; col++) {  
	                index = row * width + col;  
	                tr = (pixels[index] >> 16) & 0xff;  
	                tg = (pixels[index] >> 8) & 0xff;  
	                tb = pixels[index] & 0xff;  
	                redSum += tr;  
	                greenSum += tg;  
	                blueSum +=tb;  
	            }  
	        }  
	          
	        rgbmeans[0] = (int)(redSum / total);  
	        rgbmeans[1] = (int)(greenSum / total);  
	        rgbmeans[2] = (int)(blueSum / total);  
	          
	        // adjust contrast and brightness algorithm, here  
	        for(int row=0; row<height; row++) {  
	            int tr = 0, tg = 0, tb = 0;  
	            for(int col=0; col<width; col++) {  
	                index = row * width + col;  
	                tr = (pixels[index] >> 16) & 0xff;  
	                tg = (pixels[index] >> 8) & 0xff;  
	                tb = pixels[index] & 0xff;  
	                  
	                // remove means  
	                tr -=rgbmeans[0];  
	                tg -=rgbmeans[1];  
	                tb -=rgbmeans[2];  
	                  
	                // adjust contrast now !!!  
	                tr = (int)(tr * pa.Contrast);  
	                tg = (int)(tg * pa.Contrast);  
	                tb = (int)(tb * pa.Contrast);  
	                  
	                // adjust brightness  
	                tr += (int)(rgbmeans[0] * pa.Brightness);  
	                tg += (int)(rgbmeans[1] * pa.Brightness);  
	                tb += (int)(rgbmeans[2] * pa.Brightness);
	                
	                tr = (tr<0)? 0:((tr>255)? 255:tr);  
	                tg = (tg<0)? 0:((tg>255)? 255:tg);  
	                tb = (tb<0)? 0:((tb>255)? 255:tb);  
	                pixels[index] = (tr << 16) | (tg << 8) | tb;  
	            }  
	        }  
		}

		if (pa.Saturation != 1) {
			int r , b , g;
			float	l;
			for (int x = 0; x < width*height ; x++ ){
				Color rgb = new Color(pixels[x]);
				r = rgb.getRed();
				g = rgb.getGreen();
				b = rgb.getBlue();
				l = .3f*r + .59f*b + .11f*g;
				r = (int) ((r*pa.Saturation)+(l*(1-pa.Saturation)));
				if (r > 255)
					r = 255;
				if (r < 0)
					r = 0;
				g = (int) ((g*pa.Saturation)+(l*(1-pa.Saturation)));
				if (g > 255)
					g = 255;
				if (g < 0)
					g = 0;
				b = (int) ((b*pa.Saturation)+(l*(1-pa.Saturation)));
				if (b > 255)
					b = 255;
				if (b < 0)
					b = 0;
				pixels[x] = new Color(r, g, b).getRGB();
			}
	  	}

		bimage = new BufferedImage(width, height, type);
		bimage.setRGB(0, 0, width, height, pixels, 0, width);
		return bimage;
	}

}
