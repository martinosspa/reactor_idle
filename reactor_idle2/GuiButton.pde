class GuiButton extends GuiComponent{
  float _width;
  float _height;
  GuiButton(float x, float y) {
    super(x, y);
  }


  void setMode(int mode) {
    // mode 0 is a just a normal button that triggers an action
    // mode 1 is a boolean button
  }
  void setDimensions(float w, float h) {
    _width = w;
    _height = h;
  }

  boolean is_pressed() {
    return (x < mouseX && mouseX < x+_width) &&
      (y < mouseY && mouseY < y+_height);
  }
}
