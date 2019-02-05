void render_grid() {
  for (float i = height; i > toolbar.height; i -= gridSizeY) {
    line(0, i, width, i);
  }  

  for (float i = 0; i < width; i += gridSizeX) {
    line(i, 0, i, height);
  }
}

void set_global_values() {
  gridSizeX = width / (aspect_ratio.x*2);
  gridSizeY = (height - toolbar.height) / (aspect_ratio.y * 2);
}
