public class planets{
  int radius;
  
  //COM Coordinates
  int xCor;
  int yCor;
  
  long mass;
  PImage sprite;
  
  public planets(PImage shape){
    xCor = 0;
    yCor = 0;
    mass = 100;
    sprite = shape;
  }
  
  public void updateCoordinate(int x, int y){
    xCor = x;
    yCor = y;
  }
  
  public float getX(){
    return xCor;
  }
  public float getY(){
    return yCor;
  }
  public PImage getImage(){
    return sprite;
  }
}

public class projectile{
  long xVelocity;
  long yVelocity;
  int angle;
}
