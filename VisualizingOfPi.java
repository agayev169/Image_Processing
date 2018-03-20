import javax.imageio.ImageIO;
import java.awt.*;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.Scanner;

public class VisualizingOfPi {

    static final int W = 10, H = 10;

    static String pi = "";
    static BufferedImage img = new BufferedImage(10000, 10000, BufferedImage.TYPE_INT_RGB);

    public static void main(String[] args) throws FileNotFoundException {
        Scanner sc = new Scanner(new File("pi.txt"));
        pi = sc.nextLine();
        for (int i = 0; i < img.getWidth() / W; i++) {
            for (int j = 0; j < img.getHeight() / H; j++) {
                if (i * img.getHeight() / H + j >= pi.length()) break;
                Color col = Color.getHSBColor(Float.parseFloat(Character.toString(
                        pi.charAt(i * img.getHeight() / H + j))) / 10.0f, 1, 1);
                int[] arrC = new int[W * H];
                for (int k = 0; k < W * H; k++) {
                    arrC[k] = col.getRGB();
                }
                img.setRGB(j * W, i * H, W, H, arrC, 0, 0);
            }
        }
        try {
            ImageIO.write(img, "png", new File("Pi_digits-1_million.png"));
        } catch (IOException e) {
            e.printStackTrace();
        }
        System.out.println("Done!");
    }
}
