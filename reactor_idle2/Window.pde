class Window {
  float _height;
  float _width;
  float x;
  float y;
  private color _color;
  private float radius_corner1;
  private float radius_corner2;
  private float radius_corner3;
  private float radius_corner4;
  private color outlines;

  ArrayList<GuiComponent> components = new ArrayList<GuiComponent>();

  Window(float x, float y, float w, float h) {
    this.x = x;
    this.y = y;
    _width = w;
    _height = h;
  }

  void set_color(color c) {
    _color = c;
  }

  void setCornerRadius(int corner, float radius) {
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

  void addComponent(GuiComponent g) {
    components.add(g);
  }

  void render() {
    if (!( _color == 0)) {
      stroke(_color);
      fill(_color);
    }
    stroke(outlines);
    rect(x, y, _width, _height, radius_corner1, radius_corner2, radius_corner3, radius_corner4);
    pushMatrix();
    translate(x, y);
    for (GuiComponent g : components) {
      g.render();
    }
    popMatrix();
  }
}
