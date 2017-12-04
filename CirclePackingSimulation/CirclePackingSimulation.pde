CircleSimulation simulation;

boolean animate = true; 

void setup(){
  simulation = new CircleSimulation(200);
  size(500, 500);
  background(0);
  stroke(255);
  fill(255);
}

void draw(){
  if(animate){
    background(0);

    simulation.next(); //<>//
    simulation.show();
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
      simulation.next();
      break;
    //case 'n':
    //  println("NEW CIRCLE");
    //  simulation.newCircle();
    //  break;
    case 'a':
      animate = !animate;
      break;
    case 's':
      simulation.showIsosurface = !simulation.showIsosurface;
      break;
    case 'g':
      simulation.showGradients = !simulation.showGradients;
      break;
  }
  background(0);
  simulation.show();
}

void mousePressed(){
  if(mouseButton == LEFT){
    simulation.center.x = mouseX;
    simulation.center.y = mouseY;
  }
}