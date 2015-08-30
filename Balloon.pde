class Balloon implements Enemy {
  float xCor, yCor;
  int val, xDirection;
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
    // xCor = (int)random(XSIZE/10, XSIZE*9/10);
    xCor = random(XSIZE);
    yCor = random(-YSIZE/10,0);
    val = 30;
    bWidth = YSIZE/6*240/600;
    bHeight = YSIZE/6*330/600;
    xDirection = (int)(2*random(1) - 1);
  }

  void act() {
    display();
    move();
  }

  void display() {
    image(balloon, xCor, yCor);
  }
  
  boolean collide() {
    return !(player.xCor > xCor+bWidth || player.xCor+player.sWidth < xCor 
      || player.yCor > yCor+bHeight || player.yCor+player.sHeight < yCor);  
  }

  void move() {
    yCor += YSIZE/200;
    if (xDirection == 0){
      xCor += XSIZE/450;
    }
    else{
      xCor -= XSIZE/450;
    }
  }
  
  boolean inBounds(){
    if(xCor > -XSIZE/10 && xCor < 11*XSIZE/10 && yCor < YSIZE*11/10)
      return true;
    return false;
  }
}
