class Balloon implements Enemy{
  int xCor, yCor;
  
  int xCor(){ return xCor; }
  int yCor(){ return yCor; }
  
  void display(){
    image(balloon, xCor, yCor);
  }
  
  void collide(){
  }
}
