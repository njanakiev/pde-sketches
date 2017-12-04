class Circle {
  float x, y, r;
  boolean growing = true;
  
  Circle(float x, float y){
    this.x = x;
    this.y = y;
    r = 1;
  }
  
  void grow(){
    if(growing){
      r = r + 1;
    }
  }
  
  boolean edges(){
    return (x + r > width || x - r < 0 || y + r > height || y - r < 0);
  }
  
  void show(){
    stroke(255);
    noFill();
    strokeWeight(1);
    ellipse(x, y, r*2, r*2);
  }
}