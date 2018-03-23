import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.geom.Line2D;
import java.util.Random;

public class RandomWalker extends JPanel implements ActionListener {

    private final static int WIDTH = 640, HEIGHT = 480;

    static class Walker {
        Walker prev;
        float x, y, r;
        Color c;
        float angle;

        Walker() {}

        Walker(float x, float y, float r, float angle, Color c) {
            this.x = x;
            this.y = y;
            this.r = r;
            this.angle = angle;
            this.c = c;
        }

        Walker(float x, float y, float r, Color c) {
            this.x = x;
            this.y = y;
            this.r = r;
            this.c = c;
            this.angle = 0;
            prev = new Walker();
            prev.x = x;
            prev.y = y;
            prev.r = r;
            prev.c = c;
            prev.angle = 0;
        }

        @Override
        protected Object clone() throws CloneNotSupportedException {
            return new Walker(x, y, r, angle, c);
        }
    }

    static Walker[] ws = new Walker[100];
    private Timer tm = new Timer(1, this);

    public static void main(String[] args) {
        Random rand = new Random();
        for (int i = 0; i < ws.length; i++) {
            ws[i] = new Walker(rand.nextFloat() * WIDTH, rand.nextFloat() * HEIGHT,
                    5 + rand.nextFloat() * 5, new Color(Color.HSBtoRGB(rand.nextFloat(),
                    rand.nextFloat() / 4 + 0.75f, rand.nextFloat() / 4 + 0.75f)));
        }

        RandomWalker jp = new RandomWalker();
        JFrame jf = new JFrame("Random Walker");
        jf.setSize(WIDTH, HEIGHT);
        jf.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        jf.setVisible(true);
        jf.add(jp);
    }

    @Override
    protected void paintComponent(Graphics g) {
//        g.setColor(Color.WHITE);
//        g.fillRect(0, 0, WIDTH, HEIGHT);
        Graphics2D g2 = (Graphics2D) g;
        for (Walker w : ws) {
            g2.setStroke(new BasicStroke((int) w.r));
            g.setColor(w.c);
            g.setColor(new Color(w.c.getRed(), w.c.getBlue(), w.c.getGreen(), 5));
            g.fillOval((int) w.x, (int) w.y, (int) w.r, (int) w.r);
//            g.drawLine((int) w.prev.x, (int) w.prev.y, (int) w.x, (int) w.y);
            if (Math.abs(w.prev.x - w.x) < 75 && Math.abs(w.prev.y - w.y) < 75)
                g2.draw(new Line2D.Float(w.prev.x, w.prev.y, w.x, w.y));
            try {
                w.prev = (Walker) w.clone();
            } catch (CloneNotSupportedException e) {
                e.printStackTrace();
            }
        }
        tm.start();
    }

    @Override
    public void actionPerformed(ActionEvent actionEvent) {
        for (Walker w : ws) {
            Random rand = new Random();
            int prob = rand.nextInt(1000);
            w.angle = (float) (rand.nextFloat() * Math.PI * 2);
            if (prob == 0) {
                w.x += (25 + rand.nextInt(50)) * Math.cos(w.angle);
                w.y += (25 + rand.nextInt(50)) * Math.sin(w.angle);
//                System.out.println(w.prev.x + " " + w.x + " " + w.prev.y + " " + w.y);
            } else {
                w.x += 2 * Math.cos(w.angle);
                w.y += 2 * Math.sin(w.angle);
            }

            if (!(w.x > 25 && w.x < WIDTH - 25 &&
                    w.y > 25 && w.y < HEIGHT - 25)) {
                if (w.x < 25) w.x = WIDTH - 26;
                if (w.x > WIDTH - 25) w.x = 25;
                if (w.y < 25) w.y = HEIGHT - 26;
                if (w.y > HEIGHT - 25) w.y = 25;
            }
        }
        repaint();
    }
}
