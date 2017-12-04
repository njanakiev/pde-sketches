import peasy.*;

PeasyCam cam;

ArrayList<PVector> points;
PShape gpsShape;
String path = "C:/dev/github_projects/floating-map/floatingmap/data/";

void setup(){
  size(600, 600, P3D);
  //size(displayWidth, displayHeight, P3D);
  cam = new PeasyCam(this, 100);
  cam.setMinimumDistance(-100);
  cam.setMaximumDistance(500);
  
  stroke(255);
  noFill();
  
  points = loadData(path);
  println("Points : " + points.size());

  //background(255);
  //drawPoints(points);
  
  gpsShape = pointShape(points, 250, 250, 50);
}

void draw(){
  background(0);
  //box(500);
  shape(gpsShape);
}

void keyPressed(){
  switch(key){
  case 's':
    saveFrame("####.png");
    println("frame saved");
    break;
  }
}
