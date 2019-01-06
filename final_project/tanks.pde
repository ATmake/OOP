class tanks {
  //atributes
  float xPos;
  float yPos;
  int size; 
  float speed;
  float heading;
  boolean forward, backward, turnRight, turnLeft;
  int player;
  color playerColor;
  float tankWidth, tankHeight;
  boolean fireing;
  boolean isAlive;
  int fireState;
  PImage explosion;
  projectile shot;


  //constructor
  tanks(int p) {
    isAlive = true;
    tankWidth = 25;
    tankHeight = 20;
    player = p;
    explosion = loadImage("explosion.png");
    imageMode(CENTER);
    explosion.resize(int(tankWidth)*5, int(tankHeight)*5);
    speed = 1;
    yPos = height/2;
    if (player == 1) {
      xPos = 50;
      playerColor = color(0, 0, 255);
    } else if (player == 2) {
      xPos = width-50;
      playerColor = color(255, 0, 0);
      heading = 180;
    }
    rectMode(CENTER);
    rect(xPos, yPos, 25, 20);
  }
  
  //displayign in a pop matrix, translates to x/y pos, rotates to heading, then displays. 
  void display() {
    fill(playerColor);
    pushMatrix(); 
    translate(constrain(xPos, 0, width), constrain(yPos, 0, height));
    rotate(radians(heading));
    rectMode(CENTER);
    rect(0, 0, tankWidth, tankHeight);
    rect(10, 0, 30, 5);
    popMatrix();
    if (!isAlive) {
      image(explosion, xPos-50, yPos-50);
      //delay(1000);
      endScreen();
    }
  }
  
  //movement function
  void move() {
    if (isAlive) {
      if (forward) {
        //moves in the direction of the heading
        xPos += 2*cos(radians(heading));
        yPos += 2*sin(radians(heading));
        //checking to see if it is running into any obsticals
        for (int i = 0; i < background.numbOfSquares; i++) { 
          if (background.X[i] < this.xPos && this.xPos < (background.X[i] + background.wid[i]) && background.Y[i] < this.yPos && this.yPos < (background.Y[i] + background.hgt[i])) {
            xPos -= 2*cos(radians(heading));
            yPos -= 2*sin(radians(heading));
          }
        }
      }
      if (backward) {
        xPos -= 2*cos(radians(heading));
        yPos -= 2*sin(radians(heading));
        for (int i = 0; i < background.numbOfSquares; i++) { 
          if (background.X[i] < this.xPos && this.xPos < (background.X[i] + background.wid[i]) && background.Y[i] < this.yPos && this.yPos < (background.Y[i] + background.hgt[i])) {
            xPos += 2*cos(radians(heading));
            yPos += 2*sin(radians(heading));
          }
        }
      }
      if (turnRight) {
        heading = heading +speed;
      }
      if (turnLeft) {
        heading = heading -speed;
      }
    }
  }
  
  //fireing methods
  //creates a new projectile object
  void reload() { 
    shot = new projectile(this);
  }
  //moves and displays the object that was just created if the tank is alive and fireing
  void fire() {
    if (isAlive) {
      if (fireState == 1) {
        shot.proUpdate();
        shot.proDisplay();
      }
    }
  }
} 
