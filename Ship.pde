class Ship{
  int fuel;
  int xCor,yCor;
  float sWidth, sHeight;
  int dir; //0 = not moving, 1 = left, 2 = right
  boolean hit;
  
  Ship(){
    xCor = XSIZE/2;
    yCor = YSIZE*6/7;
    
    sWidth = YSIZE/4*145/600;
    sHeight = YSIZE/4*311/600;
    
    fuel = 1000;
    dir = 0;
  }
  
  void left(){
    if(xCor + YSIZE/8-sWidth/2 > XSIZE/100)
      xCor -= XSIZE/100;
  }
  
  void right(){
    if(xCor + YSIZE/8+sWidth/2 + XSIZE/100 < XSIZE)
      xCor += XSIZE/100;
  }
  
  void display(){
    imageMode(CORNER);
    if(hit && frameCount%2 == 0){
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
