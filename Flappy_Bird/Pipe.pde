class Pipe {
  float x;
  float top;
  float bottom;
  float gap;
  float w = width / 5;
  //final static float VEL = 1.5f;
  final float VEL = width / 266.0;
  
  Pipe() {
    x = width + random(width / 8);
    //x = 200;
    gap = random(height / 4.8, height / 3.4);
    top = random(height / 12, height - gap - height / 12);
    bottom = top + gap;
  }
  
  void update() {
    this.show();
    this.x -= VEL;
    
  }
  
  void show() {
    noStroke();
    fill(255);
    rect(x, 0, w, top);
    rect(x, bottom, w, height);
  }
}
