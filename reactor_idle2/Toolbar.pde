class Toolbar extends Renderer {
  Renderer text_balance = new Renderer();
  
  void _setup() {
    set_coords(new PVector(0, 0));
    println(width);
    println(height);
    PVector a = new PVector(width, height/(aspect_ratio.y));
    println(a);
    
    set_color(color(75));
    set_corner_radius(3, 10);
    set_corner_radius(4, 10);
    set_dimensions(a);

    // balance text
    text_balance.set_coords(new PVector(gridSizeX, gridSizeY));
    text_balance.is_text();
    text_balance.update_text("testing text");
    text_balance.set_color(color(0, 150, 50));
    
  }
}
