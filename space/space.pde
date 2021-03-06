//All necessary PImages
PImage ship;
PImage goal;
PImage boom;
PImage goalImg;
PImage winScreen;
PImage velocityVector;
PImage dashline;
ArrayList<PImage> planetImgs;

projectile rocketship;
float initialX;
float initialY;
ArrayList<planets> pArray;
planets current;
goal target = new goal();

boolean win = false;
boolean startGame = false;
boolean fired = false;
float prevVelocity = 0;
float prevAngle = 0;

ArrayList <planets> path;

boolean heldDown;
boolean shipHeld = false;
boolean goalHeld = false;

float scaleFac = 50000000;
float GConstant = 6.6743e-11;


float[][][] currentForce= new float[250][200][2];
boolean changed = false;

void setup() {
  planetImgs = new ArrayList<PImage>();
  heldDown = false;
  textSize(20);
  size(1000, 800);
  winScreen = loadImage("amogus.jpg");
  winScreen.resize(1000, 800);

  ship = loadImage("rocket.png");
  ship.resize(50, 50);
  boom = loadImage("boom.jpg");
  boom.resize(100,100);
  background(0);
  goalImg = loadImage("newGoal.png");
  goalImg.resize(100, 100);
  velocityVector = loadImage("arrow.png");
  velocityVector.resize(60,10);
  dashline = loadImage("dashline.jpg");
  dashline.resize(40,20);
  path = new ArrayList<planets>();
  pArray = new ArrayList<planets>();
  fieldDrawer(true);
}

void draw() {
  textSize(20);
  background(0);
  fieldDrawer(false);
  rocketSpawn(rocketship);
  image(goalImg, target.getX()-50, target.getY()-50);
  for (planets x : pArray) {
    if (current != null && x == current) {
      tint(0, 153, 204);
    } else {
      noTint();
    }
    image(x.getImage(), x.getX()-x.getRadius(), x.getY()-x.getRadius());

    text("Mass: " + x.getMass(), x.getX(), x.getY()-5);
    text("Radius: " + x.getRadius(), x.getX(), x.getY()+15);
  }
  noTint();
  
  if(startGame == false){
    placeInstructions();
    placePlanet();
    if (heldDown) {
      if (current != null && (current.getX() != mouseX || current.getY() != mouseY)) {
        fieldDrawer(true);
       } else {
        fieldDrawer(false);
      }
    }
    
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
    if (heldDown && mouseButton == LEFT) {
      
      placeInstructions();
      noTint();
        rocketSpawn(rocketship);
        noTint();
  image(goalImg, target.getX()-50, target.getY()-50);
      
        for (planets x : pArray) {
    if (current != null && x == current) {
      tint(0, 153, 204);
    } else {
      noTint();
    }
    image(x.getImage(), x.getX()-x.getRadius(), x.getY()-x.getRadius());
    
    fill(0);
    text("Mass: " + x.getMass(), x.getX(), x.getY()-5);
    text("Radius: " + x.getRadius(), x.getX(), x.getY()+15);
  }
  noTint();
      
      if (shipHeld && rocketship != null){
        rocketship.updateCoordinate(mouseX,mouseY);
      } else if (goalHeld) {
        target.updateCoordinate(mouseX, mouseY);
      }else if (current != null) {
        current.updateCoordinate(mouseX, mouseY);
        
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
  
    if (keyPressed && key == ' ' && rocketship != null) {
      startGame = true;
      initialX = rocketship.getX();
      initialY = rocketship.getY();
    }  
  }
  
  
  //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  ///////////////////////////////////////Start of the game//////////////////////////////////////////////////////////////
  //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  
  if (startGame == true){
    placeHowtoPlay();
    boolean isAlive = checkRocket(rocketship);
    if (!isAlive && fired){
      rocketship = new projectile(ship,initialX,initialY,prevAngle,prevVelocity);
      fired = false;
    }
    else{
      if (fired){
        rocketCalc(rocketship);
        createPath(rocketship);
      }
    }
    
    if(path.size() > 0){
    for (planets x : path) {
    image(x.getImage(), x.getX()-x.getRadius(), x.getY()-x.getRadius());
    }
    }
    
    if (rocketship != null && !fired){
      pushMatrix();
      translate(rocketship.getX(),rocketship.getY()-5);
      rotate(radians(rocketship.angle));
      image(velocityVector,0,0);
      popMatrix();
    }
    
    if (rocketship != null && fired){
      pushMatrix();
      translate(rocketship.getX(),rocketship.getY()-5);
      if (rocketship.xVelocity >= 0){
        rotate((atan(rocketship.yVelocity/rocketship.xVelocity)));
        //print(" the degree is " + degrees(atan(rocketship.yVelocity/rocketship.xVelocity)) + "\n");
      }
      else{
        rotate(((atan(rocketship.yVelocity/rocketship.xVelocity) )) + PI );
      }
      image(velocityVector,0,0);
      popMatrix();
    }
    
    if (keyPressed && key == CODED && rocketship != null && !fired){
      if(keyCode == UP){
        rocketship.incVelocity();
      }
      if(keyCode == DOWN){
        rocketship.decVelocity();
      }
      if(keyCode == LEFT){
        rocketship.incAngle();
      }
      if(keyCode == RIGHT){
        rocketship.decAngle();
      }
    }
  
    if (rocketship != null) {
      winChecker(target, rocketship);
    }
  
    if (win) {
      textSize(50);
      image(winScreen, 0, 0);
      fill(255, 255, 255);
      fired = false;
      rocketship = null;
      text("You did it!", 360, 400);
      text("Press t to go back", 290, 450);
        if (keyPressed && key == 't'){
          fired = true;
        }
    }
  
  if (keyPressed && key == 'e') {
    startGame = false;
  }
  
  if (keyPressed && key == 'r') {
    rocketship = new projectile(ship,initialX,initialY,prevAngle,prevVelocity);
    fired = false;
  }
  
  if (keyPressed && key == 'f' && !fired) {
    path.clear();
    prevVelocity = rocketship.totalVelocity;
    prevAngle = rocketship.angle;
    //print("the previous velocity was" + prevVelocity + "\n");
    
    rocketship.xVelocity = rocketship.totalVelocity * cos(radians(rocketship.angle));
    rocketship.yVelocity  = rocketship.totalVelocity * sin(radians(rocketship.angle));
    fired = true;
  }
 }
}


//////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////All the special functions///////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////


void createPath(projectile ship){
    planets Temp = new planets(loadImage("planet.png"), ship.xPosition, ship.yPosition,0);
    path.add(Temp);
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
    image(rocketship.getImage(), rocketship.getX()-25, rocketship.getY()-25);
    rocketship.xPosition = rocketship.xPosition + rocketship.getXVelocity();
    rocketship.yPosition = rocketship.yPosition + rocketship.getYVelocity();
      
    fill(255,0,0);
    text("Total Velocity: " + rocketship.totalVelocity, rocketship.getX(), rocketship.getY()-5);
    text("Angle: " + rocketship.angle%360, rocketship.getX(), rocketship.getY()+15);
    fill(0,0,0);
  }
}

//Deals with the change in velocity due to gravitational acceleration at each moment
void rocketCalc (projectile rocketship) {
  if (rocketship != null) {
    for (planets x : pArray) {      
      float acceleration [] = forceCalc(x, rocketship.getX(), rocketship.getY());
      rocketship.xVelocity = rocketship.xVelocity+(acceleration[0]/scaleFac);
      rocketship.yVelocity = rocketship.yVelocity+(acceleration[1]/scaleFac);
    }
    rocketship.totalVelocity = (float)Math.sqrt(rocketship.xVelocity * rocketship.xVelocity + rocketship.yVelocity * rocketship.yVelocity);
    if (rocketship.xVelocity >= 0){
      rocketship.angle = (degrees(atan(rocketship.yVelocity/rocketship.xVelocity) ));
    }
    else{
      rocketship.angle = degrees((atan(rocketship.yVelocity/rocketship.xVelocity) + PI));
    }
  }
}

boolean checkRocket(projectile ship){
  if (ship != null){
    for (planets p : pArray){
      if (distanceCalc(p,ship.getX(),ship.getY()) <= p.getRadius()){
        return false;
      }
    }
    if (ship.xPosition < 0 || ship.xPosition > 1000 || ship.yPosition < 0 || ship.yPosition > 800){
      return false;
    }
    return true;
  }
  return false;
}

void placeInstructions() {
  fill(color(255, 0, 0));
  text("left click to place a planet", 0, 50);
  text("press k to get rid of the selected planet", 0, 75);
  text("press space to start the simulation", 0, 100);
  text("press r to clear everything and restart", 0, 125);
  text("use arrow keys to adjust the mass & radius of the planets", 0, 150);
}

void placeHowtoPlay() {
  fill(color(255, 0, 0));
  text("press r to end one run and select a new angle/velocity", 0, 100);
  text("press e to end the game and return to the sandbox", 0, 125);
  text("press f to fire the rocket", 0, 75);
  text("Use arrow keys to adjust the angle and velocity", 0, 50);
}

boolean hoverCheck() {
  boolean x = false;
  current = null;
  goalHeld = false;
  shipHeld = false;
  if (current == null && goalHeld == false && shipHeld == false){
  }
  if(rocketship != null){
    if(rocketship.held(mouseX,mouseY)){
      shipHeld = true;
      x = true;
    }
  }
  if (target.held(mouseX, mouseY)) {
    goalHeld = true;
    x = true;
  }
  else if (!shipHeld && !goalHeld){
    for (planets i : pArray) {
      if (i.held(mouseX, mouseY)) {
        current = i;
        x = true;
      }
    }
  }
  return x;
}

void placePlanet() {
  //places a new planet
  if (mousePressed && mouseButton == LEFT && !heldDown) {
    if (!hoverCheck()) {
      planetImgs.add(loadImage("planet.png"));
      planets Temp = new planets(planetImgs.get(planetImgs.size() - 1), mouseX, mouseY);
      pArray.add(Temp);
      current = Temp;
      fieldDrawer(true);
    }
    heldDown = true;
  }
  //places a new rocketship
  if (mousePressed && mouseButton == RIGHT && !heldDown && rocketship == null) {
    if (!hoverCheck()) {
    rocketship = new projectile(ship, mouseX, mouseY);
    noTint();
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
