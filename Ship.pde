class Ship{
  int fuel;
  int xCor,yCor;
  int lrWidth;
  
  Ship(){
    xCor = XSIZE/2;
    yCor = YSIZE*2/3;
    lrWidth = 100;
    fuel = 1000;
  }
  
  void left(){
    if(xCor - lrWidth - XSIZE/100 > 0)
      xCor -= XSIZE/100;
  }
  
  void right(){
    if(xCor + lrWidth + XSIZE/100 < XSIZE)
      xCor += XSIZE/100;
  }
  
  void display(){
    fill(0);
    ellipse(xCor,yCor,200,200);
  }  
}
