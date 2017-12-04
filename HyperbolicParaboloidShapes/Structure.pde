class Structure{
  
  int n, m;
  int squares[][];
  PVector p[];
  float r, h;
  PShape shape;
  
  Structure(){
    this.n = 2;
    this.m = 14;
    this.r = 100;
    this.h = 400;
    
    generateControlPointsTorus();
    generateComplexShape(4);
  }
  
  void generateControlPointsTorus(){  
    p = new PVector[n*m];
    squares = new int[(m-2)*n][4];
    
    int idx = 0;
    float R = 2*r;
    for(int j=0; j<m; j++){
      for(int i=0 ;i<n; i++){
        float x = (R + r*cos(TAU*(float)i/(float)n + (float)j*PI/(float)n))*
                  cos(TAU*(float)j/(float)(m-2));
        float y = (R + r*cos(TAU*(float)i/(float)n + (float)j*PI/(float)n))*
                  sin(TAU*(float)j/(float)(m-2));
        float z = r*sin(TAU*(float)i/(float)n + (float)j*PI/(float)n);
        p[idx++] = new PVector(x, y, z);
      }
    }
    for(int i=0; i<squares.length; i++){
      int layer = i/n;
      squares[i][0] = i;
      squares[i][1] = n + n*layer + ((i+n-1) % n);
      squares[i][2] = 2*n + n*layer + ((i+n-1) % n);
      squares[i][3] = n+i;
    }
  }
  
  void generateControlPoints(){
    p = new PVector[n*m];
    squares = new int[(m-2)*n][4];
    
    int idx = 0;
    for(int j=0; j<m; j++){
      for(int i=0 ;i<n; i++){
        float x = r*cos(TAU*(float)i/(float)n + (float)j*PI/(float)n);
        float y = r*sin(TAU*(float)i/(float)n + (float)j*PI/(float)n);
        float z = (float)j*(h/(float)(m-1)) - h/2;
        p[idx++] = new PVector(x, y, z);
      }
    }
    for(int i=0; i<squares.length; i++){
      int layer = i/n;
      squares[i][0] = i;
      squares[i][1] = n + n*layer + ((i+n-1) % n);
      squares[i][2] = 2*n + n*layer + ((i+n-1) % n);
      squares[i][3] = n+i;
    }
  }
  
  void draw(){
    shape(shape);
  }
  
  void generateShape(){
    shape = createShape();
    shape.beginShape(TRIANGLES);
    for(int i=0; i<squares.length; i++){
      PVector p0 = p[squares[i][0]];
      PVector p1 = p[squares[i][1]];
      PVector p2 = p[squares[i][2]];
      PVector p3 = p[squares[i][3]];
      
      shape.vertex(p0.x, p0.y, p0.z);
      shape.vertex(p1.x, p1.y, p1.z);
      shape.vertex(p3.x, p3.y, p3.z);
      shape.vertex(p3.x, p3.y, p3.z);
      shape.vertex(p1.x, p1.y, p1.z);
      shape.vertex(p2.x, p2.y, p2.z);
    }
    shape.endShape();
  }
  
  void generateComplexShape(int res){
    shape = createShape();
    shape.beginShape(TRIANGLES);
    shape.stroke(120);
    for(int k=0; k<squares.length; k++){
      PVector q00 = p[squares[k][0]];
      PVector q10 = p[squares[k][1]];
      PVector q11 = p[squares[k][2]];
      PVector q01 = p[squares[k][3]];
      
      shape.fill(random(170, 240));
      
      for(int i=1; i<=res; i++){
        for(int j=1; j<=res; j++){
          float s0 = (float)(i-1)/(float)res;
          float s1 = (float)(i)/(float)res;
          float t0 = (float)(j-1)/(float)res;
          float t1 = (float)(j)/(float)res;
          
          PVector p00 = createPoint(q00, q01, q10, q11, s0, t0);
          PVector p01 = createPoint(q00, q01, q10, q11, s0, t1);
          PVector p10 = createPoint(q00, q01, q10, q11, s1, t0);
          PVector p11 = createPoint(q00, q01, q10, q11, s1, t1);
          
          shape.vertex(p00.x, p00.y, p00.z);
          shape.vertex(p10.x, p10.y, p10.z);
          shape.vertex(p11.x, p11.y, p11.z);
          shape.vertex(p00.x, p00.y, p00.z);
          shape.vertex(p11.x, p11.y, p11.z);
          shape.vertex(p01.x, p01.y, p01.z);
        }
      }
    }
    shape.endShape();
  }
  
  PVector createPoint(PVector p00, PVector p01, PVector p10, PVector p11, float s, float t){
    float x = (p01.x*s + p00.x*(1-s))*t + (p11.x*s + p10.x*(1-s))*(1-t);
    float y = (p01.y*s + p00.y*(1-s))*t + (p11.y*s + p10.y*(1-s))*(1-t);
    float z = (p01.z*s + p00.z*(1-s))*t + (p11.z*s + p10.z*(1-s))*(1-t);
    return new PVector(x, y, z);
  }
}