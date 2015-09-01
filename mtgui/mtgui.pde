import oscP5.*;
import netP5.*;

OscP5 osc;
NetAddress sc;

float pitch, amp;

void setup(){
  size(800, 600);
  
  osc = new OscP5(this, 12321);
  sc = new NetAddress("127.0.0.1", 57120);
}

void draw(){
  background(0);
  pitch = map(mouseX, 0.0, width, 48.0, 72.0); //two octave range
  amp = norm(mouseY, height, 0.0);
  println(amp);
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

