/*
MAJOR CHANGES: REDACTED FRAMERATE FOR BETTER INPUT
ADDED bwColor FUNCTION

*/
import ddf.minim.*;  //Includes the minim library for audioinput
import codeanticode.syphon.*;

Minim minim;
AudioInput in;
AudioPlayer player;

//SyphonServer server;


int x, y;
float gridSize = 10;
float xGrid, yGrid, xAdj;

void settings(){
  size(1080, 1080, P3D);
  PJOGL.profile=1;
}

void setup(){


  //fullScreen();
  background(255);
  smooth();
  frameRate(29.97);
  
  minim = new Minim(this);
  
  in = minim.getLineIn(); // defines the getLineIn method of Minim to get audioInput
  player = minim.loadFile("noise_wav.wav");
  //server = new SyphonServer(this, "BarGraph");
  
  xGrid = width/in.bufferSize();
 
}

void draw(){
  
  background(0);
  y = 0;
  xAdj = 0;
  
  for(x = 0; x <= in.bufferSize() - 1; x++){
      
    bwColor(in.mix.get(x), 0.15);
    rect(x, y, xGrid, height);
  }
  //server.sendScreen();

}

//Sets the color of the rectangle to black or white based on
//the wave value (between -1 and 1) and a given sensitivy (usually between 0 and 1)
void bwColor(float wave, float sensitivity){
  
  if(wave >= sensitivity){
    fill(255);
    noStroke();
  }else if(wave < -sensitivity){
    fill(255);
    noStroke();
  }else{
    fill(0);
    stroke(0);
  }
  
}

void keyPressed() {
  if(key == 'p' || key == 'P') {
    player.play();
  }
}