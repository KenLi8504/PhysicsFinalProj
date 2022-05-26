public class projectile{
  long xVelocity;
  long yVelocity;
  int xPosition;
  int yPosition;
  int angle;
  PImage sprite;
  
  
  public projectile(PImage shape, int x, int y){
    sprite = shape;
    sprite.resize(30,40);
    xPosition = x;
    yPosition = y;
  }
  
  public int getX(){
    return xPosition;
  }
  
  public int getY(){
    return yPosition;
  }
  
  public PImage getImage(){
    return sprite;
  }
}
