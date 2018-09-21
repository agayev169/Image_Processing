class Paddle {
  float x = width / 2;
  float y = 95 * height / 100;
  float w = width / 7;
  float h = 2.5 * height / 100;
  
  float dx = 0;
  
  //Paddle() {
    
  //}
  
  void update() {
    render();
    move();
  }
  
  void render() {
    rectMode(CENTER);
    fill(205);
    noStroke();
    rect(x, y, w, h);
  }
  
  void move() {
    x += dx;
    x = constrain(x, w / 2, width - w / 2);
  }
}
