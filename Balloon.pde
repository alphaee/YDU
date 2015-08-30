class Balloon implements Enemy {
  float xCor, yCor;
  int val;
  int bVal, lrVal;

  float xCor() { 
    return xCor;
  }
  float yCor() { 
    return yCor;
  }
  int val() { 
    return val;
  }

  Balloon() {
    xCor = (int)random(XSIZE/10, XSIZE*9/10);
    yCor = -YSIZE/10;
    val = 2;
  }

  void act() {
    display();
    move();
  }

  void display() {
    image(balloon, xCor, yCor);
  }

  void move() {
    yCor += YSIZE/100;
  }

  boolean collide() {
    return true;
  }
}

