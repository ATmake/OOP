 class projectile {
  float xPos, yPos, vol, heading;
  
  //takes an argument of a tank to get the pos and heading of that thank when the tank fires
  projectile(tanks t_) {
    vol = 20;
    xPos = t_.xPos;
    yPos = t_.yPos;
    heading = t_.heading;
  }
  //projectile movement update 
  void proUpdate() {
    xPos += vol*cos(radians(heading));
    yPos += vol*sin(radians(heading));
    for (int i = 0; i < background.numbOfSquares; i++) { 
      if (background.X[i] < this.xPos && this.xPos < (background.X[i] + background.wid[i]) && 
      background.Y[i] < this.yPos && this.yPos < (background.Y[i] + background.hgt[i])) {
        xPos -= vol*cos(radians(heading));
        yPos -= vol*sin(radians(heading));
      }
    }
  }
  //projectile display
  void proDisplay() {
    fill(0, 255, 0);
    ellipse(xPos, yPos, 10, 10);
  }
}
