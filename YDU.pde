//Young, Dan, Franklin
//Young Ditched Us
import java.io.*;

int XSIZE, YSIZE;

int state;

Ship player;

ArrayList<Enemy>[] enemies; //0-Balloon, 1-Asteroid

int coins;
int score;
int highscore;
int sLevel;

PImage rocket;
PImage rocketL;
PImage rocketR;
PImage rocket0;
PImage rocket0L;
PImage rocket0R;
PImage rocket1;
PImage rocket1L;
PImage rocket1R;
PImage rocket2;
PImage rocket2L;
PImage rocket2R;
PImage coin;
PImage cloud;
PImage bird1, bird2;
PImage balloon;
PImage asteroid1, asteroid2;
PImage meteor;

PFont font;

int decFuel;

int invin;

boolean released;

PrintWriter output;

void setup() {
  orientation(PORTRAIT);
   // XSIZE = displayWidth;
   // YSIZE = displayHeight;
   // size(displayWidth, displayHeight);
   XSIZE = 400; //comment this when using on android
   YSIZE = 600;
   size(XSIZE, YSIZE);
  frameRate(45);

  player = new Ship();

  parseData();

  enemies = (ArrayList<Enemy>[])new ArrayList[2];

  font = loadFont("VCROSDMono-200.vlw");
  textFont(font);
  
  rocket0 = loadImage("shuttle-middle-flame.png");
  rocket0.resize(YSIZE/4, YSIZE/4);
  
  rocket0L = loadImage("shuttle-left-flame.png");
  rocket0L.resize(YSIZE/4, YSIZE/4);
  
  rocket0R = loadImage("shuttle-right-flame.png");
  rocket0R.resize(YSIZE/4, YSIZE/4);
  
  rocket1 = loadImage("fueltank-middle-flame.png");
  rocket1.resize(YSIZE/4, YSIZE/4);
  
  rocket1L = loadImage("fueltank-left-flame.png");
  rocket1L.resize(YSIZE/4, YSIZE/4);
  
  rocket1R = loadImage("fueltank-right-flame.png");
  rocket1R.resize(YSIZE/4, YSIZE/4);
  
  rocket2 = loadImage("rocket-middle-flame.png");
  rocket2.resize(YSIZE/4, YSIZE/4);

  rocket2L = loadImage("rocket-left-flame.png");
  rocket2L.resize(YSIZE/4, YSIZE/4);

  rocket2R = loadImage("rocket-right-flame.png");
  rocket2R.resize(YSIZE/4, YSIZE/4);

  coin = loadImage("coin.png");
  coin.resize(YSIZE/10, YSIZE/10);

  cloud = loadImage("cloud.png");
  cloud.resize(YSIZE/10, YSIZE/10);

  bird1 = loadImage("bird1.png");
  bird1.resize(YSIZE/6, YSIZE/10);

  bird2 = loadImage("bird2.png");
  bird2.resize(YSIZE/6, YSIZE/10);

  balloon = loadImage("HotAirBalloon2.png");
  balloon.resize(YSIZE/6, YSIZE/6);

  asteroid1 = loadImage("Asteroid1.png");
  asteroid1.resize(YSIZE/8, YSIZE/8);

  asteroid2 = loadImage("Asteroid2.png");
  asteroid2.resize(YSIZE/8, YSIZE/8);

  meteor = loadImage("Meteor.png");
  meteor.resize(YSIZE/2, YSIZE/2);

  for (int i = 0; i < enemies.length; i ++) {
    enemies[i] = new ArrayList<Enemy>();
  }
  
  if(sLevel == 0){
    rocket = rocket0;
    rocketL = rocket0L;
    rocketR = rocket0R;
  }
  else if(sLevel == 1){
    rocket = rocket1;
    rocketL = rocket1L;
    rocketR = rocket1R;
  }
  else{
    rocket = rocket2;
    rocketL = rocket2L;
    rocketR = rocket2R;
  }
  
  // for (int j = 0; j < 5; j ++) {
  //   Balloon temp = new Balloon();
  //   enemies[0].add(temp);

  //   Asteroid temp2 = new Asteroid();
  //   enemies[1].add(temp2);
  // }
  state = 20;
}

void setup2() {//RESTART
  player.fuel = 1000;
  score = 0;

  for (int i = 0; i < enemies.length; i ++) {
    enemies[i] = new ArrayList<Enemy>();
  }

  // for (int j = 0; j < 5; j ++) {
  //   Balloon temp = new Balloon();
  //   enemies[0].add(temp);

  //   Asteroid temp2 = new Asteroid();
  //   enemies[0].add(temp2);
  // }

  state = 10;
}

void draw() {
  switch(state) {
  case 00: //homescreen
    background(0);
    fill(255);
    textSize(XSIZE/10);
    textAlign(CENTER, CENTER);
    text("To Infinity...", XSIZE/2, YSIZE/10); 
    textSize(XSIZE/7);
    text("START", XSIZE/2, YSIZE*5/6);
    imageMode(CENTER);
    image(meteor, XSIZE/2, YSIZE*7/18);
    if (mousePressed) {
      state = 10;
    }
    break;

  case 10: //main game
    buildBackground();

    decFuel = 0;

    if (player.hit && invin < millis())
      player.hit = false;

    player.display();  

    if (mousePressed) {
      detect();
    } else {
      player.dir = 0;
    }
    
    spawnEnemies();
    
    stats();

    actAll();

    checkHits();

    decFuel();
  
    enemyDeath();

    checkScore();
    checkDeath();
    break;

  case 20: //upgrade screen
    fill(255);
    background(0);
    textSize(XSIZE/9);
    textAlign(CENTER,CENTER);
    text("UPGRADES", XSIZE/2, YSIZE/15);
    textSize(XSIZE/20);
    textAlign(LEFT, CENTER);
    text("Best Distance:" + highscore/10. + "km", YSIZE/30, YSIZE/11 + YSIZE/20);
    text("Your Distance:" + score/10. + "km", YSIZE/30, YSIZE/11 + YSIZE/12);
    imageMode(CENTER);
    image(coin, YSIZE/22, YSIZE/8 + YSIZE/11);
    text(":" + coins, YSIZE/17, YSIZE/8 + YSIZE*2/20 - 5);
    
    textSize(XSIZE/10);
    textAlign(CENTER, CENTER);
    stroke(255);
    text("RETRY", XSIZE/2, YSIZE*5/6);
    
    textSize(XSIZE/20);
    textAlign(LEFT,CENTER);
    text("Thruster Upgrade:", YSIZE/30, YSIZE/4 + YSIZE/30);
    
    PImage progress;
    
    if(sLevel == 0){
      progress = loadImage("progress-bar-1.png");
    }
    else if(sLevel == 1){
      progress = loadImage("progress-bar-2.png");
    }
    else{
      progress = loadImage("progress-bar-3.png");
    }
    progress.resize(XSIZE*4/5, YSIZE/10);
    imageMode(CORNER);
    image(progress,YSIZE/30, YSIZE/4);
    
    if (released&&mousePressed) {
      if (mouseY > YSIZE*2/3) {
        setup2();
      }
      released = false;
    }

    break;
  }
}


void buildBackground() {
  background(178-score*178/1000, 240-score*240/1000, 255-score*255/1000);
  image(cloud, XSIZE/6, YSIZE/8);
  image(cloud, XSIZE/4, YSIZE/6);
  image(cloud, XSIZE/2, YSIZE/3);
  image(cloud, XSIZE*2/3, YSIZE/4);

  image(bird1, XSIZE/3, YSIZE/2);
  image(bird2, XSIZE/3 + XSIZE/25, YSIZE/2 - 20);
  image(bird1, XSIZE/3 + XSIZE*2/25, YSIZE/2 - 40);
  image(bird1, XSIZE/3 - XSIZE/25, YSIZE/2 - 20);
  image(bird1, XSIZE*4/5, YSIZE*2/5);
}

void keyPressed() {
  if (keyCode == RIGHT)
    player.right();
  if (keyCode == LEFT)
    player.left();
}

void spawnEnemies(){
  if(frameCount%3 == 0){
    if (0 <= score && score <= 400){
      if(random(120) + score/100 > 110){
        Balloon temp = new Balloon();
        enemies[0].add(temp);
      }
    }
    if (300 <= score && score <= 800){
      if(random(124) + score/100> 115){
        Asteroid temp = new Asteroid();
        enemies[0].add(temp);
      }
    }
  }
}

void mousePressed() {
  if (state==20)
    released = true;
}
 
void detect() {
  if(abs(mouseX - (player.xCor + YSIZE/8)) > 5){
    if (mouseX < player.xCor + YSIZE/8) {
      player.dir = 2;
      player.left();
    } 
    else{  
      player.dir = 1;
      player.right();
    }
  }
}

void decFuel() {
  player.fuel -= decFuel;
  if (frameCount%2 == 0 && random(10) < 8)
    player.fuel -= 1;
}

void actAll() {
  for (int i = 0; i < enemies.length; i++)
    for (Enemy e : enemies[i])
      e.act();
}

void checkHits() {
  if (!player.hit) {
    for (int i = 0; i < enemies.length; i++)
      for (Enemy e : enemies[i])
        if (e.collide()) {
          decFuel += e.val();
          invin = millis() + 1000;
          player.hit = true;
        }
  }
}

void checkScore() {
  if (frameCount%4 == 0)
    score++;
}

void checkDeath() {
  if (player.fuel < 0) {
    if (score > highscore)
      highscore = score;
    writeFile();
    updateCoins();
    state = 20;
  }
}

void enemyDeath(){
  for (int i = 0; i < enemies.length; i++)
      for (int k = 0; k < enemies[i].size(); k++)
        if (!enemies[i].get(k).inBounds()) {
          enemies[i].remove(k);
        }
}

void stats() {
  textSize(XSIZE/20);
  fill(50);
  textAlign(RIGHT);
  text("Height:" + score/10. + "km", XSIZE*29/30, YSIZE/20);
  if(player.hit)
    fill(#EA1509);
  textAlign(LEFT);
  text("Fuel:" + player.fuel/10. + "%", XSIZE/30, YSIZE/20);
}

void updateCoins(){
  coins += score;
}

void parseData() {
  String[] data;
  try {
    data = readFile();
    coins = Integer.parseInt(data[0]);
    highscore = Integer.parseInt(data[1]);
  }
  catch(Exception e) {
  }
}

void writeFile() {
  output = createWriter("data.txt");
  output.println(coins);
  output.println(highscore);
  output.flush();
  output.close();
}

String[] readFile() throws FileNotFoundException {
  BufferedReader reader = createReader("data.txt");
  String[] ret = new String[2];
  try {
    ret[0] = reader.readLine();
    ret[1] = reader.readLine();
    reader.close();
  }
  catch(Exception e) {
  }
  return ret;
}
