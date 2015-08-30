class Asteroid implements Enemy {
  float xCor, yCor;
  int val, xDirection;
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
    //xCor = (int)random(XSIZE/10, XSIZE*9/10);
    xCor = random(XSIZE);
    yCor = random(-YSIZE/10,0);
    val = 20;
    aWidth = YSIZE/6*210/600;
    aHeight = YSIZE/6*195/600;
    xDirection = (int)(2*random(1) - 1);
  }

  void act() {
    display();
    move();
  }

  void display() {
    image(asteroid1, xCor, yCor);
  }

  boolean collide() {
    return !(player.xCor > xCor+aWidth || player.xCor+YSIZE/4 < xCor 
      || player.yCor > yCor+aHeight || player.yCor+YSIZE/4 < yCor);
  }

  void move() {
    yCor += YSIZE/100;
    if (xDirection == 0){
      xCor += XSIZE/600.0;
    }
    else{
      xCor -= XSIZE/600.0;
    }
  }
  
  boolean inBounds(){
    if(xCor + YSIZE/8 - player.sWidth/2 > 0 && xCor + YSIZE/8 + player.sWidth/2 < XSIZE && yCor + YSIZE/8 - player.sHeight/2 < YSIZE)
      return true;
    return false;
  }
}
