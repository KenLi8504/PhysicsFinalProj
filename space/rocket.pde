public class projectile{
  float xVelocity;
  float yVelocity;
  float xPosition;
  float yPosition;
  float angle;
  PImage sprite;
  
  
  public projectile(PImage shape, float x, float y){
    sprite = shape;
    xPosition = x;
    yPosition = y;
    xVelocity = 50;
    yVelocity = 0;
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
}
