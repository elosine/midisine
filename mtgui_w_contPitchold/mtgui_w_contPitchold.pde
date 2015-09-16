import oscP5.*;
import netP5.*;

OscP5 osc;
NetAddress sc;

float pitch, amp;

void setup() {
  size(1000, 600);

  osc = new OscP5(this, 12321);
  sc = new NetAddress("127.0.0.1", 57120);

  OscMessage trig = new OscMessage("/trig");
  trig.add(1);
  osc.send(trig, sc);
}

void draw() {
  background(0);
  pitch = map(mouseX, 0.0, width, 48.0, 84.0); //three octave range
  println(pitch + " : " + mouseX);
  
  stroke(0);
  strokeWeight(2);
  
  for(int i=0;i<36;i++){
    if ( (i == 1) || (i == 3) || (i==6) || (i == 8) || 
    (i==10) || (i == 13) || (i==15) || (i == 18) || 
    (i==20) || (i==22) || (i == 25) || (i==27) || 
    (i == 30) || (i==32) || (i==34) ) {
      fill(0);
    } 
  //
    else fill(255);
    rect(28*i, 0, 28, 200);
  }
 
  OscMessage pitchmsg = new OscMessage("/pitch");
  pitchmsg.add(pitch);
  osc.send(pitchmsg, sc);
}

void keyPressed() {
  if(key=='s'){
  OscMessage trig = new OscMessage("/trig");
  trig.add(0);
  osc.send(trig, sc);
  }
  if(key=='r'){
  OscMessage trig = new OscMessage("/trig");
  trig.add(1);
  osc.send(trig, sc);
  }
}

//change pitch/amp while dragging mouse
//replace pitch range with variables
//make a visual keyboard with pitch restrictions
//light up objects when pressing

