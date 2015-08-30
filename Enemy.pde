interface Enemy {  
  float xCor();
  float yCor();
  int val();

  void display();
  
  void act();
  
  boolean collide();
  
  void move();
}
