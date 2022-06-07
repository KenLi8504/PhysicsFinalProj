//All necessary PImages
PImage planetImg;
PImage ship;
PImage goal;
PImage goalImg;
PImage winScreen;

projectile rocketship;
ArrayList<planets> pArray;
planets current;
goal target = new goal();

boolean win = false;

boolean heldDown;
boolean shipHeld = false;
boolean goalHeld = false;

float scaleFac = 10000000;
float GConstant = 6.6743e-11;


float[][][] currentForce= new float[250][200][2];
boolean changed = false;

void setup() {
  heldDown = false;
  textSize(20);
  size(1000, 800);
  winScreen = loadImage("amogus.jpg");
  winScreen.resize(1000, 800);
  planetImg = loadImage("planet.png");
  planetImg.resize(100, 100);
  ship = loadImage("rocket.png");
  ship.resize(50, 50);
  background(0);
  goalImg = loadImage("newGoal.png");
  goalImg.resize(100, 100);
  pArray = new ArrayList<planets>();
  fieldDrawer(true);
}

void draw() {
  if (keyPressed && current != null && pArray.contains(current) && key == CODED){
    fieldDrawer(true);
    if(keyCode == UP){
      current.increaseMass();
    }
    if(keyCode == DOWN){
      current.decreaseMass();
    }
    if(keyCode == LEFT){
      current.decreaseRadius();
    }
    if(keyCode == RIGHT){
      current.increaseRadius();
    }
  }
  
  
  //print("cool\n");
  textSize(20);
  background(0);
  
  if (rocketship != null) {
    //print(rocketship.getX()+"\n");
    //print(rocketship.getY()+"\n");
    //print(rocketship.getImage());
    image(rocketship.getImage(),rocketship.getX(),rocketship.getY());
  }
  
  if (heldDown) {
    if (current != null && (current.getX() != mouseX || current.getY() != mouseY)) {
      fieldDrawer(true);
    } else {
      fieldDrawer(false);
    }
  } else {
    fieldDrawer(false);
  }

  placePlanet();
  image(goalImg, target.getX(), target.getY());
  placeInstructions();
  rocketSpawn(rocketship);
  boolean isAlive = checkRocket(rocketship);
  if (!isAlive){
    rocketship = null;
  }
  rocketCalc(rocketship);
  
  for (planets x : pArray) {
    if (current != null && x == current) {
      tint(0, 153, 204);
    } else {
      noTint();
    }
    image(x.getImage(), x.getX()-x.getRadius(), x.getY()-x.getRadius());

    text("Mass: " + x.getMass(), x.getX(), x.getY());
    //print("ok");
  }
  

  noTint();

  if (heldDown && mouseButton == LEFT) {
    if (current != null) {
      current.updateCoordinate(mouseX, mouseY);
    } else if (goalHeld) {
      target.updateCoordinate(mouseX, mouseY);
    }
  }

  if (keyPressed && key == 'k' && current != null && pArray.contains(current)) {
    pArray.remove(pArray.indexOf(current));
    fieldDrawer(true);
  }
  if (keyPressed && key == 'r') {
    pArray.clear();
    win = false;
    target.updateCoordinate(300, 300);
    rocketship = null;
  }
  
  noTint();
  if (rocketship != null) {
    winChecker(target, rocketship);
  }

  if (win) {
    textSize(50);
    image(winScreen, 0, 0);
    fill(255, 255, 255);
    rocketship = null;
    text("You did it!", 400, 400);
  }
}


// check if the rocket is inside the goal
void winChecker(goal a, projectile b) {
  if(Math.pow(a.getX()- b.getX(), 2) + Math.pow(a.getY() - b.getY(), 2) < 5625){
    win = true;
  }else{
    win = false;
  }   
}

void rocketSpawn(projectile rocketship) {
  //Rocket stuff
  if (rocketship != null) {
    //Loads the rocket
    //print("Loaded\n");
    //print(rocketship.getX()+"\n");
    //print(rocketship.getY()+"\n");
    image(rocketship.getImage(), rocketship.getX(), rocketship.getY());
    rocketship.xPosition = rocketship.xPosition + rocketship.getXVelocity();
    rocketship.yPosition = rocketship.yPosition + rocketship.getYVelocity();
  }
}

//print("The X velocity is" + rocketship.getXVelocity() +"\n");
//print("The Y velocity is" + rocketship.getYVelocity() +"\n");

//Deals with the change in velocity due to gravitational acceleration at each moment
void rocketCalc (projectile rocketship) {
  if (rocketship != null) {
    //print("The old X velocity is" + rocketship.getXVelocity() +"\n");
    //print("The old Y velocity is" + rocketship.getYVelocity() +"\n");
    for (planets x : pArray) {      
      float acceleration [] = forceCalc(x, rocketship.getX(), rocketship.getY());
      rocketship.xVelocity = rocketship.xVelocity+(acceleration[0]/scaleFac);
      rocketship.yVelocity = rocketship.yVelocity+(acceleration[1]/scaleFac);
      //print("The new X accel is" + acceleration[0] +"\n");
      //print("The new Y accel is" + acceleration[1] +"\n");
    }
    //print("The new X velocity is" + rocketship.getXVelocity() +"\n");
    //print("The new Y velocity is" + rocketship.getYVelocity() +"\n");
  }
}

boolean checkRocket(projectile ship){
  if (ship != null){
    for (planets p : pArray){
      if (distanceCalc(p,ship.getX(),ship.getY()) <= p.getRadius()){
        print("rocket Killed!\n");
        return false;
      }
    }
    return true;
  }
  return false;
}

boolean hoverCheck() {
  boolean x = false;
  current = null;
  for (planets i : pArray) {
    if (i.held(mouseX, mouseY)) {
      current = i;
      x = true;
    }
  }
  if (target.held(mouseX, mouseY)) {
    current = null;
    goalHeld = true;
    x = true;
  } else {
    goalHeld = false;
  }

  return x;
}

void placeInstructions() {
  fill(color(255, 0, 0));
  text("left click to place planet", 0, 50);
  text("press k to kill selected planet", 0, 75);
  text("press space to start", 0, 100);
  text("press r to restart", 0, 125);
}

void placePlanet() {
  if (mousePressed && mouseButton == LEFT && !heldDown) {
    if (!hoverCheck()) {
      planets Temp = new planets(planetImg, mouseX, mouseY);
      pArray.add(Temp);
      current = Temp;
      fieldDrawer(true);
      print("placed planet\n");
    }
    heldDown = true;
  }
  
  if (mousePressed && mouseButton == RIGHT && !heldDown && rocketship == null) {
    if (!hoverCheck()) {
    rocketship = new projectile(ship, mouseX, mouseY);
    print("placed rocket\n");
    }
    heldDown = true;
  }
  if (!mousePressed) {
    heldDown = false;
  }
}

float distanceCalc(planets a, float x, float y) {
  float xCor = a.getX();
  float yCor = a.getY();
  float xDist = xCor - x;
  float yDist = yCor - y;
  return (float)Math.sqrt(xDist * xDist + yDist * yDist);
}

float[] forceCalc(planets a, float x, float y) {
  float distance = distanceCalc(a, x, y);
  float xDist = a.getX() - x;  
  float yDist = a.getY() - y;  
  float force = a.getMass() * GConstant / (float)Math.pow(distance, 2);
  float[] finale = {force * Math.abs(xDist) / distance, force * Math.abs(yDist) / distance};
  if (a.getX() < x) {
    finale[0] *= -1;
  }
  if (a.getY() < y) {
    finale[1] *= -1;
  }
  //LOOK AT THIS CODE CLOSER AT HOME - MAKE SURE THIS FUNCTIONS
  return finale;
}

void fieldDrawer(boolean changed) {
  float[] maxForce = {0, 0};
  for (int i = 0; i < 1000; i +=4) {
    for (int j = 0; j < 800; j +=4) {
      if (changed || pArray.size() == 0) {
        maxForce[0] = 0;
        maxForce[1] = 0;
        for (planets k : pArray) {
          maxForce[0] += forceCalc(k, i, j)[0];
          maxForce[1] += forceCalc(k, i, j)[1];
          currentForce[i / 4][j / 4][0] = maxForce[0];
          currentForce[i / 4][j / 4][1] = maxForce[1];
        }
      } else {
        maxForce[0] = currentForce[i / 4][j / 4][0];
        maxForce[1] = currentForce[i / 4][j / 4][1];
      }

      float bright = 200 * (float)Math.sqrt(Math.pow(maxForce[0], 2) + Math.pow(maxForce[1], 2)) / 60000000;
      color c = color(bright, bright, bright);
      stroke(c);
      fill(c);
      square(i, j, 4);
    }
  }
}
