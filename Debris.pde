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

  Balloon() {
    // xCor = (int)random(XSIZE/10, XSIZE*9/10);
    xCor = random(XSIZE);
    yCor = random(-YSIZE/10,0);
    val = 30;
    bWidth = YSIZE/6*240/600;
    bHeight = YSIZE/6*330/600;
    xDirection = (int)(3*random(1) - 1);
    if(random(2) < 1)
      imgnum = 1;
  }

  void act() {
    display();
    move();
  }

  void display() {
    if(imgnum ==1)
      image(balloon1, xCor, yCor);
    else
      image(balloon0, xCor, yCor);
  }
  
  boolean collide() {
    return !(player.xCor + YSIZE/8 - player.sWidth/2 > xCor + YSIZE/12 + bWidth/2 || player.xCor + YSIZE/8 + player.sWidth/2 < xCor + YSIZE/12 - bWidth/2
      || player.yCor + YSIZE/8 - player.sHeight/2 > yCor + YSIZE/12 + bHeight/2 || player.yCor + YSIZE/8 + player.sHeight/2 < yCor + YSIZE/12 - bWidth/2);
  }

  void move() {
    yCor += YSIZE/200;
    if (xDirection == 0){
      xCor += XSIZE/500.0;
    }
    else{
      xCor -= XSIZE/500.0;
    }
  }
  
  boolean inBounds(){
    if(xCor + YSIZE/12 + bWidth/2 > 0 && xCor + YSIZE/12 - bWidth/2 < XSIZE && yCor + YSIZE/12 - bHeight/2 < YSIZE)
      return true;
    return false;
  }
}
