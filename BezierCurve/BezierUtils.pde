
float DeCasteljau(float[] controlPoints, float t) {
  float[] p = new float[controlPoints.length];
  arrayCopy(controlPoints, p);
  int d = p.length-1; // degree of the Bezier curve
  
  for(int i = 1; i <= d; ++i){
    for(int j = 0; j <= d - i; ++j){
      p[j] = (1 - t) * p[j] + t * p[j + 1];
    }
  }
  return p[0];
}

float[] bezierCurve(float[] controlPoints, int resolution) {
  float[] points = new float[resolution];
  float t;
  for(int i = 0; i < resolution; i++){
    t = (float) i / (float) (resolution - 1);
    points[i] = DeCasteljau(controlPoints, t);
  }
  return points;
}
