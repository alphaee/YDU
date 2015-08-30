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
    return val - 2*hLevel;
  }

  Asteroid() {
    //    xCor = (int)random(XSIZE/10, XSIZE*9/10);
    xCor = random(XSIZE);
    yCor = random(-YSIZE/10,0);
    val = 20;
    //println("hi");
    aWidth = YSIZE/6*146/600;
    aHeight = YSIZE/6*195/600;
    xDirection = (int)(3*random(1) - 1);
  }

  void act() {
    display();
    move();
  }

  void display() {
    image(asteroid1, xCor, yCor);
  }

  boolean collide() {
    return !(player.xCor + YSIZE/8 - player.sWidth/2 > xCor + YSIZE/16 + aWidth/2 || player.xCor + YSIZE/8 + player.sWidth/2 < xCor + YSIZE/16 - aWidth/2
      || player.yCor + YSIZE/8 - player.sHeight/2 > yCor + YSIZE/16 + aHeight/2 || player.yCor + YSIZE/8 + player.sHeight/2 < yCor + YSIZE/16 - aWidth/2);
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
    if(xCor + YSIZE/16 + aWidth/2 > 0 && xCor + YSIZE/16 - aWidth/2 < XSIZE && yCor + YSIZE/16 - aHeight/2 < YSIZE)
      return true;
    return false;
  }
}
