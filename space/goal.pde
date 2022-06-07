public class goal{
  float xCor;
  float yCor;
  PImage sprite;
  int radius;
  
  public goal(){
    xCor = 300;
    yCor = 300;
  }
  
  public void updateCoordinate(float x, float y){
    xCor = x - 50;
    yCor = y - 50;
  }
  
  public float getX(){
    return xCor;
  }
  
  public float getY(){
    return yCor;
  }
  
  public boolean held(float x, float y){
    if(x - xCor < 100 && y-yCor < 100){
      return true;
    } 
    return false;
  }
}
