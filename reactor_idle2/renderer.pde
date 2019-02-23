class Renderer {
  float _height;
  float _width;
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
  private boolean has_text = false;
  private String text;


  void set_coords(PVector coords) {
    x = coords.x;
    y = coords.y;
  }

  void set_dimensions(PVector dimensions) {
    _width = dimensions.x-1;
    _height = dimensions.y-1;
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

  void is_text() {
    has_text = true;
  }

  void update_text(String str) {
    text = str;
  }

  boolean is_pressed() {
    return (x < mouseX && mouseX < x+_width) &&
      (y < mouseY && mouseY < y+_height);
  }


  void render() {
    if (has_image) {
      image(image, x, y, _width, _height);
    } else {
      if (!( _color == 0)) {
        stroke(_color);
        fill(_color);
      }

      stroke(outlines);
      rect(x, y, _width, _height, radius_corner1, radius_corner2, radius_corner3, radius_corner4);
      if (has_text) {
        textAlign(CENTER, CENTER);
        text(text, x, y);
      }
    }
  }
}
