Circle c;

ArrayList<Circle> circles;

void setup(){
  size(800, 600);
  circles = new ArrayList<Circle>();
}

void draw(){
  background(0);
  
  Circle cNew = newCircle();
  if (cNew != null){
    circles.add(cNew);
  }
  
  for(Circle c: circles){
    if(c.growing){
      //if(c.edges()){
      //  c.growing = false;
      //}else{
      for(Circle other: circles){
        float d = dist(c.x, c.y, other.x, other.y);
        if(c != other && d - 1 < c.r + other.r){
          c.growing = false;
          break;
        }
      }
      //}
    }
    c.show();
    c.grow();
  }
}

Circle newCircle(){
  float r = random(pow(min(width, height)*0.5*0.8, 2));
  float phi = random(TAU);
  
  float x = width/2 + sqrt(r)*cos(phi);
  float y = height/2 + sqrt(r)*sin(phi);
  
  for (Circle c : circles){
    float d = dist(x, y, c.x, c.y);
    if(d < c.r){
      return null;
    }
  }
  return new Circle(x, y);
}