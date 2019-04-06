class ComponentGenerator extends Component implements ComponentData {
  int type;
  boolean alive = true;
  boolean removedMoney = false;
  float generationPerSecond;
  int lifetimeMax;
  int lifetimeCurrent;
  float cost;
  ComponentGenerator(int x, int y, int type) {
    super(x, y);
    this.x = x;
    this.y = y;
    this.type = type;
    lifetimeMax = ComponentData.componentLifetime[type];
    lifetimeCurrent = lifetimeMax;


    switch(type) {
    case 1:
      generationPerSecond = ComponentData.generate_amount[type];
      cost = ComponentData.componentPrices[type];
      break;
    }
  }



  void render() {
    if (!alive) {
      tint(255, 150);
    } else {
      tint(255, 255);
    }

    if (image != null) {
      image(image, x*gridSizeX, y*gridSizeY, gridSizeX, gridSizeY);
    }

    if (alive) {
      stroke(255, 0, 0);
      line(x*gridSizeX + 3, (y+1)*gridSizeY - 1, (x+1)*gridSizeX - 3, (y+1)*gridSizeY - 1);
      stroke(0, 255, 0);
      float offsetX = (gridSizeX-6)*lifetimeCurrent/lifetimeMax;
      float startX = x*gridSizeX + 3;
      line(startX, (y+1)*gridSizeY - 1, startX + offsetX, (y+1)*gridSizeY - 1);
    }
  }

  void tick() {
    if (lifetimeCurrent <= 0) {
      alive = false;
    } else { 
      lifetimeCurrent--;
    }
    if (!alive && !removedMoney) {
      removeMoney();
      removedMoney = true;
    }
  }


  void place() {
    player.addMoneyPerSecond(generationPerSecond);
    player.balance -= cost;
  }

  private void removeMoney() {
    player.removeMoneyPerSecond(generationPerSecond);
  }

  boolean buyable() {
    return player.balance - cost >= 0;
  }
}
