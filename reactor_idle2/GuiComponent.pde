class GuiComponent {
  float x;
  float y;
  Window parentWindow;
  GuiComponent(float x, float y) {
    this.x = x;
    this.y = y;
  }


  void render() {
    // place holder for sub classes
  }

  void setParentWindow(Window w) {
    parentWindow = w;
  }
  
  
  void update() {
    //place holder
    
  }
}
