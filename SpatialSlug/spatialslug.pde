Arcball arcball;
float t = 0;

void setup(){
  size(displayWidth, displayHeight, P3D);
  orientation(LANDSCAPE);
  frameRate(60);
  noFill();
  stroke(255);
  arcball = new Arcball(width/2, height/2, 600);
}

void draw(){
  background(0);
  lights();
  translate(width/2, height/2, 200);
  arcball.run();
  
  drawParametricCurve_01(t);
  t += 0.008;
}

void mousePressed(){
  arcball.mousePressed();
}

void mouseDragged(){
  arcball.mouseDragged();
}