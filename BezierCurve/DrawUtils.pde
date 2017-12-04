
float[] rand(int n, int r_low, int r_high){
  float[] numbers = new float[n];
  for(int i = 0; i < n; i++){
    numbers[i] = random(r_low, r_high);
  }
  return numbers;
}

void drawGraph(float[] numbers) {
  // find min, max
  float min =  10000000;
  float max = -10000000;
  for(int i = 0; i < numbers.length; i++) {
    if(numbers[i] < min) min = numbers[i];
    if(numbers[i] > max) max = numbers[i];
  }
  
  for(int i = 1; i < numbers.length; i++){
    line(map(i-1, 0, numbers.length-1, 0, width), 
         map(numbers[i-1], min, max, 0, height),
         map(i, 0, numbers.length-1, 0, width), 
         map(numbers[i], min, max, 0, height));
  }
}

void drawGraph(float[] numbers, float min, float max) {
  for(int i = 1; i < numbers.length; i++){
    line(map(i-1, 0, numbers.length-1, 0, width), 
         map(numbers[i-1], min, max, 0, height),
         map(i, 0, numbers.length-1, 0, width), 
         map(numbers[i], min, max, 0, height));
  }
}
