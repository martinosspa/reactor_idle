float gridSizeX;
float gridSizeY;
PVector aspect_ratio = new PVector(16, 9);
float balance = 0;
Component testing_comp = new ComponentGenerator(1, 1, 1);
Renderer toolbar = new Renderer();


void setup() {
  size(1280, 720);
  //fullScreen();
  surface.setResizable(true);

  toolbar.set_coords(new PVector(0, 0));
  toolbar.set_dimensions(new PVector(width, height/(aspect_ratio.y/1)));
  toolbar.set_color(color(110));
  toolbar.set_corner_radius(3, 10);
  toolbar.set_corner_radius(4, 10);

  // temporary
  testing_comp.set_image(loadImage("wind_turbine.png"));
}



void draw() {
  set_global_values();
  render_grid();
  toolbar.render();
  beginShape();
  translate(0, toolbar.height);


  //temporary
  testing_comp.tick();
  testing_comp.render();
  endShape();
}
