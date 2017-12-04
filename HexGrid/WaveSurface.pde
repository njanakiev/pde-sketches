class WaveSurface{
  int n;
  float ratio;
  ArrayList<Wave> waves;
  
  WaveSurface(){
    n = 1;
    ratio = float(width)/float(height);
    println(ratio);
    waves = new ArrayList<Wave>();
    waves.add(new Wave(-0.5*ratio, -0.5, 2.5, 1, 0));
  }
  
  WaveSurface(int n){
    this.n = n;
    ratio = float(width)/float(height);
    waves = new ArrayList<Wave>();
    
    float r = 3;
    
    for(int i=0; i<n; i++){
      float kx = random(-r*ratio, r*ratio);
      float ky = random(-r, r);
      float kt = int(random(3));
      float a = 1;
      float phi = random(TAU);
      
      waves.add(new Wave(kx, ky, kt, a, phi));
    }
  }
  
  float getValue(float u, float v, float w){
    float value = 0;
    for(Wave wave : waves){
      value += wave.a*sin(TAU*wave.kx*u + TAU*wave.ky*v + TAU*wave.kt*w + wave.phi)/float(n);
    }
    return value;
  }
}

class Wave{
  float kx, ky, kt;
  float a, phi;
  
  Wave(float kx, float ky, float kt, float a, float phi){
    this.kx = kx;
    this.ky = ky;
    this.kt = kt;
    
    this.a  = a;
    this.phi = phi;
  }
}