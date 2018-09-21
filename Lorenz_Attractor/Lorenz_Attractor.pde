float scale = 1;
float px, py;
ArrayList<PVector> ps = new ArrayList<PVector>();

float da = PI / 1000;
float angle = 0;

float x = 0.01, y = 0.01, z = 0.01;
float a = 10, b = 30, c = 8 / 3;

void setup() {
  size(600, 600, P3D);
  px = mouseX;
  py = mouseY;
}

void draw() {
  float dt = 0.01f;
  float dx = (a * (y - x)) * dt;
  float dy = (x * (b - z) - y) * dt;
  float dz = (x * y - c * z) * dt;
  
  x += dx;
  y += dy;
  z += dz;
  
  scale(5);
  
  background(0);
  colorMode(HSB);
  translate(50, 50, -50);
  //rotateY(map(mouseX - px, 0, width, -PI, PI));
  rotateY(angle);

  noFill();
  float hue = 0;
  beginShape();
  for (PVector p : ps) {
    //i++;
    stroke(hue, 225, 225, 200);
    vertex(p.x, p.y, p.z);
    hue += 0.1;
    if (hue > 255) hue = 0;
  }
  endShape();

  ps.add(new PVector(x, y, z));
  angle += da;
  
  //saveFrame("./output/####.png");
  
  //text("" + frameCount, 0, 0);
  
  //if (frameCount == 1800) {
  //  noLoop();
  //  exit();
  //}
}

void mousePressed() {
  px = mouseX;
  py = mouseY;
}
