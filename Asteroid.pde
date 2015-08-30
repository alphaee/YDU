class Asteroid implements Enemy {
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

   Asteroid() {
    //    xCor = (int)random(XSIZE/10, XSIZE*9/10);
    xCor = random(XSIZE);
    yCor = -YSIZE/10;
    val = 3;
    println("hi");
  }

  void act() {
    display();
    move();
  }

  void display() {
    image(asteroid1, xCor, yCor);
  }

  boolean collide() {
    return true;
  }

  void move() {
    yCor += YSIZE/100;
  }
}

