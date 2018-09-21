class Vector2D {
  float x;
  float y;
  
  Vector2D(float x, float y) {
    this.x = x;
    this.y = y;
  }
  
  Vector2D(Matrix m) {
    this.x = m.data[0][0];
    this.y = m.data[1][0];
  }
  
  Vector2D() {
    this.x = 0;
    this.y = 0;
  }
  
  public void mult(float n) {
    x *= n;
    y *= n;
  }
}
