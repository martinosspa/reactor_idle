class Renderer {
  float height;
  float width;
  private float x;
  private float y;
  private color _color;
  private float radius_corner1;
  private float radius_corner2;
  private float radius_corner3;
  private float radius_corner4;
  private color outlines;
  private PImage image;
  private boolean has_image = false;
  private boolean is_button = false;
  void set_coords(PVector coords) {
    x = coords.x;
    y = coords.y;
  }
  void set_dimensions(PVector dimensions) {
    this.width = dimensions.x-1;
    this.height = dimensions.y-1;
  }
  void set_color(color c) {
    _color = c;
  }
  void set_corner_radius(int corner, float radius) {
    switch(corner) {
    case 1:
      radius_corner1 = radius;
      break;
    case 2:
      radius_corner2 = radius;
      break;
    case 3:
      radius_corner3 = radius;
      break;
    case 4:
      radius_corner4 = radius;
      break; 
    case 5:
      radius_corner1 = radius;
      radius_corner2 = radius;
      radius_corner3 = radius;
      radius_corner4 = radius;
      break;
    }
  }
  void set_outline(color c) {
    outlines = c;
  }

  void set_image(PImage img) {
    has_image = true;
    image = img;
  }

  void set_button() {
    is_button = true;
  }

  boolean is_pressed() {
    return (x < mouseX && mouseX < x+this.width) &&
      (y < mouseY && mouseY < y+this.height);
  }


  void render() {
    if (has_image) {
      image(image, x, y, this.width, this.height);
    } else {
      if (!( _color == 0)) {
        fill(_color);
      }
      stroke(outlines);
      rect(x, y, this.width, this.height, 
        radius_corner1, radius_corner2, 
        radius_corner3, radius_corner4);
    }
  }
}
