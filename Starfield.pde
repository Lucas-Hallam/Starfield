int starNumber = 500;
int shipNumber = 10;
double centerX = -50;
double centerY = -50;
Star[] stars = new Star[starNumber+shipNumber];
void setup() {
  size(700, 700);
  background(0);
  for (int i = 0; i < starNumber; i++) {
    stars[i] = new Star();
  }
  for (int i = 0; i < shipNumber; i++) {
    stars[i+starNumber] = new Ship();
  }
  stroke(255);
  noStroke();
}
void draw() {
  background(0);
  for (Star s : stars) {
    s.move();
    s.show();
  }
}
void keyPressed(KeyEvent e) {
  if (e.getKeyCode() == 37) {
    centerX += 100;
  } else if (e.getKeyCode() == 38) {
    centerY += 100;
  } else if (e.getKeyCode() == 39) {
    centerX += -100;
  } else if (e.getKeyCode() == 40) {
    centerY += -100;
  } else if (e.getKeyCode() == 32) {
    zoomDouble();
  } else if (e.getKeyCode() == 8) {
    zoomHalf();
  }
}
void zoomDouble() {
  centerX = 2*(centerX-350)+350;
  centerY = 2*(centerY-350)+350;
  for (Star s : stars) {
    s.zoomDouble();
  }
}
void zoomHalf() {
  centerX = 0.5*(centerX-350)+350;
  centerY = 0.5*(centerY-350)+350;
  for (Star s : stars) {
    s.zoomHalf();
  }
}
class Star {
  double r, an, myX, myY, speed, size;
  int c;
  Star() {
    c = color((int)(256*Math.random()), (int)(256*Math.random()), (int)(256*Math.random()));
    r = 1900*Math.random()+100;
    an = 2*Math.PI*Math.random();
    speed = 25/Math.sqrt(r*r*r);
    size = 8*Math.random()+2;
  }
  void move() {
    an += speed;
    myX = r*Math.cos(an)+centerX;
    myY = r*Math.sin(an)+centerY;
  }
  void show() {
    fill(c);
    ellipse((float) myX, (float) myY, (float) size, (float) size);
  }
  void changeCenter(double x, double y) {
    centerX += x;
    centerY += y;
  }
  void zoomDouble() {
    r=2*r;
    size = 1.5*size;
  }
  void zoomHalf() {
    r=0.5*r;
    size = 1/1.5*size;
  }
}
class Ship extends Star {
  double r, an, myX, myY, speed, size;
  boolean i = true;
  int j = 0;
  int c;
  Ship() {
    r = 1900*Math.random()+100;
    an = 2*Math.PI*Math.random();
    speed = 25/Math.sqrt(r*r*r);
    size = 10;
  }
  void move() {
    an += speed;
    myX = r*Math.cos(an)+centerX;
    myY = r*Math.sin(an)+centerY;
    c = color(j);
    if (j == 252) {
      i = false;
    }
    if (j == 0) {
      i = true;
    }
    if (i == true) {
      j += 255/62;
    } else {
      j -= 255/62;
    }
  }
  void show() {
    fill(c);
    ellipse((float) myX, (float) myY, (float) size, (float) size);
  }
  void changeCenter(double x, double y) {
    centerX += x;
    centerY += y;
  }
  void zoomDouble() {
    r=2*r;
    size = 1.25*size;
  }
  void zoomHalf() {
    r=0.5*r;
    size = 1/1.25*size;
  }
}
