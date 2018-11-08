// Learning Processing
// Daniel Shiffman
// http://www.learningprocessing.com

// Example 10-10: The raindrop catching game

score myScore;
Catcher catcher;    // One catcher object
Timer timer;        // One timer object
Drop[] drops;       // An array of drop objects
int totalDrops = 0; // totalDrops
PImage bucket;
PImage background;
PImage raindrop;
int catcherSize = 32;
int gameState;

void setup() {
  size(750, 500);
  myScore = new score();
  catcher = new Catcher(catcherSize); // Create the catcher with a radius of 32
  drops = new Drop[1000];    // Create 1000 spots in the array
  timer = new Timer(300);    // Create a timer that goes off every 300 milliseconds
  timer.start();             // Starting the timer
  imageMode(CENTER);
  bucket = loadImage("bucket.png");
  background = loadImage("background.jpg");
  raindrop = loadImage("raindrop.png");
  bucket.resize(catcherSize*2, catcherSize*2);
  background.resize(width, height);
  raindrop.resize(40, 90);
  gameState = 0;
}


void draw() {
  if (gameState == 0) {
    credits();
  } else if (gameState == 1) {
    background(background);
    image(bucket, mouseX, mouseY);
    catcher.setLocation(mouseX, mouseY); 
    catcher.display(); 
    catcherImgPosSet();
    checkTimer();
    displayDrops();
    displayScore();
    scoreSub();
    loseGame();
    winGame();
  } else if (gameState == 2) {
    lose();
  } else if (gameState == 3) {
    win();
  }
}

//opening credits
void credits() {
  background(0);
  textSize(32);
  text("Origional Game by: Daniel Shiffman", 100, height/2);
  text("Modified Game by: Ansel Tessier", 120, height/2 + 50);
  if(keyPressed == true){
    gameState = 1;
  }
}
//lose Screne
void lose() {
  background(0);
  text("You Lose, Better luck next time!", 150, height/2);
}

//wins Screne
void win() {
  background(0);
  text("You Win, Congrats!", 200, height/2);
}

//game loose condition
void loseGame() {
  if (myScore.scoreValue < 0) {
    gameState = 2;
  }
}

//game loose condition
void winGame() {
  if (myScore.scoreValue >= 15) {
    gameState = 3;
  }
}

//sets the catcher image location
void catcherImgPosSet() {
  image(bucket, mouseX, mouseY);
  catcher.setLocation(mouseX, mouseY); 
  // Display the catcher
  catcher.display();
}
//checks the timer, and adds drops
void checkTimer() {
  if (timer.isFinished()) {
    // Deal with raindrops
    // Initialize one drop
    drops[totalDrops] = new Drop();
    // Increment totalDrops
    totalDrops ++ ;
    // If we hit the end of the array
    if (totalDrops >= drops.length) {
      totalDrops = 0; // Start over
    }
    timer.start();
  }
}
// Move and display all drops
void displayDrops() {
  for (int i = 0; i < totalDrops; i++ ) {
    drops[i].move();
    image(raindrop, drops[i].x, drops[i].y);
    if (catcher.intersect(drops[i])) {
      drops[i].caught();
      myScore.addToScore();
    }
  }
}

//prints the score to the sketch and consol
void displayScore() {
  String sc = str(myScore.getScore());
  textSize(30);
  fill(100);
  text("Score:", 10, 100);
  text(sc, 100, 100);
  println(sc);
}
//subtracting from score if a drop falls to the botom 
void scoreSub() {
  for (int i = 0; i < totalDrops; i++ ) {
    if (drops[i].reachedBottom() == true) {
      myScore.subtractFromScore();
      drops[i].y = -1000;
    }
  }
}
