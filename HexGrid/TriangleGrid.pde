class TriangleGrid{
  int n, m;
  float x0, y0, w, h;
  float r0, d;
  ArrayList<PVector> points;
  WaveSurface surface;
  
  TriangleGrid(float w, float h, float r0){
    this.w = w; this.h = h; 
    this.r0 = r0;
    x0 = r0; y0 = r0;
    surface = new WaveSurface(4);
    
    d = sqrt(3)*r0*0.5;
    n = floor(h/d);
    m = floor(w/r);
    points = new ArrayList<PVector>();
    
    for(int i=0; i<n; i++){
      int mRow = ((i % 2) == 0) ? m-1 : m;
      for(int j=0; j<mRow; j++){
        float xOffset = ((i % 2) == 0) ? r/2 : 0;
        float x = x0 + xOffset + r0*float(j);
        float y = y0 + d*float(i);
        points.add(new PVector(x, y));
      }
    }
  }
  
  void show(float t){
    for(PVector p : points){
      float r = r0*surface.getValue(p.x/width, p.y/height, t);
      ellipse(p.x, p.y, r, r);
    }
  }
}