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



class CircleSimulation {
  Circle[] circles;
  PVector[] gradients;
  float factor = 1; 
  int attempts = 10000;
  int n;
  boolean showGradients = false;
  boolean showIsosurface = false;
  float r0;
  PVector center;
  
  
  CircleSimulation(int n){ //<>//
    this.n = n;
    circles = new Circle[n];
    gradients = new PVector[n];
    center = new PVector(width/2, height/2);

    randomPoints(); //<>// //<>//
  }
  
  void circle(){
    for(int i = 0; i < n; i++){ 
      gradients[i] = new PVector();
      
      float r = min(width, height)*0.5*0.8;
      float x = width/2 +  r*cos(TAU*float(i)/float(n));
      float y = height/2 + r*sin(TAU*float(i)/float(n));
      circles[i] = new Circle(x, y, 2);
    }
  }
  
  void randomPoints(){
    for(int i = 0; i < n; i++){ 
      gradients[i] = new PVector();
      
      PVector p;
      float r;
      boolean valid = true;
      
      // TODO: check for cases when all attempts are depleted
      for(int j = 0; j < attempts; j++){
        valid = true;
        //p = randomDiscPoint(height/2);
        p = randomCirclePoint(height/2);
        r = 2;//random(10, 20);
        
        for(int k = 0; k < i; k++){
          if(dist(p.x, p.y, circles[k].x, circles[k].y) < circles[k].r + r){
            valid = false;
            break;
          }
        }
        if(valid){
          circles[i] = new Circle(p, r);
          break;
        }
      } 
    }
  }
  
  void next(){
    calcGradients();
    for(int i = 0; i < n; i++){
      PVector vec = new PVector(center.x - circles[i].x, center.y - circles[i].y);
      vec.normalize();
        
      circles[i].x -= gradients[i].x - 2*vec.x;
      circles[i].y -= gradients[i].y - 2*vec.y;
    }
  }
  
  void show(){
    if(showIsosurface){
      drawIsosurface();
    }
    for(int i = 0; i < n; i++){
      circles[i].show();
      if(showGradients){
        line(circles[i].x, 
             circles[i].y, 
             circles[i].x - 20*gradients[i].x, 
             circles[i].y - 20*gradients[i].y);
      }
    }
  }
  
  void calcGradients(){
    float gradX, gradY;
    float dx, dy;
    float r;
     //<>//
    for(int i = 0; i < n; i++){
      r = circles[i].r;
      gradX = 0;
      gradY = 0;
      for(int j = 0; j < n; j++){ //<>//
        dx = circles[j].x - circles[i].x; //<>//
        dy = circles[j].y - circles[i].y;
        if(i != j){
          float scale = pow((dx*dx + dy*dy), 3/2);
          //float scale = (dx*dx + dy*dy)*(dx*dx + dy*dy); //<>//
          if(scale != 0){
            gradX += factor*r*(dx)/scale;
            gradY += factor*r*(dy)/scale; //<>//
          }
        }
      }
      gradients[i].x = gradX;
      gradients[i].y = gradY;
    }
  }
  
  void drawIsosurface(){
    loadPixels();
    for(int x = 0; x < width; x++){
      for(int y = 0; y < height; y++){
        float d = 0;
        for(Circle c : circles){
          d += 40*c.r/dist(x, y, c.x, c.y); 
        }
        pixels[x + y*width] = color(d);
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
  
  void show(){
    ellipse(x, y, r*2, r*2);
  }
}