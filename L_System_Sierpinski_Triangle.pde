import processing.pdf.*;

/*variables : X Y
 constants : F + −
 start  : FX
 rules  : (X → X+YF+), (Y → −FX−Y)
 angle  : 90°*/

String prev;
String last;


void setup() {
  size(5000, 5000);
  beginRecord(PDF, "Sierpinski_triangle.pdf");

  prev = "A";
  last = prev;
}

int count = 0;
float size = 4;

void draw() {
  background(255);
  translate(width / 4, height - height / 20);
  for (int i = 0; i < last.length(); i++) {
    if (last.charAt(i) == 'A' || last.charAt(i) == 'B') {
      line(0, 0, 0, -size);
      translate(0, -size);
    } else if (last.charAt(i) == '-') {
      rotate(radians(-60));
    } else if (last.charAt(i) == '+') {
      rotate(radians(60));
    }
  }
}

void generate() {
  prev = last;
  last = "";
  for (int i = 0; i < prev.length(); i++) {
    if (prev.charAt(i) == 'A') {
      last += "B-A-B";
    } else if (prev.charAt(i) == 'B') {
      last += "A+B+A";
    } else last += prev.charAt(i);
  }

  count++;
  println(last);
  println(count);
}

void keyPressed() {
  if (key == ' ') {
    generate();
  } else if (key == 's') {
    endRecord();
    save("Sierpinski_triangle.png");
    noLoop();
    exit();
  }
}
