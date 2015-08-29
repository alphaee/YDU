class Ship{
  int fuel;
  int xCor,yCor;
  int lWidth,rWidth;
  int dir; //0 = not moving, 1 = left, 2 = right
  
  Ship(){
    xCor = XSIZE/2;
    yCor = YSIZE*3/4;
    lWidth = YSIZE/32;
    rWidth = YSIZE/8;
    fuel = 1000;
    dir = 0;
  }
  
  void left(){
    if(xCor - lWidth - XSIZE/100 > 0)
      xCor -= XSIZE/100;
  }
  
  void right(){
    if(xCor + rWidth + XSIZE/100 < XSIZE)
      xCor += XSIZE/100;
  }
  
  void display(){
    imageMode(CENTER);
    if(dir == 0){
      image(rocket,xCor,yCor);
    }
    else if(dir == 1){
      image(rocketL,xCor,yCor);
    }
    else{
      image(rocketR,xCor,yCor);
    }
  }  
}
