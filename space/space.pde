PImage planetImg;
PImage ship;

projectile rocketship;
PImage goal;
PImage goalImg;

boolean heldDown;
ArrayList<planets> pArray;
planets current;
goal target = new goal();
boolean win = false;
boolean shipHeld = false;
boolean goalHeld = false;



void setup() {
  textSize(20);
  size(1000,800);

  planetimg = loadImage("planet.png");
  planetimg.resize(100,100);
  ship = loadImage("rocket.png");
  ship.resize(30,40);

  background(0);
  planetImg = loadImage("planet.png");
  goalImg = loadImage("goal.png");
  planetImg.resize(100,100);
  goalImg.resize(170,96);
  
  ship = loadImage("rocket.png");
  ship.resize(30,40);
  pArray = new ArrayList<planets>();
}

void draw() {
  background(0);
  placePlanet();
  image(goalImg, target.getX(),target.getY());
  text("left click to place planet", 0,50);
  text("press k to kill selected planet", 0, 75);
  text("press space to start", 0, 100);
  text("press r to restart",0,125);
  
  for(planets x: pArray){
    if(current != null && x == current){
      tint(0, 153, 204);
    }else{
      noTint();
    }
    image(x.getImage(),x.getX(),x.getY());

    text("Mass: " + x.getMass() + "x 10^20 kg", x.getX(),x.getY());
  }
  if (rocketship != null){
    image(rocketship.getImage(),rocketship.getX(),rocketship.getY());
  }
  
  if(heldDown){
    if(current != null){
      current.updateCoordinate(mouseX,mouseY);
    }else if (goalHeld){
      target.updateCoordinate(mouseX,mouseY);
    }
  }
  if(keyPressed && key == 'k' && current != null && pArray.contains(current)){
    pArray.remove(pArray.indexOf(current));
  }
  if(keyPressed && key == 'r'){
    pArray.clear();
    win = false;
    target.updateCoordinate(300,300);
  }
  noTint();
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
  if (target.held(mouseX,mouseY)){
    current = null;
    goalHeld = true;
    x = true;
  }else{
    goalHeld = false;
  }
  
  return x;
}

void placePlanet(){
  
  if(mousePressed && mouseButton == LEFT && !heldDown){
    if(!hoverCheck()){
      pArray.add(new planets(planetImg, mouseX, mouseY));
      current = pArray.get(pArray.size()-1);
      print("placed planet\n");
    }

    heldDown = true;
  }else if (!mousePressed){
    heldDown = false;
  }
  if(mousePressed && mouseButton == RIGHT){
    rocketship = new projectile(ship,mouseX,mouseY);
    print("placed rocket\n");
  }
}
