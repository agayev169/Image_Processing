import javax.imageio.ImageIO;
import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.util.Random;

public class DrawingPixelByPixel extends JPanel implements ActionListener {
    private static final int WIDTH = 640;
    private static final int HEIGHT = 480;

    private static class Circle {
        private int x, y;
        private float angle;

        Circle(int x, int y) {
            this.x = x;
            this.y = y;
            Random rand = new Random();
            angle = (float) (rand.nextFloat() * Math.PI * 2);
        }

        public int getX() {
            return x;
        }

        public void setX(int x) {
            this.x = x;
        }

        public int getY() {
            return y;
        }

        public void setY(int y) {
            this.y = y;
        }

        public float getAngle() {
            return angle;
        }

        public void setAngle(float angle) {
            this.angle = angle;
        }
    }

    private static Circle[] c = new Circle[500];

    private static void initCircles() {
        Random rand = new Random();
        for (int i = 0; i < c.length; i++) {
            c[i] = new Circle(rand.nextInt(WIDTH), rand.nextInt(HEIGHT));
        }
    }

    private static BufferedImage img;
    Timer t = new Timer(1, this);

    public static void main(String[] args) throws IOException {
        img = ImageIO.read(new File("/home/agayev169/IdeaProjects/3D Image/20170714_123751867_iOS2.jpg"));
        DrawingPixelByPixel.initCircles();
        JFrame jf = new JFrame();
        DrawingPixelByPixel jp = new DrawingPixelByPixel();
        jf.setLayout(new BorderLayout());
        jf.setSize(WIDTH, HEIGHT);
        jf.setTitle("Drawing With Particles");
        jf.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        jf.setVisible(true);
        jf.add(jp);
    }

    @Override
    protected void paintComponent(Graphics g) {
        for (int i = 0; i < c.length; i++) {
            Color temp = new Color(img.getRGB(c[i].x, c[i].y));
            int r = temp.getRed();
            int gr = temp.getGreen();
            int b = temp.getBlue();
            int op = 50;
            g.setColor(new Color(r, gr, b, op));
            g.fillOval(c[i].x, c[i].y, 15, 15);
        }
        t.start();
    }

    @Override
    public void actionPerformed(ActionEvent actionEvent) {
        Random rand = new Random();
        for (Circle aC : c) {
            aC.x += Math.cos(aC.angle) * 2;
            aC.y += Math.sin(aC.angle) * 2;
            if (!(aC.x > 25 && aC.x < WIDTH - 25 &&
                    aC.y > 25 && aC.y < HEIGHT - 25)) {
                if (aC.x < 25) aC.x = WIDTH - 26;
                if (aC.x > WIDTH - 25) aC.x = 25;
                if (aC.y < 25) aC.y = HEIGHT - 26;
                if (aC.y > HEIGHT - 25) aC.y = 25;
            }
        }
        repaint();
    }
}
