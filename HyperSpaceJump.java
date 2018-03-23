import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.geom.Line2D;
import java.util.LinkedList;
import java.util.Random;

public class HyperSpaceJump extends JPanel implements ActionListener {

    static final int WIDTH = 640, HEIGHT = 480;
    static final float MAX_VEL = 7.0f, MIN_VEL = 2.0f;

    static class Star {
        int x, y;
        float vel;
        Star() {
            Random rand = new Random();
            x = WIDTH / 10 + rand.nextInt(WIDTH - WIDTH / 10);
            y = HEIGHT / 10 + rand.nextInt(HEIGHT - HEIGHT / 10);
            vel = rand.nextFloat() * (MAX_VEL - MIN_VEL) + MIN_VEL;
        }
    }

    static LinkedList<Star> stars = new LinkedList<>();
    Timer t = new Timer(5, this);

    public static void main(String[] args) {
        JFrame jf = new JFrame();
        HyperSpaceJump jp = new HyperSpaceJump();
        jf.setSize(WIDTH, HEIGHT);
        jf.setTitle("Hyperspace Jump");
        jf.setLayout(new BorderLayout());
        jf.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        jf.setVisible(true);
        jf.add(jp);
        stars.add(new Star());
    }

    @Override
    protected void paintComponent(Graphics g) {
        t.start();
        g.setColor(Color.BLACK);
        g.fillRect(0, 0, WIDTH, HEIGHT);
        for (Star s : stars) {
            g.setColor(new Color(180, 180, 200 + (int)(s.vel / MAX_VEL * 55)));
            Graphics2D g2 = (Graphics2D) g;
            g2.setStroke(new BasicStroke(s.vel / 2.0f));
            g2.draw(new Line2D.Float(s.x, s.y, s.x + (s.x - WIDTH / 2) * MAX_VEL * 10 / WIDTH,
                    s.y + (s.y - HEIGHT / 2) * MAX_VEL * 10 / HEIGHT));
        }
    }

    @Override
    public void actionPerformed(ActionEvent actionEvent) {
        stars.add(new Star());
        stars.add(new Star());
        stars.add(new Star());
        stars.add(new Star());
        stars.add(new Star());
        stars.add(new Star());
        stars.add(new Star());
        for (int i = 0; i < stars.size(); i++) {
            Star s = stars.get(i);
            if (s.x < -20 || s.x > WIDTH + 20 || s.y < -20 || s.y > HEIGHT + 20) stars.remove(i);
        }
        for (Star s : stars) {
            float xVel = (s.x - WIDTH / 2) * MAX_VEL / WIDTH * 2;
            float yVel = (s.y - HEIGHT / 2) * MAX_VEL / HEIGHT * 2;
            if (s.x < WIDTH / 2 + WIDTH / 10 && s.x >= WIDTH / 2)
                s.x += (WIDTH / 2 + WIDTH / 10 - WIDTH / 2) * MAX_VEL / WIDTH * 2;
            else if (s.x > WIDTH / 2 - WIDTH / 10 && s.x < WIDTH / 2)
                s.x += (WIDTH / 2 - WIDTH / 10 - WIDTH / 2) * MAX_VEL / WIDTH * 2;
            else s.x += (s.x - WIDTH / 2) * MAX_VEL / WIDTH * 2;
            if (s.y < HEIGHT / 2 + HEIGHT / 10 && s.y >= HEIGHT / 2)
                s.y += (HEIGHT / 2 + HEIGHT / 10 - HEIGHT / 2) * MAX_VEL / HEIGHT * 2;
            else if (s.y > HEIGHT / 2 - HEIGHT / 10 && s.y < HEIGHT / 2)
                s.y += (HEIGHT / 2 - HEIGHT / 10 - HEIGHT / 2) * MAX_VEL / HEIGHT * 2;
            else s.y += (s.y - HEIGHT / 2) * MAX_VEL / HEIGHT * 2;
        }
        repaint();
    }
}
