void render_grid() {

  stroke(0);
  for (float i = height; i > toolbar._height; i -= gridSizeY) {
    line(0, i, width, i);
  }  

  for (float i = 0; i < width; i += gridSizeX) {
    line(i, 0, i, height);
  }
}

void update_global_values() {
  gridSizeX = width / (aspect_ratio.x*2);
  gridSizeY = (height - toolbar._height) / (aspect_ratio.y * 2);


  //toolbar.text_balance.set_coords(new PVector(gridSizeX, gridSizeY));
  //toolbar.text_balance.update_text("Balance: " + player.balance);
}

void setupToolbar() {

  toolbar = new Window(0, 0, width, height/(aspect_ratio.y));
  toolbar.set_color(color(100));
  toolbar.setCornerRadius(3, 10);
  toolbar.setCornerRadius(4, 10);


  // balance text
  GuiText t = new GuiText(0, 16);
  //t.setText("Test" + player.balance);
  t.setCode(1);
  toolbar.addComponent(t);

  t = new GuiText(0, 32);
  t.setCode(2);
  toolbar.addComponent(t);
}
