class Vector3D {
  float x;
  float y;
  float z;
  
  Vector3D(float x, float y, float z) {
    this.x = x;
    this.y = y;
    this.z = z;
  }
  
  Vector3D(Matrix m) {
    this.x = m.data[0][0];
    this.y = m.data[1][0];
    this.z = m.data[2][0];
  }
  
  Vector3D() {
    this.x = 0;
    this.y = 0;
    this.z = 0;
  }
  
  public void mult(float n) {
    x *= n;
    y *= n;
    z *= n;
  }
}
