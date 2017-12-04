TriangleGrid grid;
float r = 20;
float t = 0;

void setup(){
  //size(displayWidth, displayHeight);
  size(800, 800);
  fill(255);
  noStroke();
  
  grid = new TriangleGrid(width - 10, height - 10, r);
}

void draw(){
  t = (t + 0.01) % 1;
  background(0);
  grid.show(t);
}