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

PImage rocket;
PImage rocketL;
PImage rocketR;
PImage coin;
PImage cloud;
PImage bird1, bird2;
PImage balloon;
PImage asteroid1, asteroid2;
PImage meteor;

PFont font;

int decFuel;

int invin;

PrintWriter output;

void setup() {
  orientation(PORTRAIT);
  // XSIZE = displayWidth;
  // YSIZE = displayHeight;
  // size(displayWidth, displayHeight);
  XSIZE = 400; //comment this when using on android
  YSIZE = 700;
  size(XSIZE, YSIZE);
  frameRate(45);

  player = new Ship();

  parseData();

  enemies = (ArrayList<Enemy>[])new ArrayList[2];

  font = loadFont("VCROSDMono-200.vlw");
  textFont(font);

  rocket = loadImage("rocket-middle-flame.png");
  rocket.resize(YSIZE/4, YSIZE/4);
  rocketL = loadImage("rocket-left-flame.png");
  rocketL.resize(YSIZE/4, YSIZE/4);
  rocketR = loadImage("rocket-right-flame.png");
  rocketR.resize(YSIZE/4, YSIZE/4);
  coin = loadImage("coin.png");
  coin.resize(YSIZE/10, YSIZE/10);
  cloud = loadImage("cloud.png");
  cloud.resize(YSIZE/10, YSIZE/10);
  bird1 = loadImage("Bird1.png");
  bird1.resize(YSIZE/6, YSIZE/10);
  bird2 = loadImage("Bird2.png");
  bird2.resize(YSIZE/6, YSIZE/10);
  balloon = loadImage("HotAirBalloon2.png");
  balloon.resize(YSIZE/6, YSIZE/6);
  asteroid1 = loadImage("Asteroid1.png");
  asteroid1.resize(YSIZE/6, YSIZE/6);
  asteroid2 = loadImage("Asteroid2.png");
  asteroid2.resize(YSIZE/6, YSIZE/6);
  meteor = loadImage("Meteor.png");
  meteor.resize(YSIZE/2,YSIZE/2);

  for (int i = 0; i < enemies.length; i ++) {
    enemies[i] = new ArrayList<Enemy>();
  }

  for (int j = 0; j < 5; j ++) {
    Balloon temp = new Balloon();
    enemies[0].add(temp);

    Asteroid temp2 = new Asteroid();
    enemies[1].add(temp2);
  }
}

void setup2() {//RESTART
  player.fuel = 1000;
  score = 0;
  
  for (int i = 0; i < enemies.length; i ++) {
    enemies[i] = new ArrayList<Enemy>();
  }

  for (int j = 0; j < 5; j ++) {
    Balloon temp = new Balloon();
    enemies[0].add(temp);

    Asteroid temp2 = new Asteroid();
    enemies[0].add(temp2);
  }

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
    image(meteor, XSIZE/2, YSIZE/3);
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
    text("UPGRADES", XSIZE/2, YSIZE/15);
    textSize(XSIZE/20);
    textAlign(LEFT, CENTER);
    text("Best Distance:" + highscore/10. + "km", YSIZE/30, YSIZE/11 + YSIZE/20);
    text("Your Distance:" + score/10. + "km", YSIZE/30, YSIZE/11 + YSIZE/12);
    imageMode(CENTER);
    image(coin, YSIZE/22, YSIZE/7 + YSIZE/11);
    text(":" + coins, YSIZE/17, YSIZE/7 + YSIZE*2/20 - 5);
    textSize(XSIZE/10);
    textAlign(CENTER, CENTER);
    stroke(255);
    text("RETRY", XSIZE/2, YSIZE*5/6);
    if (mousePressed) {
      if (mouseY > YSIZE*2/3) {
        setup2();
      }
    }
    break;
  }
}

void buildBackground() {
  background(#B2F0FF);
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

void detect() {
  if (mouseX < XSIZE/2) {
    player.dir = 2;
    player.left();
  } else {  
    player.dir = 1;
    player.right();
  }
}

void decFuel() {
  player.fuel -= decFuel;
  if (frameCount%2 == 0)
    player.fuel -= 1;
}

void actAll() {
  for (int i = 0; i < enemies.length; i++)
    for (Enemy e : enemies[i])
      e.act();
}

void checkHits() {
  if(!player.hit){
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
  textAlign(LEFT);
  text("Fuel:" + player.fuel/10. + "%", XSIZE/30, YSIZE/20);
  textAlign(RIGHT);
  text("Height:" + score/10. + "km", XSIZE*29/30, YSIZE/20);
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

void writeFile(){
  output = createWriter("data.txt");
  output.println(coins);
  output.println(highscore);
  output.flush();
  output.close();
}

String[] readFile() throws FileNotFoundException {
  BufferedReader reader = createReader("data.txt");
  String[] ret = new String[2];
  try{
    ret[0] = reader.readLine();
    ret[1] = reader.readLine();
    reader.close();
  }
  catch(Exception e){}
  return ret;
}
