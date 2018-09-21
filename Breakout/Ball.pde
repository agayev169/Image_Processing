class Ball {
  float x = width / 2;
  float r = width / 50;
  float y = 95 * height / 100 - 2.5 * height / 100;

  float vx = 0;
  float vy = 0;
  float angle = -PI/2;

  boolean isAttached = true;
  
  float speed = 5;

  //Paddle() {

  //}

  void update(Paddle p, ArrayList<Block> bs) {
    render();
    if (!isAttached) {
      move();
      collision(p, bs);
    }
  }

  void render() {
    if (isAttached) {
      stroke(255);
      line(x, y, x + 20 * cos(angle), y + 20 * sin(angle));
    }
    ellipseMode(RADIUS);
    fill(205, 0, 0);
    noStroke();
    ellipse(x, y, r, r);
  }

  void move() {
    x += vx;
    y += vy;
    //x = constrain(x, r, width - r);
    if (x - r <= 0 || x + r >= width) vx *= -1;
    if (y - r <= 0) vy *= -1;
    //else if (y + r >= height) println("Game Over!");
  }

  void collision(Paddle p, ArrayList<Block> bs) {
    if (x + r >= p.x - p.w / 2 && x - r <= p.x + p.w / 2 &&
      y <= p.y && y + r >= p.y - p.h / 2 && vy > 0) {
      //vy *= -1;
      angle = map(x - p.x, -p.w, p.w, -3*PI/4, -PI/4);
      vx = speed * cos(angle);
      vy = speed * sin(angle);
    }

    for (int i = bs.size() - 1; i >= 0; i--) {
      Block b = bs.get(i);
      if (x + r >= b.x && x - r <= b.x + b.w &&
        y - r <= b.y + b.h && y + r >= b.y) {
        bs.remove(i);
        //vx *= -1;
        if ((x + r <= b.x + speed && vx > 0) || (x - r >= b.x + b.w - speed && vx < 0)) vx *= -1;
        if ((y + r <= b.y + speed && vy > 0) || (y - r >= b.y + b.h - speed && vy < 0)) vy *= -1;
        break;
      }
    }
  }
}
