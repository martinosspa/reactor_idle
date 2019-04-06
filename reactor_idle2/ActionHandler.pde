class ActionHandler {
  int mouseGridX = -1;
  int mouseGridY = -1;
  boolean mouse_over(float x, float y, float _width, float _height) {
    return (x < mouseX && y < mouseY) && (mouseX > x + _width && mouseY > y + _height);
  }


  void tick() {
    mouseGridX = (int) mouseX / int(gridSizeX);
    if (mouseY < toolbar._height) {
      mouseGridY = -1;
    } else {
      mouseGridY = (int) (mouseY-toolbar._height) / int(gridSizeY);
    }
    if (mousePressed && mouseInGrid()) {
      if (!grid.gridComponents[mouseGridX][mouseGridY].taken) {
        ComponentGenerator c = new ComponentGenerator(mouseGridX, mouseGridY, 1);
        if (c.buyable()) {
          grid.gridComponents[mouseGridX][mouseGridY].place_component(c);
          grid.gridComponents[mouseGridX][mouseGridY].component.set_image(sprite_handler.get_image(selected_component));
        }
        //println("placed a component at " + mouseGridX + " "+ mouseGridY);
      } else if (!grid.gridComponents[mouseGridX][mouseGridY].alive()) {
      }
    }
  }

  boolean mouseInScreen() {
    return 0 < mouseX && mouseX < width && toolbar._height < mouseY && mouseY < height-toolbar._height;
  }

  boolean mouseInGrid() {
    return -1 < mouseGridX && mouseGridX < 32 && -1 < mouseGridY && mouseGridY < 18;
  }
}
