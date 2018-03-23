import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.util.LinkedList;
import java.util.Random;

public class MatrixMovieAnimation extends JPanel implements ActionListener {

    private static final int WIDTH = 640;
    private static final int HEIGHT = 480;

    class Chars {
        Character c;
        int x, y;

        Chars(Character c) {
            this.c = c;
            Random rand = new Random();
            this.x = rand.nextInt(WIDTH) / 20 * 20;
            this.y = rand.nextInt(100) - 120;
        }
    }

    private Timer t = new Timer(10, this);

    private LinkedList<Chars> chars = new LinkedList<>();

    public static void main(String[] args) {
        JFrame jf = new JFrame();
        MatrixMovieAnimation jp = new MatrixMovieAnimation();
        jf.setLayout(new BorderLayout());
        jf.setSize(WIDTH, HEIGHT);
        jf.setTitle("Matrix Code");
        jf.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        jf.setVisible(true);
        jf.add(jp);
    }

    private int index = -1;
    private int count = 0;

    @Override
    protected void paintComponent(Graphics g) {
        g.setColor(Color.BLACK);
        g.fillRect(0, 0, WIDTH, HEIGHT);
        if (index != -1) {
            count++;
            g.setColor(Color.WHITE);
            if (index < chars.size())
                g.fillRect(chars.get(index).x, chars.get(index).y - 12, 6, 12);
        }
        g.setColor(Color.GREEN);
        g.setFont(new Font("Matrix Code NFI", Font.BOLD, 12));
        for (Chars c : chars) {
            g.drawString(c.c.toString(), c.x, c.y);
//            System.out.println(c.c + " ");
        }
        t.start();
        Random rand = new Random();
        int prob = rand.nextInt(200);
        if (prob == 0) {
            count = 0;
            index = rand.nextInt(chars.size());
            g.setColor(Color.WHITE);
            g.fillRect(chars.get(index).x, chars.get(index).y, 6, 12);
        } else if (count > 25)
            index = -1;
    }

    @Override
    public void actionPerformed(ActionEvent actionEvent) {
        Random rand = new Random();
        char newC = (char) (rand.nextInt(26) + 97);
        chars.add(new Chars(newC));
        for (Chars c : chars) {
            c.y++;
        }
        for (int i = 0; i < chars.size(); i++) {
            if (chars.get(i).y > 500) chars.remove(i);
        }
        repaint();
    }
}

