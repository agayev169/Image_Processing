import javax.imageio.ImageIO;
import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;

public class SortingByBrightness extends JPanel implements ActionListener {

    private static final int WIDTH = 320;
    private static final int HEIGHT = 240;

    private static BufferedImage img;
    private static Color[][] pixels;

    Timer t = new Timer(1, this);

    public static void main(String[] args) throws IOException {
        img = ImageIO.read(new File("/home/agayev169/IdeaProjects/3D Image/20170714_123751867_iOS4.jpg"));
        SortingByBrightness jp = new SortingByBrightness();
        jp.getPixels();
        jp.insertionSort(pixels);
        JFrame jf = new JFrame();
        jf.setLayout(new BorderLayout());
        jf.setSize(WIDTH, HEIGHT);
        jf.setTitle("3D Image");
        jf.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        jf.setVisible(true);
        jf.add(jp);
    }

    private void insertionSort(Color[][] arr) {
        for (int i = 0; i < arr.length; i++) {
            System.out.println("Checking " + i + "th row");
            for (int j = 0; j < arr[0].length; j++) {
                int br = (pixels[i][j].getRed() + pixels[i][j].getGreen() + pixels[i][j].getBlue()) / 3;
                int brPrev = 255;
                for (int k = i * arr[0].length + j; k > 1 && brPrev > br; k--) {
                    brPrev = (k % arr[0].length > 0) ? (pixels[k / arr[0].length][k % arr[0].length - 1].getRed() +
                            pixels[k / arr[0].length][k % arr[0].length - 1].getGreen() +
                            pixels[k / arr[0].length][k % arr[0].length - 1].getBlue()) / 3 :
                            pixels[k / arr[0].length - 1][arr[0].length - 1].getRed() +
                                    pixels[k / arr[0].length - 1][arr[0].length - 1].getGreen() +
                                    pixels[k / arr[0].length - 1][arr[0].length - 1].getBlue() / 3;
                    if (brPrev > br) {
                        if (k % arr[0].length > 0) {
                            Color temp = pixels[k / arr[0].length][k % arr[0].length - 1];
                            pixels[k / arr[0].length][k % arr[0].length - 1] = pixels[k / arr[0].length][k % arr[0].length];
                            pixels[k / arr[0].length][k % arr[0].length] = temp;
                        } else {
                            Color temp = pixels[k / arr[0].length - 1][arr[0].length - 1];
                            pixels[k / arr[0].length - 1][arr[0].length - 1] = pixels[k / arr[0].length][k % arr[0].length];
                            pixels[k / arr[0].length][k % arr[0].length] = temp;
                        }
                    }
                }
            }
        }
    }

    @Override
    protected void paintComponent(Graphics g) {
        for (int i = 0; i < WIDTH; i++) {
            for (int j = 0; j < HEIGHT; j++) {
                g.setColor(pixels[i][j]);
                g.drawOval(i, j, 2, 2);
            }
        }
        t.start();
    }

    private void getPixels() {
        pixels = new Color[WIDTH][HEIGHT];
        for (int i = 0; i < WIDTH; i++) {
            for (int j = 0; j < HEIGHT; j++) {
                pixels[i][j] = new Color(img.getRGB(i, j));
            }
        }
    }

    @Override
    public void actionPerformed(ActionEvent actionEvent) {
        SortingByBrightness jp = new SortingByBrightness();
        repaint();
    }
}
