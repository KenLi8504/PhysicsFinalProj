PImage planet;
PImage ship;
PImage goal;
boolean heldDown;


void setup() {
  size(1000,800);
  loadbg();
  planet = loadImage("planet.png");
  planet.resize(100,100);
}

void draw() {
  placePlanet();
}

void loadbg(){
  background(0);
}
void placePlanet(){
  if(mousePressed && !heldDown){
    image(planet,mouseX,mouseY);
    print("placed planet\n");
    heldDown = true;
  }else if (!mousePressed){
    heldDown = false;
  }
}
