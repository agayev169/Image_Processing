static class Matrix {
  float data[][];
  int cols;
  int rows;
  
  public Matrix(int rows, int cols) {
    this.rows = rows;
    this.cols = cols;
    data = new float[rows][cols];
  }
  
  public Matrix (float data[][]) {
    this.rows = data.length;
    this.cols = data[0].length;
    this.data = new float[rows][cols]; 
    for (int i = 0; i < this.rows; i++) {
      for (int j = 0; j < this.cols; j++) {
        this.data[i][j] = data[i][j];
      }
    }
  }
  
  public static Matrix matmul(Matrix a, Matrix b) {
    if (a.cols != b.rows) {
      println("Matmul Error!");
      return null;
    }
    Matrix res = new Matrix(a.rows, b.cols);
    
    for (int i = 0; i < a.rows; i++) {
      for (int j = 0; j < b.cols; j++) {
        float sum = 0.0;
        for (int k = 0; k < a.cols; k++) {
          sum += a.data[i][k] * b.data[k][j];
        }
        res.data[i][j] = sum;
      }
    }
    
    return res;
  }
  
  public float[][] toArray() {
    float[][] data = new float[this.rows][this.cols];
    for (int i = 0; i < this.rows; i++) {
      for (int j = 0; j < this.cols; j++) {
        data[i][j] = this.data[i][j];
      }
    }
    return data;
  }
  
  public String toString() {
    String res = "";
    for (int i = 0; i < this.rows; i++) {
      for (int j = 0; j < this.cols; j++) {
        res += this.data[i][j] + ", ";
      }
      res += "\n";
    }
    
    return res;
  }
}
