class Component {
  int x, y, price;
  PImage image;
  float cost = 0;
  boolean alive = true;



  Component(int x, int y) {
    this.x = x;
    this.y = y;
  }


  void set_image(PImage image_) {
    image = image_;
  }

  void render() {
    if (image != null) {
      image(image, x*gridSizeX, y*gridSizeY, gridSizeX, gridSizeY);
    }
  }

  void tick() {
  }

  boolean alive() {
    return alive;
  }

  void place() {
    // action processed only when firstly placed
    // placeholder
  }

  boolean buyable() {
    return player.balance - cost >= 0;
  }
}
