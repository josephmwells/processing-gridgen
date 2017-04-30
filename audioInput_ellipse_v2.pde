import ddf.minim.*;
import codeanticode.syphon.*;

Minim minim;
AudioInput in;
SyphonServer server;

PShape ring;

void settings(){
  size(1080, 1080, P3D);
  PJOGL.profile=1;
}

void setup()
{
  minim = new Minim(this);
  
  // use the getLineIn method of the Minim object to get an AudioInput
  in = minim.getLineIn();
  server = new SyphonServer(this, "AudioRing");
}
  
void draw()
{
  background(0);
  stroke(255);
  strokeWeight(3);
  ring = createShape();
  
  float radius = 300;
  int centX = width/2;
  int centY = height/2;  
  float x, y;
  float radVariance, thisRadius, rad;
  
  ring.beginShape();
  fill(20, 50, 70, 50);
  
  // draw the waveforms so we can see what we are monitoring
  for(int ang = 0; ang < 360; ang++)
  {
    radVariance = 600 * in.mix.get(int(ang));
    thisRadius = radius + radVariance;
    rad = radians(ang);
    
    x = centX + (thisRadius * cos(rad));
    y = centY + (thisRadius * sin(rad));
    
    ring.curveVertex(x, y);
  }
  ring.endShape();
  
  shape(ring);
  String monitoringState = in.isMonitoring() ? "enabled" : "disabled";
  text( "Input monitoring is currently " + monitoringState + ".", 5, 15 );
  
  server.sendScreen();
}

void keyPressed()
{
  if ( key == 'm' || key == 'M' )
  {
    if ( in.isMonitoring() )
    {
      in.disableMonitoring();
    }
    else
    {
      in.enableMonitoring();
    }
  }
}