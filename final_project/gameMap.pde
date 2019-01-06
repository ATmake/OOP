class gameMap {
  int numbOfSquares = 15;
  PImage ground;
  //arrays to be filled with data wbout the obsticals 
  float[] X = new float[numbOfSquares];
  float[] Y = new float[numbOfSquares];
  float[] wid = new float[numbOfSquares];
  float[] hgt = new float[numbOfSquares];
  //loading the arrays with random data
  gameMap() {
    ground = loadImage("ground.jpg");
    ground.resize(width, height);
    for (int i = 0; i <= numbOfSquares - 1; i++) {
      X[i] = random(75, width);
      Y[i] = random(0, height);
      wid[i] = random(50, 250);
      hgt[i] = random(50, 250);
    }
  }
  //called evey time throught the loop to keep the obsticals displayed
  void backgroundRedraw() {
    noStroke();
    fill(75,50,50);
    imageMode(CORNER);
    image(ground,0,0);
    rectMode(CORNER);
    for (int i = 0; i <= numbOfSquares - 1; i++) {
      rect(X[i], Y[i], wid[i], hgt[i])   ;
    }
  }
}
