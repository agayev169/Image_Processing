/*variables : X F
 constants : + − [ ]
 axiom  : X
 rules  : (X → F−[[X]+X]+F[+FX]−X), (F → FF)
 angle  : 25°*/

String prev;
String last;


void setup() {
  size(640, 480);

  prev = "X";
  last = prev;
}

int count = 0;
float size = 128;

void draw() {
  background(255);
  translate(width / 4, height);
  rotate(radians(10));
  for (int i = 0; i < last.length(); i++) {
    if (last.charAt(i) == 'F') {
      line(0, 0, 0, -size);
      translate(0, -size);
      //size = size / 1.01;
    } else if (last.charAt(i) == '-') {
      rotate(radians(-25));
    } else if (last.charAt(i) == '+') {
      rotate(radians(25));
    } else if (last.charAt(i) == '[') {
      pushMatrix();
    } else if (last.charAt(i) == ']') {
      popMatrix();
    }
  }
  
  prev = last;
  last = "";
  for (int i = 0; i < prev.length(); i++) {
    if (prev.charAt(i) == 'X') {
      last += "F−[[X]+X]+F[+FX]−X";
    } else if (prev.charAt(i) == 'F') {
      last += "FF";
    } else last += prev.charAt(i);
  }
  
  size = (float) Math.pow(2, 7 - count);

  count++;
  println(count);
}

void generate() {
  prev = last;
  last = "";
  for (int i = 0; i < prev.length(); i++) {
    if (prev.charAt(i) == 'X') {
      last += "F−[[X]+X]+F[+FX]−X";
    } else if (prev.charAt(i) == 'F') {
      last += "FF";
    } else last += prev.charAt(i);
  }
  
  size = (float) Math.pow(2, 7 - count);

  count++;
  println(prev);
  println(count);
}

void keyPressed() {
  if (key == ' ') {
    generate();
  } else if (key == 's') {
    saveFrame("Fractal_tree_###.png");
  }
}
