import java.util.List;

ArrayList<PVector> loadData(String path){
  ArrayList<PVector> points = new ArrayList<PVector>();
  
  File[] files = new File(path).listFiles();
  
  for(File file : files){
    List<GpsEntry> entries = GpsReader.getGpsEntries(file.getAbsolutePath());
    println(file.getAbsolutePath());
    if(entries.size() <= 0) return null;
    
    for(GpsEntry entry : entries){
      float x = entry.getLongitude();
      float y = entry.getLatitude();
      float z = entry.getElevation();
      points.add(new PVector(x, y, z));
    }
  }
  return points;
}

void drawPoints(ArrayList<PVector> points){
  if(points.size() <= 0) return;
  
  // Find min and max value
  float minX = points.get(0).x;
  float maxX = points.get(0).x;
  float minY = points.get(0).y;
  float maxY = points.get(0).y;

  for(PVector point : points){
    if(point.x < minX) minX = point.x;
    if(point.y < minY) minY = point.y;
    if(point.x > maxX) maxX = point.x;
    if(point.y > maxY) maxY = point.y;
  }
  
  // Draw lines
  int b = (int)(min(height, width)*0.1); // Border
  for(PVector point : points){
    ellipse(map(point.x, minX, maxX, b, width-b),
            map(point.y, minY, maxY, height-b, b), 
            0.2, 0.2);
  }
}

PShape pointShape(ArrayList<PVector> points, float wX, float wY, float wZ){
  if(points.size() <= 0) return new PShape();
  
  // Find min and max values
  PVector pMin = new PVector(points.get(0).x, points.get(0).y, points.get(0).z);
  PVector pMax = new PVector(points.get(0).x, points.get(0).y, points.get(0).z);
  
  for(PVector point : points){
  //for(int i=0; i<n; i++){    
    if(point.x < pMin.x) pMin.x = point.x;
    if(point.y < pMin.y) pMin.y = point.y;
    if(point.z < pMin.z) pMin.z = point.z;
    if(point.x > pMax.x) pMax.x = point.x;
    if(point.y > pMax.y) pMax.y = point.y;
    if(point.z > pMax.z) pMax.z = point.z;
  }
  
  println(pMin);
  println(pMax);
  
  PShape s = createShape();
  s.beginShape(POINTS);
  for(PVector point : points){
    float x = map(point.x, pMin.x, pMax.x, -wX, wX);
    float y = map(point.y, pMin.y, pMax.y, wY, -wY); // flip coordinate
    float z = map(point.z, pMin.z, pMax.z, -wZ, wZ);
    s.vertex(x, y, z);
  }
  s.endShape();
  return s;
}