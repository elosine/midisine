import oscP5.*;
import netP5.*;

OscP5 osc;
NetAddress sc;

float pitch, amp;
int w = 1000;
int h = 600;
float pitchlo =36.0;
float pitchhi = 60.0;
int numsteps;

int pxperstep;

void setup(){
  size(w, h);
  
  osc = new OscP5(this, 12321);
  sc = new NetAddress("127.0.0.1", 57120);
   pxperstep = round( w/(pitchhi - pitchlo) );
  numsteps = ceil( pitchhi - pitchlo);
}

void draw(){
  background(0);
  pitch = map(mouseX, (pxperstep/2), width+(pxperstep/2), pitchlo, pitchhi); //two octave range
  amp = norm(mouseY, height, 0.0);
   //virtual keyboard
  strokeWeight(3);
  stroke(0);
  for (int i=0; i<numsteps; i++) {
    if ( (i%12)==1 || (i%12)==3 || (i%12)==6 || (i%12)==8 || (i%12)==10) {
      fill(0);
    } else {
      fill(255);
    }
    rect(i*pxperstep, 0, pxperstep, height);
  }
}

void mousePressed(){
  OscMessage pitchmsg = new OscMessage("/pitch");
  pitchmsg.add(pitch);
  osc.send(pitchmsg, sc);
  
  OscMessage ampmsg = new OscMessage("/amp");
  ampmsg.add(amp);
  osc.send(ampmsg, sc);
  
  OscMessage trig = new OscMessage("/trig");
  trig.add(1);
  osc.send(trig, sc);
}

void mouseReleased(){
  OscMessage trig = new OscMessage("/trig");
  trig.add(0);
  osc.send(trig, sc);
}

//change pitch/amp while dragging mouse
//replace pitch range with variables
//make a visual keyboard with pitch restrictions
//light up objects when pressing

