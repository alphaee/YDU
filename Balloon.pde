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
    xDirection = (int)(3*random(1) - 1);
  }

  void act() {
    display();
    move();
  }

  void display() {
    image(balloon, xCor, yCor);
  }
  
  boolean collide() {
    return !(player.xCor > xCor+bWidth || player.xCor+YSIZE/4 < xCor 
      || player.yCor > yCor+bHeight || player.yCor+YSIZE/4 < yCor);  
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
    if(xCor + YSIZE/8 - player.sWidth/2 > 0 && xCor + YSIZE/8 + player.sWidth/2 < XSIZE && yCor + YSIZE/8 - player.sHeight/2 < YSIZE)
      return true;
    return false;
  }
}
