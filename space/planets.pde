public class planets{
  int radius;
  
  //COM Coordinates
  int xCor;
  int yCor;
  
  long mass;
  PImage sprite;
  
  public planets(PImage shape, int x, int y){
    mass = 100;
    radius = 50;
    xCor = x - radius;
    yCor = y - radius;
    sprite = shape;
    sprite.resize(radius * 2, radius * 2);
  }
  
  public void updateCoordinate(int x, int y){
    xCor = x - radius;
    yCor = y - radius;
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
