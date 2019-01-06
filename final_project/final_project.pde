//declaring objects and variables
tanks tank1;
tanks tank2;
gameMap background;
int gameState;
PImage loadScreen;
boolean winner;

void setup() {
  gameState = 0;
  size(1000, 1000);
  rectMode(CENTER);
  reset();
  tank1.display();
  tank2.display();
}


void draw() {
  credits(); // openign screen
  if (gameState == 1) { //gameState 1 runs the game itself
    background.backgroundRedraw(); 
    if (tank1.fireState == 1) {
      t1endGame();
    }
    if (tank2.fireState == 1) {
      t2endGame();
    }
    tank1.move();
    tank2.move();
    tank1.fire();
    tank2.fire();
    tank1.display();
    tank2.display();
  }
}

//implementing boolean functions for fireing and movement 
void keyPressed() {
  setMove(key, true);
  setMove2(key, true);
}

void keyReleased() {
  setMove(key, false);
}
//boolean function to read key presses and return the method assicoated with each key
boolean setMove(int k, boolean b) {
  switch(k) {
  case'w':
    return tank1.forward = b;
  case 's':
    return tank1.backward = b;
  case 'a' :
    return tank1.turnLeft = b;
  case 'd':
    return tank1.turnRight = b;
  case'i':
    return tank2.forward = b;
  case 'k':
    return tank2.backward = b;
  case 'j' :
    return tank2.turnLeft = b;
  case 'l':
    return tank2.turnRight = b;
  case ' ':
    reset();
  default:
    return b;
  }
}

//boolean function to fire when the proper keys are pressed
boolean setMove2(int k, boolean b) {
  switch(k) {
  case 'e':
    tank1.reload();
    tank1.fireState = 1;
    return tank1.fireing = b;
  case 'o':
    tank2.reload();
    tank2.fireState = 1;
    return tank2.fireing = b;
  default:
    return b;
  }
}

//restet function sets up the game, and resets for each new round, redraws the map and resets the tanks 
void reset() { 
  background = new gameMap();
  tank1 = new tanks(1);
  tank2 = new tanks(2);
  tank1.xPos = 50;
  tank2.xPos = width - 50;
  tank1.yPos = height/2;
  tank2.yPos = height/2;
  if (gameState > 1) {
    gameState = 1;
  }
}

//looks to see if tank 2 has been hit
void t1endGame() {
  int hitBox = 15;
  if (tank1.shot.xPos <= (tank2.xPos+hitBox) && tank1.shot.xPos >= (tank2.xPos-hitBox) && tank1.shot.yPos <= (tank2.yPos+hitBox) && tank1.shot.yPos >= (tank2.yPos-hitBox)) {
    tank2.isAlive = false;
    gameState++;
    winner = false;
  }
}

//looks to see if tank 1 has been hit
void t2endGame() {
  int hitBox = 15;
  if (tank2.shot.xPos <= (tank1.xPos+hitBox) && tank2.shot.xPos >= (tank1.xPos-hitBox) && tank2.shot.yPos <= (tank1.yPos+hitBox) && tank2.shot.yPos >= (tank1.yPos-hitBox)) {
    tank1.isAlive = false;
    gameState++;
    winner = true;
  }
}

//opeing screen to be displayed at the begining of the game
void credits() {
  if (gameState == 0) {
    imageMode(CENTER);
    loadScreen = loadImage("loadscreen.jpg");
    loadScreen.resize(width, height);
    image(loadScreen, width/2, height/2);
    textSize(32);
    fill(30, 250, 30);
    text("PRESS SPACE TO START", width/2 - 150, height*3/4);
    textSize(20);
    text("player 1: Move with WASD", width*1/4 -200, height*3/4 +100);
    text("Fire with E", width*1/4 -200, height*3/4 +140);
    text("player 2: Move with IJKL", width*3/4, height*3/4 +100);
    text("Fire with O", width*3/4, height*3/4 +140);
    if (key ==' ') {
      gameState++;
    }
  }
}

// end screen to be displayed when a round is over
void endScreen() {
  if (gameState > 1) {
    textSize(20);
    background(0);
    text("PRESS SPACE TO RESTART", width/2 - 150, height*3/4);
    if (winner) {
      textSize(32);
      fill(255, 0, 0);
      text("PLAYER 2 WINS!", width/2 - 150, height*1/4);
    } else if (!winner) {
      textSize(32);
      fill(0, 0, 255);
      text("PLAYER 1 WINS!", width/2 - 150, height*1/4);
    }
  }
}
