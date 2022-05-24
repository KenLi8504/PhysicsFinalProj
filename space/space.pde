PImage img;

void setup() {
  size(1000,800);
  loadbg();
}

void draw() {
  placePlanet();
}

void loadbg(){
  background(0);
}
void placePlanet(){
  if(mousePressed && mouseButton == LEFT){
    img = loadImage("planet.jpg");
    img.resize(100,100);
    image(img,mouseX,mouseY);
    print("placed planet\n");
  }
  if(mousePressed && mouseButton == RIGHT){
    img = loadImage("rocket.png");
    tint(255,222);
    img.resize(30,40);
    image(img,mouseX,mouseY);
    print("placed rocket\n");
  }
}
