class Bird {
  float x;
  float y;
  float r = width / 20;
  float vel;
  
  //float swingCoef = 10.0f;
  float swingCoef = height / 60.0;
  
  Bird() {
    x = width / 8;
    y = height / 2;
    vel = 0;
  }
  
  void update() {
    this.show();
    
    vel -= GRAVITY;
    y -= vel;
  }
  
  void show() {
    fill(255);
    noStroke();
    ellipse(x, y, r * 2, r * 2);
  }
  
  void swing() {
    vel += swingCoef;
  }
}
