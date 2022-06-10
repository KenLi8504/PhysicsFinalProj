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
    xCor = x;
    yCor = y;
  }
  
  public float getX(){
    return xCor;
  }
  
  public float getY(){
    return yCor;
  }
  
  public boolean held(float x, float y){
   print("holding goal\n");
   return (Math.sqrt(Math.pow(xCor - x, 2) + Math.pow(yCor - y, 2)) <= 50);
  }
}
