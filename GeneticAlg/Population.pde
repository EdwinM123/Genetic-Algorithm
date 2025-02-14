class Population{
  Dot[] dots;
  float fitnessSum;
  int gen =1;
  
  int bestDot=0;
  int bestStep=400;
  
  Population(int size){
    dots = new Dot[size];
    for(int i=0; i<size; i++){
      dots[i] = new Dot();
    }
  }
  
  void show(){
    for(int i=0; i<dots.length; i++){
      dots[i].show();
    }
    dots[0].show();
  }
  
  void update(){
    for(int i=0; i<dots.length; i++){
      if(dots[i].brain.step>bestStep){
        dots[i].dead = true;
      }
      dots[i].update();
    }
  }
    
    
  void calculateFitness(){
    for(int i=0; i<dots.length; i++){
      dots[i].calculateFitness();
    }
  }
  
  boolean allDotsDead(){
    for(int i=0; i<dots.length; i++){
      if(!dots[i].dead && !dots[i].reachedGoal){
        return false;
      }
    }
    return true;
  }
  
  void naturalSelection(){
    Dot[] newDots = new Dot[dots.length];
    setBestDot();
    calculateFitnessSum();
    
    newDots[0] =dots[bestDot].offspringGen();
    newDots[0].isBest =true;
    
    for(int i=1; i< newDots.length; i++){//0 == champion btw
      Dot parent = selectParent();

      newDots[i] = parent.offspringGen();

    }
    dots = newDots.clone();
    gen++;
    
  }
  void calculateFitnessSum(){
    fitnessSum = 0;
    for(int i=0; i<dots.length; i++){
     fitnessSum+=dots[i].fitness;
    }
  }
  Dot selectParent(){
    float rand = random(fitnessSum);

    float runningSum=0;

    for(int i=0; i<dots.length; i++){
      runningSum += dots[i].fitness;
      if(runningSum>rand){
        return dots[i];
      }
    }
    return null;
  }

  void mutateBabies(){
    for(int i=1; i<dots.length; i++){
      dots[i].brain.mutate();
    }
  }
  
  
  
  void setBestDot(){
    float max = 0; 
    int maxIndex=0; 
    for(int i=0; i<dots.length; i++){
      if(dots[i].fitness >max){
        max = dots[i].fitness;
        maxIndex=i;
      }
    }
    
    
    bestDot=maxIndex;
    
    if(dots[bestDot].reachedGoal){
      bestStep = dots[bestDot].brain.step;
      println("step:", bestStep);
    }
    
    
  }
}
