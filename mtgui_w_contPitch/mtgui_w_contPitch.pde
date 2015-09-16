import oscP5.*;
import netP5.*;

OscP5 osc;
NetAddress sc;

float pitch, amp;
int w = 1000;
int h = 600;
float pitchlo = 48.0;
float pitchhi = 73.0;
int numsteps;

int pxperstep;

void setup() {
  size(w, h);

  osc = new OscP5(this, 12321);
  sc = new NetAddress("127.0.0.1", 57120);

  pxperstep = round( w/(pitchhi - pitchlo) );
  numsteps = ceil( pitchhi - pitchlo);
}

void draw() {
  background(100, 100, 255);

  //Sends a continuous pitch message through OSC
  pitch = map(mouseX, (pxperstep/2), width+(pxperstep/2), pitchlo, pitchhi); //two octave range
  println(pitch);
  OscMessage pitchmsg = new OscMessage("/pitch");
  pitchmsg.add(pitch);
  osc.send(pitchmsg, sc);

  //virtual keyboard
  strokeWeight(3);
  stroke(0);
  for (int i=0; i<numsteps; i++) {
    if ( (i%12)==1 || (i%12)==3 || (i%12)==6 || (i%12)==8 || (i%12)==10) {
      fill(0);
    } else {
      fill(255);
    }
    rect(i*pxperstep, 0, pxperstep, 200);
  }
}

