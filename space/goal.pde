public class goal{
  float xCor;
  float yCor;
  
  public goal(){
    xCor = 300;
    yCor = 300;
  }
  
  public void updateCoordinate(float x, float y){
    xCor = x - 85;
    yCor = y - 48;
  }
  
  public float getX(){
    return xCor;
  }
  
  public float getY(){
    return yCor;
  }
  
  public boolean held(float x, float y){
    if(x - xCor < 170 && y-yCor < 96){
      return true;
    } 
    return false;
  }
}
