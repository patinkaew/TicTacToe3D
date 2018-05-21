public class Cell{
  private float[] center;
  private float[] size; 
  private boolean hasSphere = false;
  protected int[] sphereColor;
  private boolean isFill = false;
  private boolean[] occupiedBy;
  
  public Cell(float[] center, float[] size){
    this.center = center;
    this.size = size;
    sphereColor = new int[3];
    occupiedBy = new boolean[2];
  }
  public float[] getCenter(){
    return center;
  }
  public float[] getSize(){
    return size;
  }
  public float[] getCorner(int[] direction){
    float[] corner = new float[3];
    for(int i=0; i<corner.length; i++){
      corner[i]= center[i]+direction[i]*size[i]/2;
    }
    return corner;
  }
  public boolean hasSphere(){
    return hasSphere;
  }
  public String getColor(){
    return sphereColor[0] +" "+ sphereColor[1] +" "+sphereColor[2];
  }
  private float findMin(float[] arr){
    float min = arr[0];
    for(int i=0; i<arr.length; i++){
      if(arr[i]<min){
        min =arr[i];
      }
    }
    return min;
  }
  public void drawSphere(){
    stroke(sphereColor[0],sphereColor[1],sphereColor[2],80);
    strokeWeight(findMin(size)-20);
    point(center[0],center[1],center[2]);
    
    stroke(0);
    strokeWeight(1);
  }
  public boolean isFill(){
    return isFill;
  }
  public boolean isOccupiedBy(int player){
    return occupiedBy[player];
  }
  public boolean setSphere(int player){
    if(!isFill){
      hasSphere = true;
      isFill = true;
      occupiedBy[player] = true;
      
      switch(player){
        case 0: sphereColor[0] = 0; sphereColor[1] = 0; sphereColor[2] = 255; break;
        case 1: sphereColor[0] = 0; sphereColor[1] = 255; sphereColor[2] = 0; break;
        case 2: sphereColor[0] = 255; sphereColor[1] =255; sphereColor[2] = 0; break;
        case 3: sphereColor[0] = 0; sphereColor[1] = 255; sphereColor[2] = 255; break;
        case 4: sphereColor[0] = 255; sphereColor[1] = 0; sphereColor[2] = 255; break;
        default: break;
      }
      return true;
    }else{
      return false;
    }
  }
}
