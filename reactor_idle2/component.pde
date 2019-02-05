class Component {
  int x, y, price;
  PImage image;



  Component(int x, int y) {
    this.x = x;
    this.y = y;
  }


  void set_image(PImage image_) {
    image = image_;
  }

  void render() {
    image(image, x*gridSizeX, y*gridSizeY, gridSizeX, gridSizeY);
  }
}
