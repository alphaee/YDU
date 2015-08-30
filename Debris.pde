class Debris implements Enemy {
  float xCor, yCor;
  int val, xDirection;
  float dWidth, dHeight;
  int imgnum;

  float xCor() { 
    return xCor;
  }
  float yCor() { 
    return yCor;
  }
  int val() { 
    return val - 2*hLevel;
  }

  Debris() {
    // xCor = (int)random(XSIZE/10, XSIZE*9/10);
    xCor = random(XSIZE);
    yCor = random(-YSIZE/10, 0);
    val = 40;
    dWidth = YSIZE/8*600/800;
    dHeight = YSIZE/8*600/800;
    xDirection = (int)(3*random(1) - 1);
    if (random(2) < 1)
      imgnum = 1;
  }

  void act() {
    display();
    move();
  }

  void display() {
    image(debris, xCor, yCor);
  }

  boolean collide() {
    return !(player.xCor + YSIZE/8 - player.sWidth/2 > xCor + YSIZE/12 + dWidth/2 || player.xCor + YSIZE/8 + player.sWidth/2 < xCor + YSIZE/12 - dWidth/2
      || player.yCor + YSIZE/8 - player.sHeight/2 > yCor + YSIZE/12 + dHeight/2 || player.yCor + YSIZE/8 + player.sHeight/2 < yCor + YSIZE/12 - dWidth/2);
  }

  void move() {
    yCor += YSIZE/500;
    if (xDirection == 0) {
      xCor += XSIZE/1250.0;
    } else {
      xCor -= XSIZE/1250.0;
    }
//    if (xCor<XSIZE/300.0 || xCor>XSIZE-XSIZE/300.0)
//      xDirection = (xDirection+1)%2;
    }

    boolean inBounds() {
      return xCor + YSIZE/12 + dWidth/2 > 0 && xCor + YSIZE/12 - dWidth/2 < XSIZE && yCor + YSIZE/12 - dHeight/2 < YSIZE ;
    }
}

