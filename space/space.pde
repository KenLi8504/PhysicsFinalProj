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
  if(mousePressed == true){
    img = loadImage("planet.jpg");
    img.resize(100,100);
    image(img,mouseX,mouseY);
    print("placed planet\n");
  }
}
