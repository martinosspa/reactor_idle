class Grid {
  int height;
  int width;
  GridPosition[][] gridComponents;
  int componentCount = 0;

  Grid(float w, float h) {
    this.width = int(w);
    this.height = int(h);
    gridComponents = new GridPosition[32][18];
  }


  void set_component(GridPosition comp) {
    gridComponents[comp.x][comp.y] = comp;
    componentCount++;
  }



  void render() {

    for (int i = 0; i < this.width; i++) {
      for (int j = 0; j < this.height; j++) {
        gridComponents[i][j].render();
      }
    }
  }

  void tick() {
    for (int i = 0; i < this.width; i++) {
      for (int j = 0; j < this.height; j++) {
        if (gridComponents[i][j].taken()) {
          gridComponents[i][j].tick();
        }
      }
    }
  }
}
