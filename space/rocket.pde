public class projectile{
  float totalVelocity;
  float xVelocity;
  float yVelocity;
  float xPosition;
  float yPosition;
  float radius;
  float angle;
  PImage sprite;
  
  
  public projectile(PImage shape, float x, float y){
    sprite = shape;
    angle = 0;
    xPosition = x;
    yPosition = y;
    xVelocity = 0;
    yVelocity = 0;
  }
  
  public projectile(PImage shape, float x, float y,float givenAngle, float givenVelocity){
    sprite = shape;
    angle = 0;
    xPosition = x;
    yPosition = y;
    xVelocity = 0;
    yVelocity = 0;
    angle = givenAngle;
    totalVelocity = givenVelocity;
  }
  
  public float getX(){
    return xPosition;
  }
  
  public float getY(){
    return yPosition;
  }
  
  public float getXVelocity(){
    return xVelocity;
  }
  
  public float getYVelocity(){
    return yVelocity;
  }
  
  public PImage getImage(){
    return sprite;
  }
  
  public boolean held(float x, float y){
    print("holding rocket\n");
    return (Math.sqrt(Math.pow(xPosition - x, 2) + Math.pow(yPosition - y, 2)) <= 25);
  }
  
  public void updateCoordinate(float x, float y){
   xPosition = x;
   yPosition = y;
 }
 
 public void incVelocity(){
  if(totalVelocity >= 1000){
    return;
  }
  totalVelocity = totalVelocity + 10;
}
public void decVelocity(){
  if(totalVelocity <= 0){
    return;
  }
  totalVelocity = totalVelocity - 10;
}

public void incAngle(){
  angle = angle + 5;
}

public void decAngle(){
  angle = angle -5;
}
}
