package cn.edu.sdufe.cms.utilities.thumb;

import javax.imageio.ImageIO;
import java.awt.*;
import java.awt.image.BufferedImage;
import java.awt.image.CropImageFilter;
import java.awt.image.FilteredImageSource;
import java.awt.image.ImageFilter;
import java.io.File;

/**
 * 产生图像缩略图
 * User: pengfei.dongpf@gmail.com
 * Date: 12-4-6
 * Time: 下午7:24
 */
public class ImageThumb {
    private int width;
    private int height;
    private int scaleWidth;
    private double support = (double) 3.0;
    private double pi = (double) 3.14159265358978;
    private double[] contrib;
    private double[] normContrib;
    private double[] tmpContrib;
    //private int startContrib, stopContrib;
    private int nDots;
    private int nHalfDots;

    /**
     * @param fromFileStr
     * @param saveToFileStr
     * @param formatWidth
     * @param formatHeight
     * @throws Exception
     */
    public void saveImageAsJpg(String fromFileStr, String saveToFileStr,
                               int formatWidth, int formatHeight) throws Exception {
        BufferedImage srcImage;
        File saveFile = new File(saveToFileStr);
        File fromFile = new File(fromFileStr);
        srcImage = ImageIO.read(fromFile); // construct image
        int imageWidth = srcImage.getWidth(null);
        int imageHeight = srcImage.getHeight(null);
        int changeToWidth = 0;
        int changeToHeight = 0;
        double imageScale = (imageWidth + 0.1) / (imageHeight + 0.1);
        double formatScale = (formatWidth + 0.1) / (formatHeight + 0.1);
        if (imageWidth > 0 && imageHeight > 0) {
            // flag=true;
            if (imageScale >= formatScale) {
                changeToHeight = formatHeight;
                changeToWidth = (changeToHeight * imageWidth) / imageHeight;
            } else {
                changeToWidth = formatWidth;
                changeToHeight = (changeToWidth * imageHeight) / imageWidth;
            }
        }
        srcImage = imageZoomOut(srcImage, changeToWidth, changeToHeight);
        BufferedImage tag = cut(srcImage, formatWidth, formatHeight);
        ImageIO.write(tag, "JPEG", saveFile);
    }

    /**
     * 重新制定大小
     *
     * @param srcBufferImage
     * @param w
     * @param h
     * @return
     */
    public BufferedImage imageZoomOut(BufferedImage srcBufferImage, int w, int h) {
        width = srcBufferImage.getWidth();
        height = srcBufferImage.getHeight();
        scaleWidth = w;

        if (determineResultSize(w, h) == 1) {
            return srcBufferImage;
        } else {
            calContrib();
            BufferedImage pbOut = horizontalFiltering(srcBufferImage, w);
            pbOut = verticalFiltering(pbOut, h);
            return pbOut;
        }
    }

    /**
     * 裁剪
     *
     * @param src
     * @param width
     * @param height
     * @return
     */
    public BufferedImage cut(BufferedImage src, int width, int height) {
        ImageFilter cropFilter = new CropImageFilter(0, 0, width, height);
        Image img = Toolkit.getDefaultToolkit().createImage(new FilteredImageSource(src.getSource(), cropFilter));
        BufferedImage tag = new BufferedImage(width, height, BufferedImage.TYPE_INT_RGB);
        Graphics g = tag.getGraphics();
        g.drawImage(img, 0, 0, null); // 绘制缩小后的图
        g.dispose();
        return tag;
    }

    private int determineResultSize(int w, int h) {
        double scaleH, scaleV;
        scaleH = (double) w / (double) width;
        scaleV = (double) h / (double) height;
        if (scaleH >= 1.0 && scaleV >= 1.0) {
            return 1;
        }
        return 0;

    } // end of determineResultSize()

    private double lanczos(int i, int inWidth, int outWidth, double Support) {
        double x;

        x = (double) i * (double) outWidth / (double) inWidth;

        return Math.sin(x * pi) / (x * pi) * Math.sin(x * pi / Support)
                / (x * pi / Support);
    }

    private void calContrib() {
        nHalfDots = (int) ((double) width * support / (double) scaleWidth);
        nDots = nHalfDots * 2 + 1;
        try {
            contrib = new double[nDots];
            normContrib = new double[nDots];
            tmpContrib = new double[nDots];
        } catch (Exception e) {
            System.out.println("init   contrib,normContrib,tmpContrib" + e);
        }

        int center = nHalfDots;
        contrib[center] = 1.0;

        double weight = 0.0;
        int i = 0;
        for (i = 1; i <= center; i++) {
            contrib[center + i] = lanczos(i, width, scaleWidth, support);
            weight += contrib[center + i];
        }

        for (i = center - 1; i >= 0; i--) {
            contrib[i] = contrib[center * 2 - i];
        }

        weight = weight * 2 + 1.0;

        for (i = 0; i <= center; i++) {
            normContrib[i] = contrib[i] / weight;
        }

        for (i = center + 1; i < nDots; i++) {
            normContrib[i] = normContrib[center * 2 - i];
        }
    } // end of calContrib()

    // �����Ե
    private void calTempContrib(int start, int stop) {
        double weight = 0;

        int i = 0;
        for (i = start; i <= stop; i++) {
            weight += contrib[i];
        }

        for (i = start; i <= stop; i++) {
            tmpContrib[i] = contrib[i] / weight;
        }

    } // end of calTempContrib()

    private int getRedValue(int rgbValue) {
        int temp = rgbValue & 0x00ff0000;
        return temp >> 16;
    }

    private int getGreenValue(int rgbValue) {
        int temp = rgbValue & 0x0000ff00;
        return temp >> 8;
    }

    private int getBlueValue(int rgbValue) {
        return rgbValue & 0x000000ff;
    }

    private int comRGB(int redValue, int greenValue, int blueValue) {

        return (redValue << 16) + (greenValue << 8) + blueValue;
    }

    // ��ˮƽ�˲�
    private int horizontalFilter(BufferedImage bufImg, int startX, int stopX,
                                 int start, int stop, int y, double[] pContrib) {
        double valueRed = 0.0;
        double valueGreen = 0.0;
        double valueBlue = 0.0;
        int valueRGB = 0;
        int i, j;

        for (i = startX, j = start; i <= stopX; i++, j++) {
            valueRGB = bufImg.getRGB(i, y);

            valueRed += getRedValue(valueRGB) * pContrib[j];
            valueGreen += getGreenValue(valueRGB) * pContrib[j];
            valueBlue += getBlueValue(valueRGB) * pContrib[j];
        }

        valueRGB = comRGB(clip((int) valueRed), clip((int) valueGreen),
                clip((int) valueBlue));
        return valueRGB;

    } // end of horizontalFilter()

    // ͼƬˮƽ�˲�
    private BufferedImage horizontalFiltering(BufferedImage bufImage, int iOutW) {
        int dwInW = bufImage.getWidth();
        int dwInH = bufImage.getHeight();
        int value = 0;
        BufferedImage pbOut = new BufferedImage(iOutW, dwInH,
                BufferedImage.TYPE_INT_RGB);

        for (int x = 0; x < iOutW; x++) {

            int startX;
            int start;
            int X = (int) (((double) x) * ((double) dwInW) / ((double) iOutW) + 0.5);
            int y = 0;

            startX = X - nHalfDots;
            if (startX < 0) {
                startX = 0;
                start = nHalfDots - X;
            } else {
                start = 0;
            }

            int stop;
            int stopX = X + nHalfDots;
            if (stopX > (dwInW - 1)) {
                stopX = dwInW - 1;
                stop = nHalfDots + (dwInW - 1 - X);
            } else {
                stop = nHalfDots * 2;
            }

            if (start > 0 || stop < nDots - 1) {
                calTempContrib(start, stop);
                for (y = 0; y < dwInH; y++) {
                    value = horizontalFilter(bufImage, startX, stopX, start,
                            stop, y, tmpContrib);
                    pbOut.setRGB(x, y, value);
                }
            } else {
                for (y = 0; y < dwInH; y++) {
                    value = horizontalFilter(bufImage, startX, stopX, start,
                            stop, y, normContrib);
                    pbOut.setRGB(x, y, value);
                }
            }
        }

        return pbOut;

    } // end of horizontalFiltering()

    private int verticalFilter(BufferedImage pbInImage, int startY, int stopY,
                               int start, int stop, int x, double[] pContrib) {
        double valueRed = 0.0;
        double valueGreen = 0.0;
        double valueBlue = 0.0;
        int valueRGB = 0;
        int i, j;

        for (i = startY, j = start; i <= stopY; i++, j++) {
            valueRGB = pbInImage.getRGB(x, i);

            valueRed += getRedValue(valueRGB) * pContrib[j];
            valueGreen += getGreenValue(valueRGB) * pContrib[j];
            valueBlue += getBlueValue(valueRGB) * pContrib[j];
            // System.out.println(valueRed+"->"+clip((int)valueRed)+"<-");
            //
            // System.out.println(valueGreen+"->"+clip((int)valueGreen)+"<-");
            // System.out.println(valueBlue+"->"+clip((int)valueBlue)+"<-"+"-->");
        }

        valueRGB = comRGB(clip((int) valueRed), clip((int) valueGreen),
                clip((int) valueBlue));
        // System.out.println(valueRGB);
        return valueRGB;

    } // end of verticalFilter()

    private BufferedImage verticalFiltering(BufferedImage pbImage, int iOutH) {
        int iW = pbImage.getWidth();
        int iH = pbImage.getHeight();
        int value = 0;
        BufferedImage pbOut = new BufferedImage(iW, iOutH,
                BufferedImage.TYPE_INT_RGB);

        for (int y = 0; y < iOutH; y++) {

            int startY;
            int start;
            int Y = (int) (((double) y) * ((double) iH) / ((double) iOutH) + 0.5);

            startY = Y - nHalfDots;
            if (startY < 0) {
                startY = 0;
                start = nHalfDots - Y;
            } else {
                start = 0;
            }

            int stop;
            int stopY = Y + nHalfDots;
            if (stopY > (int) (iH - 1)) {
                stopY = iH - 1;
                stop = nHalfDots + (iH - 1 - Y);
            } else {
                stop = nHalfDots * 2;
            }

            if (start > 0 || stop < nDots - 1) {
                calTempContrib(start, stop);
                for (int x = 0; x < iW; x++) {
                    value = verticalFilter(pbImage, startY, stopY, start, stop,
                            x, tmpContrib);
                    pbOut.setRGB(x, y, value);
                }
            } else {
                for (int x = 0; x < iW; x++) {
                    value = verticalFilter(pbImage, startY, stopY, start, stop,
                            x, normContrib);
                    pbOut.setRGB(x, y, value);
                }
            }
        }
        return pbOut;

    } // end of verticalFiltering()

    private int clip(int x) {
        if (x < 0)
            return 0;
        if (x > 255)
            return 255;
        return x;
    }
}