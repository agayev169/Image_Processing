import javax.imageio.ImageIO;
import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;

public class Image3DAnimation extends JPanel implements ActionListener {

    private static final int WIDTH = 640;
    private static final int HEIGHT = 480;

    private int xPos;

    private static BufferedImage img;
    private Color[][] pixels;
    Timer t = new Timer(1, this);
    public static void main(String[] args) throws IOException {
        img = ImageIO.read(new File("/home/agayev169/IdeaProjects/3D Image/20170714_123751867_iOS2.jpg"));
        Image3DAnimation jp = new Image3DAnimation();
        jp.getPixels();
        JFrame jf = new JFrame();
        jf.setLayout(new BorderLayout());
        jf.setSize(800, 600);
        jf.setTitle("3D Image");
        jf.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        jf.setVisible(true);
        jf.add(jp);
    }

    @Override
    protected void paintComponent(Graphics g) {
        g.setColor(Color.WHITE);
        g.fillRect(0, 0, 800, 600);
        for (int i = 0; i < WIDTH; i++) {
            for (int j = 0; j < HEIGHT; j++) {
                g.setColor(pixels[i][j]);
                int br = (pixels[i][j].getRed() + pixels[i][j].getGreen() + pixels[i][j].getBlue()) / 3;
                int brx = i < WIDTH / 2 ? -br : br;
                int bry = j < HEIGHT / 2 ? -br : br;
                g.fillRect(i  + (brx * 16 / 25) * xPos / 800 + 80,
                        j + (bry * 12 / 25) * xPos / 800 + 60, 1, 1);
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
        int prevX = xPos;
        xPos = MouseInfo.getPointerInfo().getLocation().x;
        xPos = (xPos < 0) ? 0 : (xPos > 800 ? 800 : xPos);
        if (prevX != xPos)
            repaint();
    }
}
