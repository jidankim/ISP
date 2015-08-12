class BackAndForth implements Enemy {  
  float xCor, yCor;
  int direction;
  int step;
  boolean avoid, isAlive, spawning;
  int myPlace, inLife;
  int tempFrameCount;
  int iBafCounter;
  int deathCounter, spawnCounter;
  boolean invincible;
  int invinMillis;

  BackAndForth() {
    xCor = random(0, XSIZE);
    yCor = random(0, YSIZE);
    direction = (int)random(4f);
    avoid = false;
    isAlive = true;
    tempFrameCount = 0;
    step = 10;// may change to increase speed
    deathCounter = 14;
    spawnCounter = 10;
    spawning = true;
    invincible = false;
  }

  BackAndForth(float x, float y, float speedX, float speedY) {
    xCor = x;
    yCor = y;
    direction = (int)random(4f);
    avoid = false;
    isAlive = true;
    tempFrameCount = 0;
    iBafCounter = 0;
    step = 5;// may change to increase speed
    deathCounter = 14;
    invincible = true;
    invinMillis = millis();
  }

  float xCor() {
    return xCor;
  }

  float yCor() {
    return yCor;
  }

  boolean isAlive() {
    return isAlive;
  }
  
  boolean invincible(){
    return invincible;
  }

  boolean detect() {
    if (xCor >= XSIZE) {
      //direction = 0;//left
      direction = (int)random(3f);
      if (direction > 0) {
        direction++; //only 0,2, or 3
      }
      xCor -= step; // to move away from the border so it doesn't get caught here again
    } else if (xCor <= 0) {
      // direction = 1;//right
      direction = (int)random(3f);
      direction ++; //only 1,2, or 3
      xCor += step; // same as xCor-=step
    } else if (yCor >= YSIZE) {
      //direction = 2;//up
      direction = (int)random(3f); // only 0, 1, 2
      yCor -= step; // same as xCor-=step
    } else if (yCor <= 0) {
      //direction = 3;//down
      direction = (int)random(3f);
      if (direction == 2) {
        direction ++; // only 0,1, or 3
      }
      yCor+=step; // same as xCor-=step
    }

    if (avoid) { 
      if (xCor <= step) {
        direction = 1;
      } else if (xCor >= XSIZE-step) {
        direction = 0;
      } else if (yCor <= step) {
        direction = 3;
      } else if (yCor >= YSIZE-step) {
        direction = 2;
      }
      avoid = false;
    }
    return true;
  }

  void attack() {
    detect();
    if (direction % 4 == 0) //left
      xCor -= step;                                
    else if (direction % 4 == 1) //right
      xCor += step;
    else if (direction % 4 == 2) //up
      yCor -= step;
    else //down
    yCor += step;
  }

  boolean collide(Enemy e) {
    return dist( xCor, yCor, e.xCor(), e.yCor() ) < 30;
  }

  void event(Enemy e, int i, int j) {
    if (collide(e)) {
      if (random(10) < 3) { //30% chance of merging
        merge(e, i, j);
      } else { //if it doesn't merge, goes off border
        avoid = true;
      }
    }
  }

  void merge(Enemy e, int i, int j) {
    Bouncer temp = new Bouncer(xCor, yCor);
    enemies[2].add(temp);
    enemies[1].remove(j);
    enemies[1].remove(i);
  }

  void dead(int i, int j) {
    myPlace = i;
    inLife = j;
//    println(iBafCounter);
    if (isAlive){// && iBafCounter >= fps*3) {
      //println("comp");
      //tempFrameCount = counter;
      tempFrameCount = millis();
      isAlive = false;
    }
  }

  void dying() {

    if (!isAlive) {
      baf_dying.show(xCor, yCor, 4);
      deathCounter--;
      if (deathCounter < 0) {
        //if (counter >= tempFrameCount) {
        if (inLife>=enemies[myPlace].size())
          inLife = enemies[myPlace].size()-1;
        enemies[myPlace].remove(inLife);
        score += 10;
      }
    }
  }

  void act() {
    if ( invincible && invinMillis+1000 > millis()) {
      invincible = false;
    }
    if (spawning) {
      baf_spawning.show(xCor, yCor, 20);
      spawnCounter--;
      if (spawnCounter < 0) {
        spawning = false;
      }
    } else if (isAlive) {
      if (xCor < pxCor + displayWidth/2 && xCor > pxCor - displayWidth/2 && yCor < pyCor + displayHeight/2 && yCor > pyCor - displayHeight/2)
        display();
      attack();
    } else {
      dying();
    }
  }

  void display() {//display() should only display
    if (spawning) {
    } else if (direction % 4 == 2 || direction % 4 == 3) {
      baf_moving_vert.show(xCor, yCor, 10);
    } else {
      baf_moving_hori.show(xCor, yCor, 10);
    }
  }
}

