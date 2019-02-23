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
  
  
  toolbar.text_balance.set_coords(new PVector(gridSizeX, gridSizeY));
  toolbar.text_balance.update_text("Balance: " + player.balance);
}

void render_toolbar() {
  toolbar.render();
}
