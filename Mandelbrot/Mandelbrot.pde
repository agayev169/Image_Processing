double leftRangeX = -2.0;
double rightRangeX = 1.0;
double leftRangeY = -1.5;
double rightRangeY = 1.5;

double mx;
double my;


double dt = 0;

void setup() {
  //size(400, 400);
  fullScreen();
  mx = width / 2;
  my = height / 2;
  
  double proportion = height / 3;
  
  rightRangeX = width / proportion / 3;
  leftRangeX = -2.0 * rightRangeX;
  leftRangeY = -1.5;
  rightRangeY = 1.5;
}

void draw() {
  colorMode(HSB);
  //background(0);
  loadPixels();
  for (int y = 0; y < height; y++) {   
    for (int x = 0; x < width; x++) {  
      double a = (double)x / (double)width * (rightRangeX - leftRangeX) + leftRangeX;
      double b = (double)y / (double)height * (rightRangeY - leftRangeY) + leftRangeY;
      
      double ca = a;
      double cb = b;
      
      //println(a + ", " + b);
      
      int i = 0;
      
      int iters = 100;
      while (i < iters) {
        if (a * a + b * b > 4) {
          break;
        }
        
        double a2 = a * a - b * b;
        double b2 = 2 * a * b;
        
        a = a2 + ca;
        b = b2 + cb;
        
        i++;
      }
      
      // for RGB
      //color c = color(map(i, 0, iters, 0, 8), map(i, 0, iters, 0, 46), map(i, 0, iters, 0, 208));
      //if (i == iters) c = color(255);
      
      // for HSB
      //color c = color(map(i, 0, iters, 0, 255), 200, 255);
      //if (i == iters) c = color(255, 200, 255);
      
      color c = color(255 * sin((float)dt) * sin((float)dt), 200, 200);
      if (i == iters) c = color(0, 0, 255);
      
      //color c = color(255 * f(x, y) / 2, map(i, 0, iters, 0, 255), map(i, 0, iters, 0, 255));
      //if (i == iters) c = color(0, 0, 255);
      
      int index = y * width + x;
      
      //set(x, y, c);
      pixels[index] = c;
    }
  }
  updatePixels();
  dt += 0.02;
}

float f(double x, double y) {
  x = map((float)x, 0, (float)(rightRangeX - leftRangeX), 0, PI);
  y = map((float)y, 0, (float)(rightRangeY - leftRangeY), 0, PI);
  
  return abs(sin((float)x) * cos((float)y) + cos((float)x * sin(((float)y))));
}

void mousePressed() {
  mx = mouseX;
  my = mouseY;
}

void keyPressed() {
  switch(key) {
    case 'z':
    case 'Z':
      //double x = map(mx, 0, width, (float)leftRangeX, (float)rightRangeX);
      //double y = map(my, 0, height, (float)leftRangeY, (float)rightRangeY);
      
      double distX = rightRangeX - leftRangeX;
      double distY = rightRangeY - leftRangeY;
      
      double x = mx / (double)width * distX + leftRangeX;
      double y = my / (double)height * distY + leftRangeY;
      
      leftRangeX = x - distX / 4.0;
      rightRangeX = x + distX / 4.0;
      leftRangeY = y - distY / 4.0;
      rightRangeY = y + distY / 4.0;
      
      mx = width / 2;
      my = height / 2;
      break;
    case 'b':
    case 'B':
      distX = rightRangeX - leftRangeX;
      distY = rightRangeY - leftRangeY;
      
      x = mx / (double)width * distX + leftRangeX;
      y = my / (double)height * distY + leftRangeY;
      
      leftRangeX = x - distX;
      rightRangeX = x + distX;
      leftRangeY = y - distY;
      rightRangeY = y + distY;
      break;
    case 's':
    case 'S':
      saveFrame("Mandelbrot_" + (rightRangeX - leftRangeX) / 2 + "-" + (rightRangeY - leftRangeY) / 2);
      break;
    case 'i':
      println(dt);
      break;
  }
}
