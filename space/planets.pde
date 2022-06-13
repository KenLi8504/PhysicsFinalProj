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
    xCor = x;
    yCor = y;
    sprite = shape;
    sprite.resize(radius * 2, radius * 2);
  }
  
  public planets(PImage shape, float x, float y, float givenMass){
    mass = 0 * givenMass;
    radius = 10;
    xCor = x;
    yCor = y;
    sprite = shape;
    sprite.resize(radius * 2, radius * 2);
  }
  
  public void increaseMass(){
    if(mass >= 259 * (float)Math.pow(10,20)){
      return;
    }
    mass += 20 * (float)Math.pow(10,20);
  }
  
  public void increaseRadius(){
    if (radius >= 100){
      return;
    }
    radius += 10;
    sprite.resize(radius * 2, radius * 2);
  }
  
  public void decreaseMass(){
    if(mass <= 40 * (float)Math.pow(10,20)){
      return;
    }
    mass -= 20 * (float)Math.pow(10,20);
  }
  
  public void decreaseRadius(){
    if(radius <= 30){
      return;
    }
    radius -= 10;
    sprite.resize(radius * 2, radius * 2);
  }
  public void updateCoordinate(float x, float y){
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
  public boolean held(float x, float y){
    return (Math.sqrt(Math.pow(xCor - x, 2) + Math.pow(yCor - y, 2)) < radius);
  }
  
  public float getMass(){
    return mass;
  }
  
  public int getRadius(){
    return radius;
  }
}
