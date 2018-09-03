import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.geom.Line2D;
import java.util.LinkedList;
import java.util.Random;

public class PurpleRain extends JPanel implements ActionListener {

    static final int WIDTH = 640, HEIGHT = 480;
    static final float MAX_VEL = 5.0f, MIN_VEL = 1.0f;

    static class Rain {
        int x, y1, y2;
        float vel;
        Rain() {
            Random rand = new Random();
            x = rand.nextInt(WIDTH);
            y1 = rand.nextInt(120) - 200;
            y2 = y1 + 20 + rand.nextInt(30);
            vel = (y2 - y1) / 50.0f * (MAX_VEL - MIN_VEL) + MIN_VEL;
        }
    }

    static LinkedList<Rain> rain = new LinkedList<>();
    Timer t = new Timer(5, this);

    public static void main(String[] args) {
        JFrame jf = new JFrame();
        PurpleRain jp = new PurpleRain();
        rain.add(new Rain());
        jf.setSize(WIDTH, HEIGHT);
        jf.setLayout(new BorderLayout());
        jf.setTitle("Purple Rain");
        jf.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        jf.setVisible(true);
        jf.add(jp);
    }

    @Override
    protected void paintComponent(Graphics g) {
        t.start();
        g.setColor(Color.BLACK);
        g.fillRect(0, 0, WIDTH, HEIGHT);
        for (Rain r : rain) {
            g.setColor(new Color(200 + (int)(r.vel / MAX_VEL * 55), 0,
                    200 + (int)(r.vel / MAX_VEL * 55)));
            Graphics2D g2 = (Graphics2D) g;
            g2.setStroke(new BasicStroke(r.vel / 2));
            g2.draw(new Line2D.Float(r.x, r.y1, r.x, r.y2));
        }
    }

    @Override
    public void actionPerformed(ActionEvent actionEvent) {
        rain.add(new Rain());
        rain.add(new Rain());
        for (Rain r : rain) {
            r.y1 += r.vel;
            r.y2 += r.vel;
        }
        for (int i = 0; i < rain.size(); i++) {
            if (rain.get(i).y1 > 500) rain.remove(i);
        }

        repaint();
    }
}
