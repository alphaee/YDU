class Asteroid implements Enemy {
  float xCor, yCor;
  int val;
  float aWidth, aHeight;

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
    val = 20;
    //println("hi");
    aWidth = YSIZE/6*210/600;
    aHeight = YSIZE/6*195/600;
  }

  void act() {
    display();
    move();
  }

  void display() {
    image(asteroid1, xCor, yCor);
  }

  boolean collide() {
    return !(player.xCor > xCor+aWidth || player.xCor+player.sWidth < xCor 
      || player.yCor > yCor+aHeight || player.yCor+player.sHeight < yCor);
  }

  void move() {
    yCor += YSIZE/100;
  }
}
