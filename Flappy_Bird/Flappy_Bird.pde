Bird bird;
ArrayList<Pipe> pipes = new ArrayList<Pipe>();
final float GRAVITY = 1;

void setup() {
  //size(400, 600);
  fullScreen();
  bird = new Bird();
  pipes.add(new Pipe());
}

void draw() {
  if (bird != null) {
    background(0);
    for (Pipe pipe : pipes) {
      pipe.update();
      if (pipe.x < bird.x + bird.r && pipe.x + pipe.w > bird.x - bird.r &&
          (pipe.top > bird.y - bird.r || pipe.bottom < bird.y + bird.r)) {
            restart();
            return;
      }
    }
    bird.update();
    
    if (pipes.get(pipes.size() - 1).x < width / 3) {
      pipes.add(new Pipe());
    }
    
    for (int i = pipes.size() - 1; i >= 0; i--) {
      if (pipes.get(i).x + pipes.get(i).w < -10) pipes.remove(i);
    } 
    
    if (bird.y + bird.r > height || bird.y - bird.r < 0) {
      restart();
    }
  }
}

void mousePressed() {
  if (bird != null) {
    bird.swing();
  }
}

void restart() {
  pipes.clear();
  pipes.add(new Pipe());
  bird = new Bird();
}
