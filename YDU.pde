//Young, Dan, Franklin
//Young Ditched Us
import java.io.*;

int XSIZE,YSIZE;

int state;

Ship player;

int coins;
int score;
int highscore;

int decFuel;

PFont font;

PrintWriter output;

void setup(){
  //orientation(PORTRAIT);
  //XSIZE = displayWidth;
  //YSIZE = displayHeight;
  XSIZE = 720; //comment this when using on android
  YSIZE = 1280;
  size(XSIZE,YSIZE);
  frameRate(60);
  
  player = new Ship();
  
  parseData();
  
  font = loadFont("VCROSDMono-200.vlw");
  textFont(font);
}

void setup2(){
  player.fuel = 1000;
  score = 0;
}

void draw(){
  switch(state){
    case 00: //homescreen
      background(0);
      fill(255);
      textSize(XSIZE/10);
      textAlign(CENTER,CENTER);
      text("To Infinity...", XSIZE/2, YSIZE/10); 
      textSize(XSIZE/7);
      text("START",XSIZE/2,YSIZE*3/4);
      if(mousePressed){
        state = 10;
      }
      break;
    
    case 10: //main game
      background(#B2F0FF);
      
      decFuel = 0;
      
      player.display();  
      
      if(mousePressed){
        detect();
      }
      
      decFuel();
      stats();
      checkScore();
      checkDeath();
      break;
      
  case 20: //game over
    background(0);
    if(mousePressed){
      setup2();
      state = 10;
    }
    break;
    
  }
}

void keyPressed(){
  if(keyCode == RIGHT)
    player.right();
  if(keyCode == LEFT)
    player.left();
}

void detect(){
  if(mouseX < XSIZE/2){
    player.left();
  }
  else{
    player.right();
  }
}

void decFuel(){
  player.fuel -= decFuel;
  if(frameCount%2 == 0)
    player.fuel -= 1;
}

void checkScore(){
  if(frameCount%3 == 0)
    score++;
}

void checkDeath(){
  if(player.fuel < 0){
    if(score > highscore)
      highscore = score;
    writeFile();
    state = 20;
  }
}

void stats(){
  textSize(XSIZE/20);
  text("Fuel:" + player.fuel/10. + "%", XSIZE/5, YSIZE/20);
  text("Height:" + score + "m", XSIZE*4/5, YSIZE/20);
}

void parseData(){
  String[] data;
  try{
    data = readFile();
    coins = Integer.parseInt(data[0]);
    highscore = Integer.parseInt(data[1]);
  }
  catch(Exception e){
  }
}

void writeFile(){
  output = createWriter("data/data.txt");
  output.println(coins);
  output.println(highscore);
  output.close();
}

String[] readFile() throws FileNotFoundException {
  return loadStrings("data.txt");
}
