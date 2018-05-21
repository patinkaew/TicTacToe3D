/*
* TicTacToe 3D By Earth @patinkaew
* May 2018
*/

final int[] no = {5,5,1}; // number of cell in each directions (x,y,z)
final float[] boxSize = {360,360,360}; // size of the box
final int connect = 3; // how many connection to win the game
final int playerNo = 2; // number of players in this game, up to 5 players

Cell[][][] table; 
float[] cellSize; // dimension of each cell

int turn = 0; // this turn is for which player
boolean isKeyActive = false; // mechanism to protect hold key
boolean[] check; // is any players win the game

Actor actor; // ~cursor in this game, it can move and drop sphere for each player
Locator locator; // helper to manage array

float [] getDim(){ // get dimension of each cell
  float[] dim = new float[3];
  for(int i=0; i<dim.length; i++){
    dim[i] = boxSize[i]/no[i];
  }
  return dim;
}

void makeGrid(){ // create a grid
  float[] dim = new float[3];
  for(int i=0; i<dim.length; i++){
    dim[i] = boxSize[i]/no[i];
  }
  for(int k=0; k<no[2]+1; k++){ // translate in z
    for(int i=0; i<no[0]+1; i++){ //draw line from x axis parallel to y   
      line(i*dim[0],0,-k*dim[2],i*dim[0],boxSize[1],-k*dim[2]);
    }
  }
  for(int i=0; i<no[0]+1; i++){ // translate in x
    for(int j=0; j<no[1]+1; j++){ //draw line from y axis parallel to z  
      line(i*dim[0],j*dim[1],0,i*dim[0],j*dim[1],-boxSize[2]);
    }
  }
  for(int j=0; j<no[1]+1; j++){ // translate in y
    for(int k=0; k<no[2]+1; k++){ //draw line from z axis parallel to z   
      line(0,j*dim[1],-k*dim[2],boxSize[0],j*dim[1],-k*dim[2]);
    }
  }
}

boolean isInBoundary(int[] start, int[] dIndex){ // is move in checking connections still in the grid, prevent ArrayIndexOutOfBound
    boolean flag = true;
    for(int i=0; i<3; i++){ 
      if(start[i]+dIndex[i]<0|| start[i]+dIndex[i]>no[i]-1){
        flag = false;
      }
    }
    return flag;
}

int countConnect(int player, int[] start, int[] direction){// checking connections in specific direction 
  int count = 0;
  int step = 1;
  if(direction[0]==0 && direction[1] == 0 && direction[2]==0){
    return count;
  }else{
    while(isInBoundary(start, locator.arrayScalarMulti(direction, step)) && table[start[0]+step*direction[0]][start[1]+step*direction[1]][start[2]+step*direction[2]].isOccupiedBy(player)){
      count++;
      step++;
    }
  }
  return count;
}

boolean checkConnect(int player, int[] start){// check connections in all possible directions and return true if the player in this turn wins the game
  for(int i=0; i<3; i++){ 
    for(int j=0; j<3; j++){
      for(int k=0; k<3; k++){
        int[] direction = {i-1,j-1,k-1};
        int[] inverseDirection = locator.arrayScalarMulti(direction,-1);
        if(countConnect(player, start, direction) + countConnect(player,start, inverseDirection)+1>=connect){
          return true;
        }
      }
    }
  }
  return false;
}
void makeWorld(){ // create Grid and also update cells occupied by each player
  makeGrid();
  for(int i=0; i<no[0]; i++){// assign table
     for(int j=0; j<no[1]; j++){
      for(int k=0; k<no[2]; k++){
        if(table[i][j][k].hasSphere()){
          table[i][j][k].drawSphere();
        }
      }
    }
  }
}

String getPlayerName(int player){ //get player's name
  switch(player){
    case 0: return "Blue";
    case 1: return "Green";
    case 2: return "Yellow";
    case 3: return "Cyan";
    case 4: return "Magenta";
    default: return "";
  }
}

void nextTurn(){ //move to next player's turn
  if(turn<playerNo-1){
    turn++;
  }else{
    turn = 0;
  }
}

void setup(){
  size(600,600,P3D); // create panel 600x600 and render with 3D graphics
  cellSize = getDim(); // assign dimension of a cell
  table = new Cell[no[0]][no[1]][no[2]]; // create 3D array represent the whole grid
  for(int i=0; i<no[0]; i++){// assign table to point to each cell
    for(int j=0; j<no[1]; j++){
      for(int k=0; k<no[2]; k++){
        float[] c = {cellSize[0]/2+i*cellSize[0],cellSize[1]/2+j*cellSize[1],-(cellSize[2]/2+k*cellSize[2])};//center point of each
        table[i][j][k] = new Cell(c,cellSize);
      }
    }
  }
  
  float[] s = new float[3];// size of actor, set to half of length of each cell's size
  for(int i=0; i<s.length; i++){
    s[i]=cellSize[i]/2;
  }
  int[] start = {0,0,0};// starting point of actor
  
  actor = new Actor(table, start, s); // instantiate actor
  locator = new Locator(); // instantiate locator
  check = new boolean[playerNo];// instantiate check boolean
}
void draw(){
  
  background(255,255,255); // set background to white color
  translate((600-boxSize[0])/2, (600-boxSize[2])/2, 0); // move origin 
  rotateY(-PI/6); // rotate around Y axis
  rotateX(-PI/36); //rotate around X axis
  noFill(); // do not fill any shapes
  makeWorld();// create grid and update sphere locations
  actor.update();// update locations of actor
  
  boolean display = true; //display normal message when no one wins
  
  for(int i=0; i<playerNo; i++){// display if any one wins
    if(check[i]){
      println(getPlayerName(i) + " Wins");
      display = false;
    }
  }
  if(display){ // display current turn and where the actor is
    println(getPlayerName(turn)+ "'s Turn | Actor is at index: " + actor.getStringIndex());
  }
}
void keyPressed(){ // if a key is pressed
  isKeyActive = true;
}
void keyReleased(){ // if a key is released
  if(isKeyActive){
    int[] d = new int[3]; 
    switch(key){
      case 'w': d[2]=1; break; 
      case 's': d[2]=-1; break;
      case 'a': d[0]=-1; break;
      case 'd': d[0]=1; break;
      case 'i': d[1]=-1; break;
      case 'k': d[1]=1; break;
      case ' ': 
                boolean isDropped = actor.drop(turn); 
                if(isDropped){
                  check[turn] = checkConnect(turn, actor.getIndex());
                  delay(100); 
                  nextTurn(); 
                }
                break;
      case DELETE: actor.reset(); break;
      default: break;
    }
    actor.move(d);
    isKeyActive = false;
  }
}
