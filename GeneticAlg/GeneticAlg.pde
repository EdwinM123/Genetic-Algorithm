Population test; 
PVector goal = new PVector(400, 10);

void setup(){
  size(800, 800);
  test = new Population(1000);
}

void draw(){
  background(255);
  fill(255, 0, 0);
  ellipse(goal.x, goal.y, 10, 10);
  
  PVector rectCoords = new PVector(100, 300);
  fill(255, 0, 0);
  rect(rectCoords.x, rectCoords.y, 500, 10);
  
  if(test.allDotsDead()){
    test.calculateFitness();
    test.naturalSelection();
    test.mutateBabies();
  }
  else{
    test.update();
    test.show();
  }
}
