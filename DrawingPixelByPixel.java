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
        private float x, y;
        private float angle;
        private float radius;

        Circle(int x, int y) {
            this.x = x;
            this.y = y;
            Random rand = new Random();
            angle = (float) (rand.nextFloat() * Math.PI * 2);
            radius = 10 + rand.nextFloat() * 5;
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
    private Timer t = new Timer(1, this);

    public static void main(String[] args) throws IOException {
        img = ImageIO.read(new File("/home/agayev169/IdeaProjects/3D Image/20170714_123751867_iOS2.jpg"));
        DrawingPixelByPixel.initCircles();
        JFrame jf = new JFrame();
        DrawingPixelByPixel jp = new DrawingPixelByPixel();
        jf.setLayout(new BorderLayout());
        jf.setSize(WIDTH, HEIGHT);
        jf.setTitle("3D Image");
        jf.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        jf.setVisible(true);
        jf.add(jp);
    }

    @Override
    protected void paintComponent(Graphics g) {
        for (Circle aC : c) {
            Color temp = new Color(img.getRGB((int) aC.x, (int) aC.y));
            int r = temp.getRed();
            int gr = temp.getGreen();
            int b = temp.getBlue();
            int op = 50;
            g.setColor(new Color(r, gr, b, op));
            g.fillOval((int) aC.x, (int) aC.y, (int) aC.radius, (int) aC.radius);
        }
        t.start();
    }

    @Override
    public void actionPerformed(ActionEvent actionEvent) {
        for (Circle aC : c) {
            Random rand = new Random();
            int prob = rand.nextInt(1000);
            aC.angle = (float) (rand.nextFloat() * Math.PI * 2);
            if (prob == 0) {
                aC.x += (25 + rand.nextInt(50)) * Math.cos(aC.angle);
                aC.y += (25 + rand.nextInt(50)) * Math.sin(aC.angle);
            } else {
                aC.x += 2 * Math.cos(aC.angle);
                aC.y += 2 * Math.sin(aC.angle);
            }
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
