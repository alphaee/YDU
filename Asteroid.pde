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
    //    xCor = (int)random(XSIZE/10, XSIZE*9/10);
    xCor = random(XSIZE);
    yCor = random(-YSIZE/10,0);
    val = 20;
    //println("hi");
    aWidth = YSIZE/6*210/600;
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
    return !(player.xCor > xCor+aWidth || player.xCor+player.sWidth < xCor 
      || player.yCor > yCor+aHeight || player.yCor+player.sHeight < yCor);
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
    if(xCor > -XSIZE/10 && xCor < 11*XSIZE/10 && yCor < YSIZE*11/10) //guessed
      return true;
    return false;
  }
}
