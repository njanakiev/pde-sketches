void setup() {
  size(640, 320);
  noFill();
  smooth();
  
  background(0);
  float[] controlPoints = rand(10, 0, 20);
  stroke(120); drawGraph(controlPoints, 0, 20);
  stroke(255); drawGraph(bezierCurve(controlPoints, 200), 0, 20);
}

void mousePressed() {
  background(0);
  float[] controlPoints = rand(10, 0, 20);
  stroke(120); drawGraph(controlPoints, 0, 20);
  stroke(255); drawGraph(bezierCurve(controlPoints, 200), 0, 20);
}

void draw(){
}

void keyPressed(){
  saveFrame("screen.png");
  println("image saved");
}
