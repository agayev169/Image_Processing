Paddle p;
Ball b;
ArrayList<Block> blocks = new ArrayList<Block>();

void setup() {
  size(400, 700);
  p = new Paddle();
  b = new Ball();
  
  for (int y = 150; y < 250; y += 20) {
    for (int x = 50; x < width - 50; x += 50) {
      //if (((y - 150) % 40 == 0 && x % 100 == 0) || (x % 100 != 0)) 
      blocks.add(new Block(x, y));
    }
  }
}

void draw() {
  background(0);
  p.update();
  b.update(p, blocks);
  for (Block block : blocks) {
    block.render();
  }
  
  if (blocks.isEmpty()) {
    fill(255, 0, 0);
    textAlign(CENTER);
    textSize(64);
    text("YOU WIN", width / 2, height / 2);
  } else if (b.y >= height) {
    fill(255, 0, 0);
    textAlign(CENTER);
    textSize(64);
    text("GAME OVER", width / 2, height / 2);
  }
}

void keyPressed() {
  switch(key) {
    case 'a':
    case 'A':
      if (b.isAttached) {
        b.angle -= 0.01;
        b.angle = constrain(b.angle, -3 * PI/4, -PI/4);
      } else
        p.dx = -5;
      break;
    case 'd':
    case 'D':
      if (b.isAttached) {
        b.angle += 0.01;
        b.angle = constrain(b.angle, -3 * PI/4, -PI/4);
      } else
        p.dx = 5;
      break;
    case ' ':
      if (b.isAttached) { 
        b.vx = cos(b.angle) * 5;
        b.vy = sin(b.angle) * 5;
        b.isAttached = false;
      }
  }
}

void keyReleased() {
  if (key == 'a' || key == 'A' || key == 'd' || key =='D') {
    p.dx = 0;
  }
}
