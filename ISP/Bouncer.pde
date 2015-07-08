class Bouncer implements Enemy {
  float xCor, yCor;

  Bouncer() {
    xCor = random(0, XSIZE);
    yCor = random(0, YSIZE);
  }

  float xCor() {
    return xCor;
  }
  float yCor() {
    return yCor;
  }

  boolean detect() {
    if ( dist(xCor, yCor, pxCor, pyCor) < YSIZE/5 ) {
      return true;
    }
    return false;
  }

  void attack() { //nearly identical to Player class' "move()" method
    float speedX = (xCor - pxCor) / 50;
    float speedY = (yCor - pyCor) / 50;

    float speed = sqrt(speedX*speedX + speedY*speedY);

    speedX = (2*speedX)/speed;
    speedY = (2*speedY)/speed;
    xCor -= speedX;
    yCor -= speedY;
  }

  boolean isAlive() {//Still needs work
    return true;
  }

  void act() {
    if (isAlive()) {
      display();
      if (detect())
        attack();
    } else
      dying();
  }

  void dying() {
  }
  void event(Enemy e) {
  }

  void display() {
    fill(0);
    ellipse(xCor, yCor, 50, 80);
  }
}

