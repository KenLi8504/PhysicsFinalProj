public class planets{
  int radius;
  
  //COM Coordinates
  float xCor;
  float yCor;
  
  float mass;
  PImage sprite;
  
  public planets(PImage shape, float x, float y){
    mass = 100 * (float)Math.pow(10,20);
    radius = 50;
    xCor = x - radius;
    yCor = y - radius;
    sprite = shape;
    sprite.resize(radius * 2, radius * 2);
  }
  
  public void updateCoordinate(float x, float y){
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
  public boolean held(float x, float y){
    return (Math.sqrt(Math.pow(xCor - x + radius, 2) + Math.pow(yCor - y + radius, 2)) <= radius);
  }
  public float getMass(){
    return mass;
  }
  
  public int getRadius(){
    return radius;
  }
}
