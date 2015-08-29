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

PImage rocket;
PImage rocketL;
PImage rocketR;
PImage coin;
PImage cloud;

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
  
  rocket = loadImage("rocket.png");
  rocket.resize(YSIZE/4,YSIZE/4);
  rocketL = loadImage("rocket-left-flame.png");
  rocketL.resize(YSIZE/4,YSIZE/4);
  rocketR = loadImage("rocket-right-flame.png");
  rocketR.resize(YSIZE/4,YSIZE/4);
  coin = loadImage("coin.png");
  coin.resize(YSIZE/10,YSIZE/10);
  cloud = loadImage("cloud.png");
  cloud.resize(YSIZE/10,YSIZE/10);
}

void setup2(){
  player.fuel = 1000;
  score = 0;
  state = 10;
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
      image(cloud,XSIZE/6, YSIZE/8);
      image(cloud, XSIZE/4, YSIZE/6);
      image(cloud, XSIZE/2, YSIZE/3);
      image(cloud, XSIZE*2/3, YSIZE/4);
      
      decFuel = 0;
      
      player.display();  
      
      if(mousePressed){
        detect();
      }
      else{
        player.dir = 0;
      }
      
      decFuel();
      stats();
      checkScore();
      checkDeath();
      break;
      
  case 20: //upgrade screen
    fill(255);
    background(0);
    textSize(XSIZE/9);
    text("UPGRADES", XSIZE/2, YSIZE/15);
    textSize(XSIZE/20);
    textAlign(LEFT,CENTER);
    text("Best Distance:" + highscore + "m", YSIZE/30, YSIZE/11 + YSIZE/20);
    text("Your Distance:" + score + "m", YSIZE/30, YSIZE/11 + YSIZE/12);
    imageMode(CENTER);
    image(coin, YSIZE/22, YSIZE/7 + YSIZE/11);
    text(":" + coins, YSIZE/17, YSIZE/7 + YSIZE*2/20 + 3);
    textSize(XSIZE/10);
    textAlign(CENTER,CENTER);
    stroke(255);
    text("RETRY", XSIZE/2, YSIZE*3/4);
    if(mousePressed){
      if(mouseY > YSIZE*2/3){
        setup2();
      }
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
    player.dir = 1;
    player.left();
  }
  else{  
    player.dir = 2;
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
  fill(50);
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
