Structure struct;
Arcball arcball;

void setup(){
  size(displayWidth, displayHeight, P3D);
  //size(800, 800, P3D);
  //noFill();
  //stroke(255);
  
  arcball = new Arcball(width/2, height/2, 600);
  struct = new Structure();
}

void draw(){
  background(0);
  translate(width/2, height/2, 100);
  arcball.run();
  
  //box(100);
  struct.draw();
}

void mousePressed(){
  arcball.mousePressed();
}

void mouseDragged(){
  arcball.mouseDragged();
}