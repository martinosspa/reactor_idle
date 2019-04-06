float gridSizeX;
float gridSizeY;

PFont font;
ActionHandler action_handler = new ActionHandler();
SpriteHandler sprite_handler = new SpriteHandler();
Window toolbar;
Player player = new Player();
//Renderer text_balance = new Renderer();

PVector aspect_ratio = new PVector(16, 9);

int FRAMERATE = 100;

int selected_component = 1;
Grid grid = new Grid(aspect_ratio.x*2, aspect_ratio.y*2);



void setup() {
  //size(1280, 720);
  fullScreen();

  orientation(LANDSCAPE);

  frameRate(FRAMERATE);

  setupToolbar();

  update_global_values();

  font = createFont("Arial", gridSizeY/2);
  textFont(font);

  for (int i = 0; i < 32; i++) {
    for (int j = 0; j < 18; j++) {
      grid.set_component(new GridPosition(i, j));
    }
  }
  println("setup finished");
}



void draw() {
  update_global_values();
  //println(player.moneyPerSecond);
  background(170);

  render_grid();
  toolbar.render();

  action_handler.tick();
  beginShape();
  translate(0, toolbar._height);
  grid.render();

  if (frameCount % FRAMERATE == 0) {
    grid.tick();
    player.updateBalance();
  }
  endShape();
}
