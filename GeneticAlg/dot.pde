class Dot {
  PVector position;
  PVector velocity;
  PVector acceleration;
  Brain brain;

  boolean isBest = false;
  boolean dead = false;
  boolean reachedGoal = false;
  
  
  PVector rectCoords = new PVector(100, 300);
  
  float fitness =0;
  Dot() {
    brain = new Brain(400);
    position = new PVector(width/2, height-2);
    velocity = new PVector(0, 0);
    acceleration = new PVector(0, 0);
  }

  void show() {
    if(isBest){
      fill(255, 100, 0);
      ellipse(position.x, position.y, 16, 16);
    }
    
    fill(0);
    ellipse(position.x, position.y, 4, 4);
  }

  void move() {
    if (brain.directions.length > brain.step) {
      acceleration = brain.directions[brain.step];
      brain.step++;
    }
    else{
      dead =true;
    }
    velocity.add(acceleration);
    velocity.limit(5);
    position.add(velocity);
  }

  void update() {
    if (!dead && !reachedGoal) {
      move();

      if (position.x<2|| position.y<2 || position.x>width-2 || position.y>height -2) {
        dead = true;
      }
      else if(dist(position.x, position.y, goal.x, goal.y)<5){
        reachedGoal=true;
      }
      else if(position.x<rectCoords.x+500 && position.y<rectCoords.y+10 && position.x > rectCoords.x && position.y >rectCoords.y){
        dead = true;
      }
        
    }
  }
  
  void calculateFitness(){ //how well the dots did
    if(reachedGoal){
      fitness = 1.0/16.0+ 10000.0/(float)(brain.step *brain.step);
      
    }
    else {
      float distanceToGoal = dist(position.x, position.y, goal.x, goal.y);
      fitness = 1.0/(distanceToGoal + distanceToGoal);
    }
  }

  Dot offspringGen(){
    Dot baby = new Dot();
    baby.brain = brain.clone();
    return baby;
  }
}
