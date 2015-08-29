class Balloon implements Enemy{
  int xCor, yCor;
  int val;
  int bVal, lrVal;
  
  int xCor(){ return xCor; }
  int yCor(){ return yCor; }
  int val(){ return val; }

  void Balloon(){
    xCor = (int)random(XSIZE/10, XSIZE*9/10);
    yCor = -YSIZE/10;
    val = 2;
  }
  
  void display(){
    image(balloon, xCor, yCor);
  }
  
  void move(){
    yCor += YSIZE/100;
  }
  
  boolean collide(){
    return true;
  }
}
