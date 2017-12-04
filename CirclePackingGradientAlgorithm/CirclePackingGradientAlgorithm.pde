CircleCollection collection;

boolean animate = true;

void setup(){
  collection = new CircleCollection();
  size(500, 500);
  background(0);
  stroke(255);
  noFill();
  smooth();
  
  collection.newCircle();
  frameRate(10);
}

void draw(){
  if(animate){
    background(0);
    collection.next();
    collection.show();
  }
  println("FPS : " + frameCount);
  if(frameCount <= 250){
    saveFrame("frames/#####.png");
  }else{
    noLoop();
  }
}

void keyPressed(){
  switch(key){
    case ' ':
      println("NEXT STEP");
      collection.next();
      break;
    case 'n':
      println("NEW CIRCLE");
      collection.newCircle();
      break;
    case 'a':
      animate = !animate;
      break;
    case 's':
      collection.showIsosurface = !collection.showIsosurface;
      break;
  }
  background(0);
  collection.show();
}