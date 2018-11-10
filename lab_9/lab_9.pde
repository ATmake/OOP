import processing.video.*;
Capture video;

PImage cuteRobot;
void setup() {
  size(640, 480);
  //warm up stuff
  //cuteRobot = loadImage("cuterobot.jpg");
  //cuteRobot.resize(width, height);
  //imageMode(CENTER);
  video = new Capture(this, width, height);
  video.start();
}

void draw() {
  if (video.available()) {
    video.read();
    video.loadPixels();
    for (int i = 0; i < width; i++) {
      for (int j = 0; j < height; j++) {
        int idx = j*video.width + i;
        color px = video.pixels[idx];
        float r = red(px); 
        float g = green(px);
        float b = blue(px);
        if (key =='i') { //invert image colors
          px = color(255-r, 255-g, 255-b);
        } else if (key == 'r') { //tints red
          px = color(r, 0, 0);
        } else if (key == 'b') { //brightens image
          px = color(r+150, g+150, b+150);
        } else if (key == 'd') { //dims immage
          px = color(r-150, g-150, b-150);
        } else if (key == 'w') { //switches the rgb chanels
          float newr = b;
          float newg = r;
          float newb = g;
          px = color(newr, newg, newb);
        } else if (key == 'g') { //changes to grayscale
          g = ((r+b+g)/3)-50;
          px = color(g);
        } else if (key == 't') { //grayscake using conditional
          if ((r+g+b)/3 > 255/2) {
            px = color(255);
          } else if ((r+g+b)/3 < 255/2) {
            px = color(0);
          }
        } else if (key == 's') {
          float sepiaAmount = (r+g+b)/6;
          float newr = r + (2*sepiaAmount);
          float newg = g + sepiaAmount;
          float newb = b - sepiaAmount;
          px = color(newr, newg, newb);
        } else if (key == 'f') {
          float sum = r+g+b;
          if (sum >= 0 && sum <= 181) {
            px = color(0, 51, 76);
          } else if (sum >= 182 && sum <= 363) {
            px = color(217, 26, 33);
          } else if (sum >= 364 && sum <= 545) {
            px = color(112, 150, 158);
          } else if (sum >= 546 && sum <= 765) {
            px = color(252, 227, 166);
          }
        } else if(key == 'y'){
          
        }
        video.pixels[idx] = px;
      }
    }
    video.updatePixels();
    image(video, 0, 0);
  }
}

void warmUp() {
  tint(150, 0, 0);
  image(cuteRobot, width/2, height/2);
}
