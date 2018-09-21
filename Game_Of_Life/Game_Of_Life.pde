boolean[][] field;
boolean[][] prev;
boolean[][] next;
boolean colorMode = false;

int ds = 10;
int cols;
int rows;

boolean play = false;
int score = 0;

void setup() {
  size(400, 400);
  cols = width / ds;
  rows = height / ds;
  field = new boolean[rows][cols];
  generate();
  prev = new boolean[rows][cols];
}

void draw() {
  background(255);
  stroke(100);
  for (int i = ds; i < height; i += ds) {
    for (int j = ds; j < width; j += ds) {
      point(j, i);
    }
  }

  ellipseMode(CORNER);
  noStroke();
  fill(0);
  if (colorMode) {
    for (int i = 0; i < field.length; i++) {
      for (int j = 0; j < field[i].length; j++) {
        int neighbours = neighbours(j, i);
        if (field[i][j] == false && neighbours == 3) {
          fill(0, 255, 0, 50);
          ellipse(j * ds, i * ds, ds * .8, ds * .8);
        } else if (field[i][j] == true && (neighbours == 3 || neighbours == 2)) {
          fill(0, 255, 0);
          ellipse(j * ds, i * ds, ds * .8, ds * .8);
        } else if (field[i][j] == true) {
          fill(255, 0, 0);
          ellipse(j * ds, i * ds, ds * .8, ds * .8);
        }
      }
    }
  } else {
    fill(0);
    for (int i = 0; i < field.length; i++) {
      for (int j = 0; j < field[i].length; j++) {
        if (field[i][j])
          ellipse(j * ds, i * ds, ds * .8, ds * .8);
      }
    }
  }

  if (play) {
    nextStep();
  }
}

void keyPressed() {
  if (key == ' ') {
    play = !play;
  } else if (key == 'i') {
    println("Score: " + score);
  } else if (key == '\n') {
    nextStep();
  } else if (key == 'c') {
    colorMode = !colorMode;
  } else if (key == 'r') {
    generate();
    prev = new boolean[rows][cols];
    score = 0;
  }
}

void nextStep() {
  next = new boolean[rows][cols];

  for (int i = 0; i < field.length; i++) {
    for (int j = 0; j < field[i].length; j++) {
      int neighbours = neighbours(j, i);
      if (field[i][j] == false && neighbours == 3) {
        next[i][j] = true;
      } else if (field[i][j] == true && (neighbours == 2 || neighbours == 3)) {
        next[i][j] = true;
      } else {
        next[i][j] = false;
      }
    }
  }

  if (!isGameOver()) {
    println("Game Over!");
    println("Score: " + score);
    play = false;
  }

  prev = field.clone();
  field = next.clone();
  score++;
}

boolean isGameOver() {
  boolean first = false;
  boolean second = false;
  for (int i = 0; i < field.length; i++) {
    for (int j = 0; j < field[0].length; j++) {
      if (prev[i][j] != next[i][j] && second == true) return true;
      else if (prev[i][j] != next[i][j]) first = true;
      if (field[i][j] != next[i][j] && first == true) return true;
      else if (field[i][j] != next[i][j]) second = true;
    }
  }
  return false;
}

int neighbours(int x, int y) {
  int neighbours = 0;

  int[] dx;
  int[] dy;
  if (x != 0 && x != field[0].length - 1) {
    if (y != 0 && y != field.length - 1) {
      dx = new int[] {-1, -1, -1, 0, 0, 1, 1, 1};
      dy = new int[] {-1, 0, 1, -1, 1, -1, 0, 1};
    } else if (y == 0) {
      dx = new int[] {-1, -1, -1, 0, 0, 1, 1, 1};
      dy = new int[] {field.length - 1, 0, 1, field.length - 1, 1, field.length - 1, 0, 1};
    } else {
      dx = new int[] {-1, -1, -1, 0, 0, 1, 1, 1};
      dy = new int[] {-1, 0, -(field.length - 1), -1, -(field.length - 1), -1, 0, -(field.length - 1)};
    }
  } else if (x == 0 && y != 0 && y != field.length - 1) {
    dx = new int[] {field[0].length - 1, field[0].length - 1, field[0].length - 1, 0, 0, 1, 1, 1};
    dy = new int[] {-1, 0, 1, -1, 1, -1, 0, 1};
  } else if (x == field[0].length - 1 && y != 0 && y != field.length - 1) {
    dx = new int[] {-1, -1, -1, 0, 0, -(field[0].length - 1), -(field[0].length - 1), -(field[0].length - 1)};
    dy = new int[] {-1, 0, 1, -1, 1, -1, 0, 1};
  } else if (x == 0 && y == 0) {
    dx = new int[] {field[0].length - 1, field[0].length - 1, field[0].length - 1, 0, 0, 1, 1, 1};
    dy = new int[] {field.length - 1, 0, 1, field.length - 1, 1, field.length - 1, 0, 1};
  } else if (x == 0 && y == field.length - 1) {
    dx = new int[] {field[0].length - 1, field[0].length - 1, field[0].length - 1, 0, 0, 1, 1, 1};
    dy = new int[] {-1, 0, -(field.length - 1), -1, -(field.length - 1), -1, 0, -(field.length - 1)};
  } else if (x == field[0].length - 1 && y == 0) {
    dx = new int[] {-1, -1, -1, 0, 0, -(field[0].length - 1), -(field[0].length - 1), -(field[0].length - 1)};
    dy = new int[] {field.length - 1, 0, 1, field.length - 1, 1, field.length - 1, 0, 1};
  } else {
    dx = new int[] {-1, -1, -1, 0, 0, -(field[0].length - 1), -(field[0].length - 1), -(field[0].length - 1)};
    dy = new int[] {-1, 0, -(field.length - 1), -1, -(field.length - 1), -1, 0, -(field.length - 1)};
  }

  for (int i = 0; i < 8; i++) {
    //println("y: " + y + ", x: " + x);
    neighbours += field[y + dy[i]][x + dx[i]] == true ? 1 : 0;
  }
  return neighbours;
}

void generate() {
  for (int i = 0; i < field.length; i++) {
    for (int j = 0; j < field[i].length; j++) {
      field[i][j] = (random(1) > 0.5) ? false : true;
    }
  }
}
