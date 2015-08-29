class Asteroid implements Enemy{
  int xCor, yCor;
  int val;
  int bVal, lrVal;
  
  int xCor(){ return xCor; }
  int yCor(){ return yCor; }
  int val(){ return val; }
  
  void Asteroid(){
    xCor = (int)random(XSIZE/10, XSIZE*9/10);
    yCor = -YSIZE/10;
    val = 3;
  }
  
  void display(){
    image(asteroid1, xCor, yCor);
  }
  
  boolean collide(){
    return true;
  }
  
  void move(){
    yCor += YSIZE/100;
  }
}
