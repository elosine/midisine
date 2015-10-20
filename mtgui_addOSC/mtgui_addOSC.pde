

float pitch, amp;

void setup(){
  size(800, 600);

}

void draw(){
  background(0);
  pitch = map(mouseX, 0.0, width, 48.0, 72.0); //two octave range
  amp = norm(mouseY, height, 0.0);
}

void mousePressed(){
 
}

void mouseReleased(){
  
}