package sdu.edu.scene.photo;

import java.awt.Color;
import java.awt.Graphics;
import java.awt.Image;
import java.awt.Rectangle;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;

import javax.imageio.ImageIO;

public class ImageHepler {
	/**
	 * 绘制缩放图
	 * 
	 * @param img
	 *            原图
	 * @param width
	 *            目标图宽
	 * @param height
	 *            目标图高
	 * @return
	 */
	private static BufferedImage makeThumbnail(Image img, int width, int height) {
		BufferedImage tag = new BufferedImage(width, height,
				BufferedImage.TYPE_INT_RGB);
		Graphics g = tag.getGraphics();
		g.drawImage(img.getScaledInstance(width, height, Image.SCALE_SMOOTH),
				0, 0, null);
		g.dispose();
		return tag;
	}

	/**
	 * 裁剪图片
	 * 
	 * @param image
	 *            原图
	 * @param subImageBounds
	 *            裁剪矩形框
	 * @param subImageFile
	 *            保存路径
	 * @throws IOException
	 */
	private static void saveSubImage(BufferedImage image,
			Rectangle subImageBounds, File subImageFile) throws IOException {
		String fileName = subImageFile.getName();
		String formatName = fileName.substring(fileName.lastIndexOf('.') + 1);
		BufferedImage subImage = new BufferedImage(subImageBounds.width,
				subImageBounds.height, BufferedImage.TYPE_INT_RGB);
		Graphics g = subImage.getGraphics();
		if (subImageBounds.width > image.getWidth()
				|| subImageBounds.height > image.getHeight()) {
			int left = subImageBounds.x;
			int top = subImageBounds.y;
			if (image.getWidth() < subImageBounds.width)
				left = (int) ((subImageBounds.width - image.getWidth()) / 2);
			if (image.getHeight() < subImageBounds.height)
				top = (int) ((subImageBounds.height - image.getHeight()) / 2);
			g.setColor(Color.white);
			g.fillRect(0, 0, subImageBounds.width, subImageBounds.height);
			g.drawImage(image, left, top, null);
			ImageIO.write(image, formatName, subImageFile);
			System.out.println("if is running left:" + left + " top: " + top);
		} else {
			// BufferedImage subImage =
			// image.getSubimage(subImageBounds.x,subImageBounds.y,
			// subImageBounds.width, subImageBounds.height);
			g.drawImage(image.getSubimage(subImageBounds.x, subImageBounds.y,
					subImageBounds.width, subImageBounds.height), 0, 0, null);
			System.out.println("else is running");
		}
		g.dispose();
		ImageIO.write(subImage, formatName, subImageFile);
	}

	/**
	 * 图片缩放裁剪
	 * 
	 * @param srcImageFile
	 *            原图保存路径
	 * @param descDir
	 *            目标图保存路径
	 * @param width
	 *            缩放后图片宽度
	 * @param height
	 *            缩放后图片高度
	 * @param rect
	 *            裁剪矩形框
	 * @throws IOException
	 */
	public static void cut(String srcImageFile, String descDir, int width,
			int height, Rectangle rect) throws IOException {
		Image image = javax.imageio.ImageIO.read(new File(srcImageFile));
		BufferedImage bImage = makeThumbnail(image, width, height);

		saveSubImage(bImage, rect, new File(descDir));
	}

	public static void cut(File srcImageFile, File descDir, int width,
			int height, Rectangle rect) throws IOException {
		Image image = javax.imageio.ImageIO.read(srcImageFile);
		BufferedImage bImage = makeThumbnail(image, width, height);

		saveSubImage(bImage, rect, descDir);
	}
}
