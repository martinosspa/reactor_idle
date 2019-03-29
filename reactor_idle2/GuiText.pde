class GuiText extends GuiComponent {
  String text;
  GuiText(float x, float y) {
    super(x, y);
  }


  void setText(String text) {
    this.text = text;
  }


  void render() {
    stroke(0);
    fill(255,0,0);
    text(text, x, y);
    println("asd");
  }
}
