class SpringGridSimulation{
  int n, m;
  float k, d, dt, r;
  PVector points[][];
  float sumZ[][];
  float z0[][];
  float w0[][];
  float w1[][];
  
  SpringGridSimulation(int n, int m){
    this.n = n;
    this.m = m;
    this.k = 400;
    this.d = 2;
    this.r = 500.0f / max(n, m);
    this.dt = 0.01;
    
    points = new PVector[n][m];
    sumZ = new float[n][m];
    
    z0 = new float[n][m];
    w0 = new float[n][m];
    w1 = new float[n][m];
    
    generate();
  }
  
  void next(){
    for(int i=0; i<n; i++){
      for(int j=0; j<m; j++){
        sumZ[i][j] += points[i][j].z;
      }
    }
    
    for(int i=1; i<n-1; i++){
      for(int j=1; j<m-1; j++){
        float dx = k*(sumZ[i-1][j] + sumZ[i+1][j]
                     +sumZ[i][j-1] + sumZ[i][j+1]
                     -4*sumZ[i][j])*dt;
        // Diagonals
        dx += k*(sumZ[i-1][j] + sumZ[i+1][j]
                +sumZ[i][j-1] + sumZ[i][j+1]
                -4*sumZ[i][j])*dt;
        // Damping
        dx -= d*points[i][j].z;

        points[i][j].z += dx*dt;
      }
    }
  }
  
  void next2(){
    float g = 10;
    for(int i=1; i<n-1; i++){
      for(int j=1; j<m-1; j++){
        z0[i][j] = points[i][j].z;
        w0[i][j] = w1[i][j];
      }
    }
    
    // Midpoint Method
    float wTmp[][] = new float[n][m];
    float zTmp[][] = new float[n][m];
    for(int i=1; i<n-1; i++){
      for(int j=1; j<m-1; j++){
        zTmp[i][j] = z0[i][j] + w0[i][j]*dt;
        float diff = zTmp[i-1][j] + zTmp[i+1][j]
                    +zTmp[i][j-1] + zTmp[i][j+1]
                    -4*zTmp[i][j];
        wTmp[i][j] = w0[i][j] + (k*diff - d*w0[i][j])*dt;
        
      }
    }
    for(int i=1; i<n-1; i++){
      for(int j=1; j<m-1; j++){
        float diff = z0[i-1][j] + z0[i+1][j]
                    +z0[i][j-1] + z0[i][j+1]
                    -4*z0[i][j];
        w1[i][j] = w0[i][j] + 
                      (k*diff - d*0.5*(w0[i][j]+wTmp[i][j]))*dt;
        points[i][j].z = z0[i][j] + 
                         0.5*(w0[i][j]+wTmp[i][j])*dt;
      }
    }
    
    // Euler's Method
    //for(int i=1; i<n-1; i++){
    //  for(int j=1; j<m-1; j++){
    //    float diff = z0[i-1][j] + z0[i+1][j]
    //                +z0[i][j-1] + z0[i][j+1]
    //                -4*z0[i][j];
    //    w1[i][j] = w0[i][j] + (k*diff - d*w0[i][j])*dt;
    //    points[i][j].z = z0[i][j] + w0[i][j]*dt;
    //  }
    //}
  }
  
  void generate(){
    for(int i=0; i<n; i++){
      for(int j=0; j<m; j++){
        float x = float(i)*r - r*float(m)/2;
        float y = float(j)*r - r*float(m)/2;
        float z = 0.001*(x*x - y*y);//2*r*random(-1,1);
        //float z = 0;
        points[i][j] = new PVector(x, y, z);
      }
    }
  }
  
  void impulse(){
    int i = int(random(1,n-1));
    int j = int(random(1,m-1));
    points[i][j].z += 5*r;
  }
  
  void impulse(int r){
    int centerI = int(random(r+1,n-r-1));
    int centerJ = int(random(r+1,m-r-1));
    for(int i=centerI-r; i<centerI+r; i++){
      for(int j=centerJ-r; j<centerJ+r; j++){
        points[i][j].z += 5*this.r;
      }
    }
  }
  
  void randomize(){
    for(int i=0; i<n; i++){
      for(int j=0; j<m; j++){
        points[i][j].z = random(-3*r, 3*r);
      }
    }
  }
  
  void drawWire(){
    for(int i=1; i<n; i++){
      for(int j=1; j<m; j++){
        PVector p00 = points[i-1][j-1];
        PVector p01 = points[i-1][j];
        PVector p10 = points[i][j-1];
        PVector p11 = points[i][j];
        
        line(p00.x, p00.y, p00.z,
             p01.x, p01.y, p01.z);
        line(p00.x, p00.y, p00.z,
             p10.x, p10.y, p10.z);
        line(p01.x, p01.y, p01.z,
             p11.x, p11.y, p11.z);
        line(p10.x, p10.y, p10.z,
             p11.x, p11.y, p11.z);
      }
    }
  }
  
  void draw(){
    beginShape(TRIANGLES);
    for(int i=1; i<n; i++){
      for(int j=1; j<m; j++){
        PVector p00 = points[i-1][j-1];
        PVector p01 = points[i-1][j];
        PVector p10 = points[i][j-1];
        PVector p11 = points[i][j];
        
        vertex(p00.x, p00.y, p00.z);
        vertex(p10.x, p10.y, p10.z);
        vertex(p01.x, p01.y, p01.z);
        vertex(p10.x, p10.y, p10.z);
        vertex(p01.x, p01.y, p01.z);
        vertex(p11.x, p11.y, p11.z);
      }
    }
    endShape();
  }
}
