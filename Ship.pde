class Ship{
  int fuel;
  int xCor,yCor;
  float sWidth, sHeight;
  int dir; //0 = not moving, 1 = left, 2 = right
  boolean hit;
  
  Ship(){
    sWidth = YSIZE/4*145/600;
    sHeight = YSIZE/4*311/600;
    
    xCor = XSIZE/2 - 2*YSIZE/4*145/600*11/10;
    yCor = YSIZE*4/5;
    
    fuel = 1000;
    dir = 0;
  }
  
  void left(){
    if(xCor + YSIZE/8-sWidth/2 > XSIZE/100)
      xCor = xCor - XSIZE/100 - XSIZE/200*(sLevel/2);
  }
  
  void right(){
    if(xCor + YSIZE/8+sWidth/2 + XSIZE/100 < XSIZE)
      xCor = xCor + XSIZE/100 + XSIZE/200*(sLevel/2);
  }
  
  void display(){
    imageMode(CORNER);
    if(hit){
      if(frameCount%2 ==0){
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
    else{
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
}
