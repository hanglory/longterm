package com.harmony.longterm.utils;

import java.awt.Graphics;
import java.awt.Image;
import java.awt.image.BufferedImage;
import java.io.File;

import javax.imageio.ImageIO;

public class ImageUtil {
	
	// 업로드 이미지 리사이즈
	public static void resizeUploadImg(String filePath){
		// 리사이즈 기준 width 890px
		int newWidth = 890;
		
		// 확장자
		int pos = filePath.lastIndexOf(".");
		String ext = filePath.substring(pos+1);
					
		try {
			// 원본 이미지 사이즈 가져오기
			Image i = ImageIO.read(new File(filePath));
            int originWidth = i.getWidth(null);
            int originHeight = i.getHeight(null);
            
            // width 890 비율로 height 구하기
			double ratio = (double) newWidth / (double) originWidth;
			int w = (int) (originWidth * ratio);
			int h = (int) (originHeight * ratio);
						
			// 리사이즈 된 이미지로 교체
			if(originWidth > newWidth){
	            // Image.SCALE_DEFAULT : 기본 이미지 스케일링 알고리즘 사용
	            // Image.SCALE_FAST    : 이미지 부드러움보다 속도 우선
	            // Image.SCALE_REPLICATE : ReplicateScaleFilter 클래스로 구체화 된 이미지 크기 조절 알고리즘
	            // Image.SCALE_SMOOTH  : 속도보다 이미지 부드러움을 우선
	            // Image.SCALE_AREA_AVERAGING  : 평균 알고리즘 사용				
	            Image resizeImage = i.getScaledInstance(w, h, Image.SCALE_AREA_AVERAGING);
	            BufferedImage newImage = new BufferedImage(w, h, BufferedImage.TYPE_INT_RGB);
	            Graphics g = newImage.getGraphics();
	            g.drawImage(resizeImage, 0, 0, null);
	            g.dispose();
	            ImageIO.write(newImage, ext, new File(filePath));				
			}
		} catch (Exception e) {
			System.out.println("resizeUploadImg() error");
		}		
	}
	
}
