class Balloon implements Enemy {
  float xCor, yCor;
  int val;
  float bWidth, bHeight;

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
    val = 20;
    bWidth = YSIZE/6*240/600;
    bHeight = YSIZE/6*330/600;
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
    return !(player.xCor > xCor+bWidth || player.xCor+player.sWidth < xCor 
      || player.yCor > yCor+bHeight || player.yCor+player.sHeight < yCor);  }
}

