import ddf.minim.*;  //Includes the minim library for audioinput
import codeanticode.syphon.*;

Minim minim;
AudioInput in;
AudioPlayer player;
SyphonServer server;

float x, y;
float gridSize = 32; //Set at 32 for 1024 BufferSize (multiples of this number work nice)
float xGrid, yGrid;

void settings(){
  size(500, 500, P3D);
  PJOGL.profile=1;
}

void setup(){
  
  //fullScreen();
  background(255);
  smooth();
  noStroke();
  
  minim = new Minim(this); //creates new Minim object
  in = minim.getLineIn();  //defines minim objects getLineIn as variable in
  //player = minim.loadFile("Aphex Twin - Xtal.mp3");
  server= new SyphonServer(this, "GridGen");
  
  //Sets and adjusts the rectangles to gridSize
  xGrid = width/gridSize;
  yGrid = height/gridSize;
  
  //player.play();

}

void draw(){
  
  background(255);
  int bufferCapture = 0;
  //itterates through a column, then all rows (based on gridSize)
  //until the specified gridSize is reached
  for(y = 0; y < height; y += yGrid){
    for(x = 0; x < width; x += xGrid){
      
      bwColor(in.mix.get(bufferCapture), 0.2);
      rect(x, y, xGrid, yGrid); 
      bufferCapture++;
      bufferCapture %= in.bufferSize();
      
    } 
  }  
  server.sendScreen();

}

//Sets the color of the rectangle to black or white based on
//the wave value (between -1 and 1) and a given sensitivy (usually between 0 and 1)
void bwColor(float wave, float sensitivity){
  
  if(wave >= sensitivity || wave <= -(sensitivity)){
    fill(255);
    noStroke();
  }else{
    fill(0);
    stroke(0);
  }  
  
}