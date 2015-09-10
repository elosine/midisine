import oscP5.*;
import netP5.*;
import processing.serial.*;

OscP5 osc;
NetAddress sc;

Serial ino; 
String serialmsg;
boolean sendTrig = true;

float pitch, amp, serialamp;


void setup() {
  size(800, 600);

  osc = new OscP5(this, 12321);
  sc = new NetAddress("127.0.0.1", 57120);

  String portname = Serial.list()[5];
  //println(Serial.list());
  // println(portname);
  ino = new Serial(this, portname, 19200);
  
  OscMessage trig = new OscMessage("/trig");
  trig.add(1);
  osc.send(trig, sc);
}

void draw() {
  background(0);

  //Read serial port
  if (ino.available()>0) {
    serialmsg = ino.readString();
    String[] msgsplit = split(serialmsg, ':');
    if (msgsplit.length>1) {
      if (msgsplit[0].equals("us1")) {
        if ( int(msgsplit[1])>0 )serialamp = constrain(norm( int(msgsplit[1]), 7, 20 ), 0.0, 1.0);
      }
    }
  }

  pitch = map(mouseX, 0.0, width, 48.0, 72.0); //two octave range
  amp = norm(mouseY, height, 0.0);
 println(serialamp);

  OscMessage pitchmsg = new OscMessage("/pitch");
  pitchmsg.add(pitch);
  osc.send(pitchmsg, sc);

  OscMessage ampmsg = new OscMessage("/amp");
  ampmsg.add(serialamp);
  osc.send(ampmsg, sc);
}

void mousePressed() {
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

void mouseReleased() {
  OscMessage trig = new OscMessage("/trig");
  trig.add(0);
  osc.send(trig, sc);
}

//change pitch/amp while dragging mouse
//replace pitch range with variables
//make a visual keyboard with pitch restrictions
//light up objects when pressing

