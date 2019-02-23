class ComponentGenerator extends Component {
  int type;
  boolean alive = true;
  float generationPerSecond;
  int lifetimeMax;
  int lifetimeCurrent;
  ComponentGenerator(int x, int y, int type) {
    super(x, y);
    this.x = x;
    this.y = y;
    this.type = type;
    lifetimeMax = data.componentLifetime[type];
    lifetimeCurrent = lifetimeMax;


    switch(type) {
    case 1:
      generationPerSecond = data.generate_amount[type];
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
  }
  
  
  void place() {
    player.addMoneyPerSecond(generationPerSecond);
  }
}
