public class Actor{
  private Cell[][][] space;
  private int[] startIndex;
  private int[] index;
  private float[] size;
  private Locator locator;
  
  public Actor(Cell[][][] space, int[] startIndex, float[] size){
    this.space = space;
    this.startIndex = startIndex;
    this.index = startIndex;
    this.size = size;
    locator = new Locator();
  }
  
  public void reset(){
    index = startIndex;
  }
  
  public boolean isMoveValid(int[] dIndex){
    boolean flag = true;
    for(int i=0; i<3; i++){ 
      if(index[i]+dIndex[i]<0|| index[i]+dIndex[i]>no[i]-1){
        flag = false;
      }
    }
    return flag;
  }
  
  public void move(int[] dIndex){
    if(isMoveValid(dIndex)){
      index = locator.arrayAdd(index,dIndex);
    }
  }
  
  public void setIndex(int[] newIndex){
    index = newIndex;
  }
  public int[] getIndex(){
    return index;
  }
  public String getStringIndex(){
    return "x = " + index[0] + " y = " + index[1] + " z = "+index[2];
  }
  public boolean drop(int player){
    if(!space[index[0]][index[1]][index[2]].isFill()){
      space[index[0]][index[1]][index[2]].setSphere(player);
      return true;
    }else{
      return false;
    }
  }
  
  public void update(){
  
    stroke(255,0,0);
    strokeWeight(2);
    
    float[] pos = space[index[0]][index[1]][index[2]].getCenter();
    
    line(pos[0]-size[0]/2,pos[1]-size[0]/2,pos[2],pos[0]+size[0]/2,pos[1]+size[0]/2,pos[2]);
    line(pos[0]+size[0]/2,pos[1]-size[0]/2,pos[2],pos[0]-size[0]/2,pos[1]+size[0]/2,pos[2]);
    line(pos[0]-size[0]/2,pos[1],pos[2],pos[0]+size[0]/2,pos[1],pos[2]);
    line(pos[0],pos[1]-size[1]/2,pos[2],pos[0],pos[1]+size[0]/2,pos[2]);
    line(pos[0],pos[1],pos[2]-size[2]/2,pos[0],pos[1],pos[2]+size[2]/2);
    
    stroke(0,0,0);
  }
}
