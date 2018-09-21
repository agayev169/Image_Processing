float angle = 0.0;

void setup() {
  size(640, 480);
}

void draw() {
  translate(width / 2, height / 2);
  background(0);
  
  stroke(255);
  strokeWeight(4);
  
  int numOfPoints = 16;
  
  Matrix[] points = new Matrix[numOfPoints];
  
  int index = 0;
  for (float x = -0.5; x <= 0.5; x += 1) {
    for (float y = -0.5; y <= 0.5; y += 1) {
      for (float z = -0.5; z <= 0.5; z += 1) {
        for (float w = -0.5; w <= 0.5; w += 1) {
          points[index] = new Matrix(new float[][]{{x}, {y}, {z}, {w}});
          index++;
        }
      }
    }
  }
  
  Matrix rotationZW = new Matrix(new float[][] {{cos(angle), -sin(angle), 0, 0}, 
                                                {sin(angle),  cos(angle), 0, 0}, 
                                                {0         ,           0, 1, 0}, 
                                                {0         ,           0, 0, 1}});
  
  Matrix rotationXY = new Matrix(new float[][] {{1         ,           0, 0, 0}, 
                                                {0         ,           1, 0, 0},
                                                {0, 0, cos(angle), -sin(angle)}, 
                                                {0, 0, sin(angle),  cos(angle)}});
  
  Matrix rotationXZ = new Matrix(new float[][] {{1, 0         , 0, 0},
                                                {0, cos(angle), 0, -sin(angle)}, 
                                                {0, 0         , 1, 0}, 
                                                {0, sin(angle), 0, cos(angle)}});
  
  Matrix rotationYZ = new Matrix(new float[][] {{cos(angle), 0, 0, -sin(angle)},
                                                {0, 1         , 0, 0}, 
                                                {0, 0         , 1, 0}, 
                                                {sin(angle), 0, 0, cos(angle)}});
              
  Matrix rotationYW = new Matrix(new float[][] {{cos(angle), 0, -sin(angle), 0}, 
                                                {0         , 1, 0          , 0}, 
                                                {sin(angle), 0,  cos(angle), 0}, 
                                                {0         , 0,           0, 1}});
              
  Matrix rotationXW = new Matrix(new float[][] {{1, 0         , 0          , 0}, 
                                                {0, cos(angle), -sin(angle), 0}, 
                                                {0, sin(angle),  cos(angle), 0}, 
                                                {0,0          ,0           , 1}});
  
  
  float dist = 1;
  
  Matrix[] ps4D = new Matrix[numOfPoints];
  Matrix[] ps3D = new Matrix[numOfPoints];
  Vector2D[] ps2D = new Vector2D[numOfPoints];
  
  for (int i = 0; i < points.length; i++) {
    ps4D[i] = Matrix.matmul(rotationXY, points[i]);
    ps4D[i] = Matrix.matmul(rotationXZ, ps4D[i]);
    ps4D[i] = Matrix.matmul(rotationYZ, ps4D[i]);
    ps4D[i] = Matrix.matmul(rotationYW, ps4D[i]);
    ps4D[i] = Matrix.matmul(rotationZW, ps4D[i]);
    ps4D[i] = Matrix.matmul(rotationXW, ps4D[i]);
    
    float w = dist / (dist * 2 - ps4D[i].data[3][0]);                                           
    Matrix projection3D = new Matrix(new float[][] {{w, 0, 0, 0},
                                                    {0, w, 0, 0},
                                                    {0, 0, w, 0}});
    ps3D[i] = Matrix.matmul(projection3D, ps4D[i]);
    
    float z = dist / (dist * 2 - ps3D[i].data[2][0]);                                           
    Matrix projection2D = new Matrix(new float[][] {{z, 0, 0},
                                                  {0, z, 0}});
                                                  
    ps2D[i] = new Vector2D(Matrix.matmul(projection2D, ps3D[i]));
    ps2D[i].mult(800);
    point(ps2D[i].x, ps2D[i].y);
  }
  
  strokeWeight(1);
  
  for (int i = 0; i < numOfPoints; i++) {
    if (i % 4 == 0) {
      connect(ps2D, i, i + 1);
      connect(ps2D, i, i + 2);
      connect(ps2D, i + 1, i + 3);
      connect(ps2D, i + 2, i + 3);
    }
    
    if (i + 4 < numOfPoints && (i < 4 || i >= 8)) {
      connect(ps2D, i, i + 4);
    }
    if (i + 8 < numOfPoints) {
      connect(ps2D, i, i + 8);
    }
  }
  
  
  
  angle += 0.005;
}

float[] conv2Dto1D(float[][] data2D) {
  float[] data1D = new float[data2D[0].length];
  for (int i = 0; i < data2D[0].length; i++) {
    data1D[i] = data2D[0][i];
  }
  return data1D;
}

void connect(Vector2D[] ps2D, int i, int j) {
  Vector2D p1 = ps2D[i];
  Vector2D p2 = ps2D[j];
  line(p1.x, p1.y, p2.x, p2.y);
}

//void connect2D(Vector2D[] ps2D) {
//  stroke(255);
//  strokeWeight(1);
//  for (int i = 0; i < ps2D.length; i++) {
//    Vector2D p1 = ps2D[i];
//    for (int j = i; j < ps2D.length; j++) {
//      Vector2D p2 = ps2D[j];
//      if (Vector2D.distance(p1, p2) <= 100) {
//        line(p1.x, p1.y, p2.x, p2.y);
//      }
//    }
//  }
//}
