interface Enemy {  
  int xCor();
  int yCor();
  int val();

  void display();
  
  boolean collide();
  
  void move();
}
