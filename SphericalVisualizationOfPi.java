import javax.imageio.ImageIO;
import javax.swing.*;
import java.awt.*;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.Random;
import java.util.Scanner;

public class SphericalVisualizationOfPi extends JPanel {

    private static final int WIDTH = 10000, HEIGHT = 10000;

    private static String pi = "";
    private final int EDGES = 128;
    private final int RADIUS = 4500;


    public static void main(String[] args) throws FileNotFoundException {
        Scanner sc = new Scanner(new File("pi.txt"));
        pi = sc.nextLine();
        SphericalVisualizationOfPi jp = new SphericalVisualizationOfPi();
        JFrame jf = new JFrame();
        jf.setSize(100, 100);
        jf.setLayout(new BorderLayout());
        jf.setTitle("PI");
        jf.setVisible(true);
        jf.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        jf.add(jp);
    }

    @Override
    protected void paintComponent(Graphics g) {
        BufferedImage img = new BufferedImage(WIDTH, HEIGHT, BufferedImage.TYPE_INT_RGB);
        Graphics2D g2d = img.createGraphics();
        g2d.setColor(Color.BLACK);
        g2d.fillRect(0, 0, WIDTH, HEIGHT);
        g2d.setStroke(new BasicStroke(30f));
        for (int i = 0; i < 10; i++) {
            g2d.setColor(new Color(Color.HSBtoRGB(i / 10.0f, 1, 1)));
            for (int j = 0; j < EDGES; j++) {
                int x = (int)(WIDTH / 2 + RADIUS * Math.cos((i * EDGES + j) * 2 * Math.PI / EDGES / 10));
                int y = (int)(HEIGHT / 2 + RADIUS * Math.sin((i * EDGES + j) * 2 * Math.PI / EDGES / 10));
                int x1 = (int)(WIDTH / 2 + RADIUS * Math.cos((i * EDGES + j + 1) * 2 * Math.PI / EDGES / 10));
                int y1 = (int)(HEIGHT / 2 + RADIUS * Math.sin((i * EDGES + j + 1) * 2 * Math.PI / EDGES / 10));
                g2d.drawLine(x, y, x1, y1);
            }
        }

        g2d.setStroke(new BasicStroke(10f));
        for (int i = 0; i < 2500; i++) {
            g2d.setColor(new Color(Color.HSBtoRGB(Integer.parseInt(Character.toString(pi.charAt(i))) /
                    10.0f, 1, 1)));
            Color newC = new Color(g2d.getColor().getRed(), g2d.getColor().getGreen(),
                    g2d.getColor().getBlue(), 50);
            g2d.setColor(newC);
            Random rand = new Random();
            int prob = rand.nextInt(EDGES);
            int prob1 = rand.nextInt(EDGES);
            int x = (int)(WIDTH / 2 + (RADIUS - RADIUS / 10) * Math.cos((Integer.parseInt(Character.toString(pi.charAt(i))) *
                    EDGES + prob) * 2 * Math.PI / EDGES / 10));
            int y = (int)(HEIGHT / 2 + (RADIUS - RADIUS / 10) * Math.sin((Integer.parseInt(Character.toString(pi.charAt(i))) *
                    EDGES + prob) * 2 * Math.PI / EDGES / 10));
            int x1 = (int)(WIDTH / 2 + (RADIUS - RADIUS / 10) * Math.cos((Integer.parseInt(Character.toString(pi.charAt(i + 1))) *
                    EDGES + prob1) * 2 * Math.PI / EDGES / 10));
            int y1 = (int)(HEIGHT / 2 + (RADIUS - RADIUS / 10) * Math.sin((Integer.parseInt(Character.toString(pi.charAt(i + 1))) *
                    EDGES + prob1) * 2 * Math.PI / EDGES / 10));
            g2d.drawLine(x, y, x1, y1);
        }
        System.out.println("Done with drawing");

        g2d.dispose();

        try {
            ImageIO.write(img, "png", new File("PI_sphere9.png"));
        } catch (IOException e) {
            e.printStackTrace();
        }
        System.out.println("Done with saving");
        System.exit(0);
    }
}
