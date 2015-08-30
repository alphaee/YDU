//Young, Dan, Franklin
//Young Ditched Us
import java.io.*;

int XSIZE, YSIZE;

int state;

Ship player;

ArrayList<Enemy>[] enemies; //0-balloon1, 1-Asteroid

int coins;
int score;
int highscore;
int sLevel;
int hLevel;

int startMillis;

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
PImage bird1;
PImage balloon0, balloon1;
PImage asteroid1, asteroid2;
PImage meteor;
PImage debris;

PFont font;

int decFuel;

int invin;

boolean released;

boolean start;

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

  enemies = (ArrayList<Enemy>[])new ArrayList[3];

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

  balloon0 = loadImage("HotAirBalloon3.png");
  balloon0.resize(YSIZE/6, YSIZE/6);

  balloon1 = loadImage("HotAirBalloon2.png");
  balloon1.resize(YSIZE/6, YSIZE/6);

  asteroid1 = loadImage("Asteroid1.png");
  asteroid1.resize(YSIZE/8, YSIZE/8);

  meteor = loadImage("Meteor.png");
  meteor.resize(YSIZE/2, YSIZE/2);

  debris = loadImage("satellite-2.png");
  debris.resize(YSIZE/8, YSIZE/8);

  for (int i = 0; i < enemies.length; i ++) {
    enemies[i] = new ArrayList<Enemy>();
  }

  if (sLevel == 0) {
    rocket = rocket0;
    rocketL = rocket0L;
    rocketR = rocket0R;
  } else if (sLevel == 1) {
    rocket = rocket1;
    rocketL = rocket1L;
    rocketR = rocket1R;
  } else {
    rocket = rocket2;
    rocketL = rocket2L;
    rocketR = rocket2R;
  }

  // for (int j = 0; j < 5; j ++) {
  //   balloon1 temp = new balloon1();
  //   enemies[0].add(temp);

  //   Asteroid temp2 = new Asteroid();
  //   enemies[1].add(temp2);
  // }
  start = true;
  player.hit = false;
  state = 0;
}

void setup2() {//RESTART
  // player.fuel = 1000;
  player = new Ship();
  score = 0;

  for (int i = 0; i < enemies.length; i ++) {
    enemies[i] = new ArrayList<Enemy>();
  }

  // for (int j = 0; j < 5; j ++) {
  //   balloon1 temp = new balloon1();
  //   enemies[0].add(temp);

  //   Asteroid temp2 = new Asteroid();
  //   enemies[0].add(temp2);
  // }
  
  if (sLevel == 0) {
    rocket = rocket0;
    rocketL = rocket0L;
    rocketR = rocket0R;
  } else if (sLevel == 1) {
    rocket = rocket1;
    rocketL = rocket1L;
    rocketR = rocket1R;
  } else {
    rocket = rocket2;
    rocketL = rocket2L;
    rocketR = rocket2R;
  }

  state = 9;
  player.hit = false;
  start = true;
  startMillis = millis();
}

void draw() {
  switch(state) {
  case 00: //homescreen
    background(0);
    fill(255);
    textSize(XSIZE/9);
    textAlign(CENTER, CENTER);
    text("TO INFINITY...", XSIZE/2, YSIZE/10); 
    textSize(XSIZE/7);
    text("LAUNCH!", XSIZE/2, YSIZE*5/6);
    imageMode(CENTER);
    textSize(YSIZE/40);
    text("YK, DK, FW", XSIZE/6, YSIZE * 29/30);
    image(meteor, XSIZE/2, YSIZE*7/18);
    if (mousePressed) {
      startMillis = millis();
      state = 9;
    }
    break;
    
  case 9: //pre-game sequence
    buildBackground();
    player.display();
    
    fill(#787C6A);
    noStroke();
    rect(0,YSIZE*2/3,XSIZE/3,YSIZE*2/3 - YSIZE/23);
    
    fill(#3CDB42);
    rect(0,YSIZE*22/23,XSIZE,YSIZE/20);
    
    PImage tower = loadImage("tower.png");
    tower.resize(XSIZE/4 + XSIZE/9,YSIZE/4 + YSIZE/20);
    imageMode(CENTER);
    image(tower,XSIZE/2 - XSIZE/10,YSIZE*8/9 - YSIZE/25);
    
    PImage logo = loadImage("logo.png");
    logo.resize(XSIZE/4,XSIZE/4);
    image(logo, XSIZE/6, YSIZE*3/4 + YSIZE/20);
    
    player.yCor = YSIZE - YSIZE*(millis()-startMillis)/1700;
    if(millis() - startMillis > 2050){
      startMillis = millis();
      player.yCor = YSIZE*4/5;
      state = 10;
      if(sLevel == 0)
        score = 30;
      else if(sLevel == 1)
        score = 50;
      else{
        score = 70;
      }
    }
    break;

  case 10: //main game
    buildBackground();

    decFuel = 0;

    if (player.hit && invin < millis())
      player.hit = false;

    player.display();  

    stats();

    if (start) {
      countdown(startMillis);
    } else {
      if (millis() - startMillis < 4500) {
        fill(180);
        textAlign(CENTER, CENTER);
        textSize(displayHeight/9);
        text("GO!", XSIZE/2, YSIZE/2-displayHeight/6);
      }

      if (mousePressed) {
        detect();
      } else {
        player.dir = 0;
      }

      spawnEnemies();

      actAll();

      checkHits();

      decFuel();

      enemyDeath();

      checkScore();
      checkDeath();
    }
    break;

  case 20: //upgrade screen
    fill(255);
    background(0);
    textSize(XSIZE/9);
    textAlign(CENTER, CENTER);
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
    text("RELAUNCH", XSIZE/2, YSIZE*6/7 - YSIZE/30);

    textSize(XSIZE/20);

    PImage progress;
    textAlign(LEFT, CENTER);
    if (sLevel == 0) {
      text("Thruster Upgrade: 1000", YSIZE/30, YSIZE/4 + YSIZE/30);
      textAlign(RIGHT, CENTER);
      if (coins >= 1000)
        text("BUY", XSIZE - XSIZE/10, YSIZE/4 + YSIZE/12);
      progress = loadImage("progress-bar-1.png");
    } else if (sLevel == 1) {
      text("Thruster Upgrade: 2500", YSIZE/30, YSIZE/4 + YSIZE/30);
      textAlign(RIGHT, CENTER);
      if (coins >= 2000)
        text("BUY", XSIZE - XSIZE/10, YSIZE/4 + YSIZE/12);
      progress = loadImage("progress-bar-2.png");
    } else {
      text("Thruster Upgrade: ", YSIZE/30, YSIZE/4 + YSIZE/30);
      textAlign(RIGHT, CENTER);
      text("SOLD OUT", XSIZE - XSIZE/20, YSIZE/4 + YSIZE/12);
      progress = loadImage("progress-bar-3.png");
    }
    progress.resize(XSIZE*3/5, YSIZE/5);

    PImage hull;
    textAlign(LEFT, CENTER);
    if (hLevel == 0) {
      text("Hull Upgrade: 500", YSIZE/30, YSIZE/4 + YSIZE/6 + YSIZE/10);
      textAlign(RIGHT, CENTER);
      if (coins >= 500)
        text("BUY", XSIZE - XSIZE/10, YSIZE/4 + YSIZE/6 + YSIZE/10 + YSIZE/15);
      hull = loadImage("hull-bar-1.png");
    } else if (hLevel == 1) {
      text("Hull Upgrade: 1250", YSIZE/30, YSIZE/4 + YSIZE/6 + YSIZE/10);
      textAlign(RIGHT, CENTER);
      if (coins >= 1250)
        text("BUY", XSIZE - XSIZE/10, YSIZE/4 + YSIZE/6 + YSIZE/10 + YSIZE/15);
      hull = loadImage("hull-bar-2.png");
    } else if (hLevel == 2) {
      text("Hull Upgrade: 2000", YSIZE/30, YSIZE/4 + YSIZE/6 + YSIZE/10);
      textAlign(RIGHT, CENTER);
      if (coins >= 2000)
        text("BUY", XSIZE - XSIZE/10, YSIZE/4 + YSIZE/6 + YSIZE/10 + YSIZE/15);
      hull = loadImage("hull-bar-3.png");
    } else if (hLevel == 3) {
      text("Hull Upgrade: 2750", YSIZE/30, YSIZE/4 + YSIZE/6 + YSIZE/10);
      textAlign(RIGHT, CENTER);
      if (coins >= 2750)
        text("BUY", XSIZE - XSIZE/10, YSIZE/4 + YSIZE/6 + YSIZE/10 + YSIZE/15);
      hull = loadImage("hull-bar-4.png");
    } else {
      text("Hull Upgrade: ", YSIZE/30, YSIZE/4 + YSIZE/6 + YSIZE/10);
      textAlign(RIGHT, CENTER);
      text("SOLD OUT", XSIZE - XSIZE/20, YSIZE/4 + YSIZE/6 + YSIZE/10 + YSIZE/15);
      hull = loadImage("hull-bar-5.png");
    }
    hull.resize(XSIZE*3/5, YSIZE/5);

    imageMode(CORNER);
    image(progress, YSIZE/30, YSIZE/4);
    image(hull, YSIZE/30, YSIZE/3 + YSIZE/10 + YSIZE/25);
    if (released&&mousePressed) {
      writeFile();
      if (mouseY > YSIZE*2/3 + YSIZE/20) {
        setup2();
      } else if (mouseY > YSIZE/4 + YSIZE/5 && hLevel < 4 && coins >= (hLevel*750 + 500)) {
        coins -= hLevel*750 + 500;
        hLevel++;
      } else if (mouseY > YSIZE/4 && sLevel<2 && coins >= (1000 + sLevel*1500)) {
        coins -= 1000 + sLevel*1500;
        sLevel++;
      }
      released = false;
    }

    break;
  }
}

void countdown(int t) {
  fill(180);
  textAlign(CENTER, CENTER);
  textSize(displayHeight/9);
  if (millis() - t < 1500)
    text("3", XSIZE/2, YSIZE/2-displayHeight/6);
  else if (millis() - t < 2500)
    text("2", XSIZE/2, YSIZE/2-displayHeight/6);
  else if (millis() - t < 3500)
    text("1", XSIZE/2, YSIZE/2-displayHeight/6);
  else
    start = false;
}

void buildBackground() {
  if (score < 500) {
    background(178, 240-score*120/1000, 255);
  } else if (score < 750) {
    background(178+(score-500)*178/1000, 180-(score-500)*120/1000, 255);
  }
  else{
    background(222.5-(score-750)*222.5/250, 150-(score-750)*150/250,255-(score-750)*255/250);
  }
  // setGradient(0, 0, XSIZE,1000, 0, #B2F0FF);
  image(cloud, XSIZE/6, YSIZE/8);
  image(cloud, XSIZE/4, YSIZE/6);
  image(cloud, XSIZE/2, YSIZE/3);
  image(cloud, XSIZE*2/3, YSIZE/4);

  image(bird1, XSIZE/3, YSIZE/2);
  image(bird1, XSIZE/3 + XSIZE/25, YSIZE/2 - 20);
  image(bird1, XSIZE/3 + XSIZE*2/25, YSIZE/2 - 40);
  image(bird1, XSIZE/3 - XSIZE/25, YSIZE/2 - 20);
  image(bird1, XSIZE*4/5, YSIZE*2/5);
}

// void setGradient(int x, int y, float w, float h, color c1, color c2) {
//   noFill();
//   for (int i = y; i <= y+h; i++) {
//     float inter = map(i, y, y+h, 0, 1);
//     color c = lerpColor(c1, c2, inter);
//     stroke(c);
//     line(x, i, x+w, i);
//   }
// }

void keyPressed() {
  if (keyCode == RIGHT)
    player.right();
  if (keyCode == LEFT)
    player.left();
}

void spawnEnemies() {
  if (frameCount%3 == 0) {
    if (0 <= score && score <= 400) {
      if (random(120) + score/100 > 110) {
        Balloon temp = new Balloon();
        enemies[0].add(temp);
      }
    }
    if (300 <= score && score <= 800) {
      if (random(124) + score/100> 115) {
        Asteroid temp = new Asteroid();
        enemies[0].add(temp);
      }
    }
    if (100 <= score && score <= 1000) {
      if (random(110) + score/100> 110) {
        Debris temp = new Debris();
        enemies[2].add(temp);
      }
    }
  }
}

void mousePressed() {
  if (state==20)
    released = true;
}

void detect() {
  if (abs(mouseX - (player.xCor + YSIZE/8)) > 5) {
    if (mouseX < player.xCor + YSIZE/8) {
      player.dir = 2;
      player.left();
    } else {  
      player.dir = 1;
      player.right();
    }
  }
}     

void decFuel() {
  player.fuel -= decFuel;
  if (frameCount%2 == 0 && random(10) < (8 - 0.5*sLevel))
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
          invin = millis() + 200;
          player.hit = true;
        }
  }
}

void checkScore() {
  if (frameCount%4 == 0)
    score++;
  else if(frameCount % 2 == 0 && random(10) < 1 + 3*sLevel){
    score ++;
  }
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

void enemyDeath() {
  for (int i = 0; i < enemies.length; i++)
    for (int k = 0; k < enemies[i].size (); k++)
      if (!enemies[i].get(k).inBounds()) {
        enemies[i].remove(k);
      }
}

void stats() {
  textSize(XSIZE/20);
  if (score < 750){
    fill(50);
  }
  else{
    fill(50 + (score-750)*205/255);
  }
  textAlign(RIGHT);
  text("Height:" + score/10. + "km", XSIZE*29/30, YSIZE/20);
  if (player.hit || player.fuel/10. < 10)
    fill(#EA1509);
  textAlign(LEFT);
  text("Fuel:" + player.fuel/10. + "%", XSIZE/30, YSIZE/20);
}

void updateCoins() {
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
