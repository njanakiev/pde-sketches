void drawParametricCurve_01(float t1){
  float r = 150;
  float R = 10;
  float t0 = 0;
  int n = 4;
  int m = 10;
  
  for(int j=0; j<m; j++){
    float v = float(j)/float(m);
    float x = R*cos(TAU*(t0 + t1));
    float y = R*sin(TAU*(t0 + t1));
    float z = R*sin(TAU*(t0 + t1));
    
    for(int i=0; i<n; i++){
      float u0 = float(i)/float(n);
      float u1 = float(i+1)/float(n);
      
      float x0 = x + r*sin(TAU*u0)*cos(PI*v - PI/2);
      float y0 = y + r*cos(TAU*u0)*cos(PI*v - PI/2);
      float z0 = z + r*sin(PI*v - PI/2);
      
      float x1 = x + r*sin(TAU*u1)*cos(PI*v - PI/2);
      float y1 = y + r*cos(TAU*u1)*cos(PI*v - PI/2);
      float z1 = z + r*sin(PI*v - PI/2);
      
      line(x0, y0, z0, x1, y1, z1);
    }
    t0 += 1/float(m);
  }
}

void drawParametricCurve_02(float t1){
  float r = 70;
  float R = 90;
  float r0 = 10;
  float t0 = 0;
  int n = 4;
  int m = 30;
  
  for(int j=0; j<m; j++){
    float v = float(j)/float(m);
    float x = r0*cos(TAU*(t0 + t1));
    float y = r0*sin(TAU*(t0 + t1));
    float z = r0*sin(TAU*(t0 + t1));
    
    for(int i=0; i<n; i++){
      float u0 = float(i)/float(n);
      float u1 = float(i+1)/float(n);
      
      float x0 = x + sin(TAU*u0)*(R + r*cos(TAU*v));
      float y0 = y + cos(TAU*u0)*(R + r*cos(TAU*v));
      float z0 = z + r*sin(TAU*v);
      
      float x1 = x + sin(TAU*u1)*(R + r*cos(TAU*v));
      float y1 = y + cos(TAU*u1)*(R + r*cos(TAU*v));
      float z1 = z + r*sin(TAU*v);
      
      line(x0, y0, z0, x1, y1, z1);
    }
    t0 += 1/float(m);
  }
}