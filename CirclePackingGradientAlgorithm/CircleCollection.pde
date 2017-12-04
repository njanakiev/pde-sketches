PVector randomDiscPoint(float r){
  float rTmp = random(pow(r, 2));
  float phi = random(TAU);
  
  float x = width/2 + sqrt(rTmp)*cos(phi);
  float y = height/2 + sqrt(rTmp)*sin(phi);
  return new PVector(x, y);
}
PVector randomCirclePoint(float r){
  float phi = random(TAU);
  
  float x = width/2 + r*cos(phi);
  float y = height/2 + r*sin(phi);
  return new PVector(x, y);
}




class CircleCollection {
  ArrayList<Circle> circles;
  Circle curr = null;
  PVector gradient = null;
  float factor = 1000;
  int attempts = 1000;
  boolean showIsosurface = true;
  boolean showGradient = false;
  
  CircleCollection(){
    circles = new ArrayList<Circle>();
    //circles.add(new Circle(width/2, height/2, 50));
    
    int n = 6;
    float r = min(width, height)*0.25;
    for(int i=0; i<n; i++){
      float phi = TAU*float(i)/float(n);
      float x = width/2 + r*cos(phi);
      float y = height/2 + r*sin(phi);
      circles.add(new Circle(x, y, 20));
    }
  }
  
  void next(){
    if(gradient != null){
      boolean overlap = false;
      float magnitude = gradient.mag();
      for(Circle c : circles){
        float distance = dist(c.x, c.y, curr.x, curr.y) - (curr.r + c.r) - 0.05;
        if(distance < 0.05){
          overlap = true;
        }else if(distance < magnitude){
          magnitude = distance;
        }
      }
      if(overlap){
        newCircle();
      }else{
        gradient.limit(magnitude);
        curr.add(gradient);
        calcGradient();
      }
    }
  }
  
  void newCircle(){
    PVector p;
    float r;
    boolean valid = true;
    
    for(int i=0; i<attempts; i++){
      valid = true;
      p = randomDiscPoint(height/2);
      //p = randomCirclePoint(height/2);
      r = random(1, 20);
      
      for(Circle c : circles){
        if(dist(p.x, p.y, c.x, c.y) < c.r + r){
          valid = false;
          break;
        }
      }
      if(valid){
        if(curr != null){
          circles.add(curr);
        }
        curr = new Circle(p, r);
        calcGradient();
        return;
      }
    }
  }
  
  void show(){
    if(showIsosurface){
      drawIsosurface();
    }
    noFill();
    stroke(255, 0, 0);
    if(curr != null){
      curr.show();
      if(showGradient && gradient != null){
        line(curr.x, curr.y, curr.x + 10*gradient.x, curr.y + 10*gradient.y);
      }
    }
    stroke(0);
    //fill(255);
    //noStroke();
    for(Circle c : circles){
      c.show();
    }
  }
  
  void calcGradient(){
    float dx = 0;
    float dy = 0;
    
    for(Circle c : circles){
      float scale = pow((curr.x*curr.x - 2*c.x*curr.x + curr.y*curr.y - 2*c.y*curr.y + c.x*c.x + c.y*c.y), 3/2);
      if(scale > 0){
        dx += factor*c.r*(c.x - curr.x)/scale;
        dy += factor*c.r*(c.y - curr.y)/scale;
      }
    }
    
    //println("Gradient : " + dx + ", " + dy);
    
    if(gradient != null){
      gradient.x = dx;
      gradient.y = dy;
    }else{
      gradient = new PVector(dx, dy);
    }
  }
  
  void drawIsosurface(){
    loadPixels();
    for(int x = 0; x < width; x++){
      for(int y = 0; y < height; y++){
        float d = 0;
        for(Circle c : circles){
          d += 50*c.r/dist(x, y, c.x, c.y); 
        }
        pixels[x + y*width] = color(d); //color((d > 200) ? 255 : 0);
      }
    }
    updatePixels();
  }
}



class Circle {
  float x, y, r;
  
  Circle(float x, float y, float r){
    this.x = x;
    this.y = y;
    this.r = r;
  }
  
  Circle(PVector p, float r){
    this.x = p.x;
    this.y = p.y;
    this.r = r;
  }
  
  void add(PVector v){
    x += v.x;
    y += v.y;
  }
  
  void show(){
    ellipse(x, y, r*2, r*2);
  }
}