class Mine implements Powerup {
  float xCor, yCor;
  boolean activated;
  boolean exploded;

  Mine() {
    xCor = random(0, XSIZE);
    yCor = random(0, YSIZE);
    activated = false;
    exploded = false;
  }

  void dying() {
  }

  boolean detect() {
    return( dist(xCor, yCor, pxCor, pyCor) <  35 );
  }

  boolean detect(Enemy e) {
    return( dist(xCor, yCor, e.xCor(), e.yCor()) <  35 );
  }

  boolean event(Enemy e) {
    if (detect()) {
      activated = true;
    }
    if (activated&&!exploded) {
      if (detect(e)) {
        exploded = true;
        return true;
      }
    }
    return false;
  }

  void display() {
    if (activated&&!exploded)
      fill(#E80000);
    else 
      fill(#D8B8B8);
    if (!exploded)
      ellipse(xCor, yCor, 50, 50);
  }
}
