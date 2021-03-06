class Railgun implements Powerup {
  float xCor, yCor;
  float setXCor, setYCor;
  int step;
  boolean activated;

  Railgun() {
    xCor = random(XSIZE/20, XSIZE*19/20);
    yCor = random(YSIZE/20, YSIZE*19/20);
    step = 60;
    activated = false;
  }

  Railgun(int i) {
    step = 60;
    activated = false;
    xCor = pxCor;
    yCor = pyCor;
  }

  boolean detect() {
    return( dist(xCor, yCor, pxCor, pyCor) <  50 );
  }

  boolean detect(Enemy e) {
    return dist(xCor, yCor, e.xCor(), e.yCor()) <  50 && e.isAlive();
  }

  boolean event(Enemy e) {
    if (detect()&&!activated) {
      setXCor=xCor+(pxCor-xCor);
      setYCor=yCor+(pyCor-yCor);
      activated = true;
    }    
    if (activated & detect(e)) {
      return true;
    }
    return false;
  }

  void moving() {
    float speedX = (xCor - setXCor);
    float speedY = (yCor - setYCor);

    float speed = sqrt(speedX*speedX + speedY*speedY);

    speedX = (step*speedX)/speed;
    speedY = (step*speedY)/speed;

    xCor += speedX;
    yCor += speedY;
  }
  boolean checkBounds() {
    if ( xCor < 0 || xCor > XSIZE) 
      return true;
    if ( yCor < 0 || yCor > YSIZE)
      return true;
    return false;
  }

  void display() {
    if (activated)
      gunMoving.show(xCor, yCor, 2); 
    else
      image(railgun, xCor, yCor);
  }

}

