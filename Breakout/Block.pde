class Block {
  float x;
  float y;
  float w = 50;
  float h = 20;
  
  Block(float x, float y) {
    this.x = x;
    this.y = y;
  }
  
  void render() {
    rectMode(CORNER);
    fill(50, 50, 200);
    stroke(0);
    rect(x, y, w, h);
  }
  
}
