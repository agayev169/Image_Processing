PImage img;
void setup() {
  size(100, 100);
  img = loadImage("Strasbourg.jpg");
  //img.resize(640, 480);
  img.filter(GRAY);
  noLoop();
}

void draw() {
  //image(img, 0, 0);

  img.loadPixels();
  for (int y = 0; y < img.height - 1; y++) {
    for (int x = 1; x < img.width - 1; x++) {
      color col = img.pixels[index(x, y, img)];
      float r = red(col);
      float g = green(col);
      float b = blue(col);

      int factor = 1;
      float newR = round(factor * r / 255) * 255 / factor;
      float newG = round(factor * g / 255) * 255 / factor;
      float newB = round(factor * b / 255) * 255 / factor;

      img.pixels[index(x, y, img)] = color(newR, newG, newB);

      float errR = r - newR;
      float errG = g - newG;
      float errB = b - newB;

      compensate(x, y, img, color(errR, errG, errB));
    }
  }
  img.updatePixels();

  //image(img, 640, 0);
  
  //img.resize(4032, 3024);
  img.save("Strasbourg_dithered.jpg");
  println("Saved!");
  exit();
}

int index(int x, int y, PImage img) {
  return (y * img.width + x);
}

void compensate(int x, int y, PImage img, color err) {
  color col = img.pixels[index(x + 1, y, img)];

  float r = red(col);
  float g = green(col);
  float b = blue(col);

  r = r + red(err) * 7 / 16;
  g = g + green(err) * 7 / 16;
  b = b + blue(err) * 7 / 16;

  img.pixels[index(x + 1, y, img)] = color(r, g, b);


  col = img.pixels[index(x - 1, y + 1, img)];

  r = red(col);
  g = green(col);
  b = blue(col);

  r = r + red(err) * 3 / 16;
  g = g + green(err) * 3 / 16;
  b = b + blue(err) * 3 / 16;

  img.pixels[index(x - 1, y + 1, img)] = color(r, g, b);


  col = img.pixels[index(x, y + 1, img)];

  r = red(col);
  g = green(col);
  b = blue(col);

  r = r + red(err) * 5 / 16;
  g = g + green(err) * 5 / 16;
  b = b + blue(err) * 5 / 16;

  img.pixels[index(x, y + 1, img)] = color(r, g, b);


  col = img.pixels[index(x + 1, y + 1, img)];

  r = red(col);
  g = green(col);
  b = blue(col);

  r = r + red(err) * 1 / 16;
  g = g + green(err) * 1 / 16;
  b = b + blue(err) * 1 / 16;

  img.pixels[index(x + 1, y + 1, img)] = color(r, g, b);
}
