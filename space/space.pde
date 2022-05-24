PImage planetimg;
PImage ship;
PImage goal;
boolean heldDown;
ArrayList<planets> pArray;
planets current;

void setup() {
  size(1000,800);
  loadbg();
  planetimg = loadImage("planet.png");
  planetimg.resize(100,100);
  pArray = new ArrayList<planets>();
}

void draw() {
  loadbg();
  placePlanet();
  for(planets x: pArray){
    image(x.getImage(),x.getX(),x.getY());
  }
  if(heldDown){
    if(current != null){
      current.updateCoordinate(mouseX,mouseY);
    } 
  }else{
    current = null;
  }
}

void loadbg(){
  background(0);
}

boolean hoverCheck(){
  boolean x = false;
  current = null;
  for (planets i: pArray){
    if (i.held(mouseX, mouseY)){
      current = i;
      x = true;
    }
  }
  return x;
}

void placePlanet(){
  if(mousePressed && !heldDown){
    if(!hoverCheck()){
      pArray.add(new planets(planetimg, mouseX, mouseY));
      current = pArray.get(pArray.size()-1);
      print("placed planet\n");
    }
    heldDown = true;
  }else if (!mousePressed){
    heldDown = false;
  }
}
