class Vector4D {
  float x;
  float y;
  float z;
  float w;
  
  Vector4D(float x, float y, float z, float w) {
    this.x = x;
    this.y = y;
    this.z = z;
    this.w = w;
  }
  
  Vector4D(Matrix m) {
    this.x = m.data[0][0];
    this.y = m.data[1][0];
    this.z = m.data[2][0];
    this.w = m.data[3][0];
  }
  
  Vector4D() {
    this.x = 0;
    this.y = 0;
    this.z = 0;
    this.w = 0;
  }
  
  public void mult(float n) {
    x *= n;
    y *= n;
    z *= n;
    w *= n;
  }
}
