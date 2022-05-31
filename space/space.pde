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
float scaleFac = 2000000;

float GConstant = 6.6743e-11;


void setup() {
  textSize(20);
  size(1000,800);

  planetImg = loadImage("planet.png");
  planetImg.resize(100,100);
  ship = loadImage("rocket.png");
  ship.resize(50,50);

  background(0);
  planetImg = loadImage("planet.png");
  goalImg = loadImage("goal.png");
  planetImg.resize(100,100);
  goalImg.resize(170,96);
  
  ship = loadImage("rocket.png");
  ship.resize(30,40);
  pArray = new ArrayList<planets>();
}

float distanceCalc(planets a, float x, float y){
  float xCor = a.getX();
  float yCor = a.getY();
  float xDist = xCor - x + a.getRadius();
  float yDist = yCor - y + a.getRadius();
  return (float)Math.sqrt(xDist * xDist + yDist * yDist);
}

float[] forceCalc(planets a, float x, float y){
  float distance = distanceCalc(a,x,y);
  float xDist = a.getX() - x + a.getRadius();  
  float yDist = a.getY() - y + a.getRadius();  
  float force = a.getMass() * GConstant / (float)Math.pow(distance, 2);
  float[] finale = {force * Math.abs(xDist) / distance, force * Math.abs(yDist) / distance};
  if(a.getX() + a.getRadius() < x){
    finale[0] *= -1;
  }
  if(a.getY() + a.getRadius() < y){
    finale[1] *= -1;
  }
  //LOOK AT THIS CODE CLOSER AT HOME - MAKE SURE THIS FUNCTIONS
  return finale;
}

void fieldDrawer(){
  float[] maxForce = {0,0};
  for(int i = 0; i < 1000; i +=4){
    for(int j = 0; j < 800; j +=4){
      maxForce[0] = 0;
      maxForce[1] = 0;
      for (planets k: pArray){
        maxForce[0] += forceCalc(k, i, j)[0];
        maxForce[1] += forceCalc(k, i, j)[1];
      }
      float bright = 200 * (float)Math.sqrt(Math.pow(maxForce[0],2) + Math.pow(maxForce[1],2)) / 60000000;
      color c = color(bright,bright,bright);
      stroke(c);
      fill(c);
      square(i,j,4);
    }
  }
}



void draw() {
  background(0);
  fieldDrawer();
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

    text("Mass: " + x.getMass(), x.getX(),x.getY());
  }
  
  //Rocket stuff
  if (rocketship != null){
    //Loads the rocket
    image(rocketship.getImage(),rocketship.getX(),rocketship.getY());
    //Deals with the change in position
    rocketship.xPosition = rocketship.xPosition + rocketship.getXVelocity();
    rocketship.yPosition = rocketship.yPosition + rocketship.getYVelocity();
    print(rocketship.getX());
    print(rocketship.getY());
    //Deals with the change in velocity due to gravitational acceleration at each moment
    for(planets x: pArray){
      float distance = distanceCalc(x,rocketship.getX(),rocketship.getY());
      float xDist = rocketship.getX() - x.getX() + x.getRadius();  
      float yDist = rocketship.getY() - x.getY() + x.getRadius();  
      float acceleration = x.getMass() * GConstant / (float)Math.pow(distance, 2);
      
      float xacceleration = acceleration*xDist/distance/scaleFac;
      float yacceleration = acceleration*yDist/distance/scaleFac;
      
      rocketship.xVelocity = rocketship.xVelocity-xacceleration;
      rocketship.yVelocity = rocketship.yVelocity-yacceleration;
      
    }
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
