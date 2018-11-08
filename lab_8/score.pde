class score {

  //atributes
  int scoreValue;

  //constructor
  score() {
    scoreValue = 0;
  }

  //methods

  void addToScore() {
    scoreValue++;
  }
  void subtractFromScore() {
    scoreValue--;
  }

  int getScore() {
    return(scoreValue);
  }
}
