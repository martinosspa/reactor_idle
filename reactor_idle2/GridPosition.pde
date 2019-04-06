class GridPosition {
  int x;
  int y;
  boolean taken = false;
  Component component;

  GridPosition(int x, int y) {
    this.x = x;
    this.y = y;
  }


  boolean place_component(Component comp) {
    // returns error value
    if (taken) {
      return true;
    } else {
      if (comp.buyable()) {

        taken = true;
        component = comp;
        component.place();
        return false;
      } else {
        println("low balance");
        return true;
      }
    }
  }


  void render() {
    if (taken) {
      component.render();
    }
  }

  boolean taken() {
    return taken;
  }

  boolean alive() {
    return component.alive();
  }

  void tick() {
    component.tick();
  }
}
