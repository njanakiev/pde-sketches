SpringGridSimulation sim;
Arcball arcball;

void setup(){
  size(displayWidth, displayHeight, P3D);
  stroke(200);
  
  sim = new SpringGridSimulation(50, 50);
  arcball = new Arcball(width/2, height/2, 600);
}

void draw(){
  background(0);
  translate(width/2, height/2, 100);
  arcball.run();
  
  lights();
  sim.draw();
  sim.next();
}

void mousePressed(){
  arcball.mousePressed();
  sim.impulse(5);
}

void mouseDragged(){
  arcball.mouseDragged();
}