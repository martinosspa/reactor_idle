class GuiText extends GuiComponent {
  String text;
  int code;

  GuiText(float x, float y) {
    super(x, y);
  }


  void setText(String text) {
    this.text = text;
  }

  void render() {
    switch (code) {
    case 1:
      this.text = "Balance: " + nf(player.balance, 0, 1);
      break;
    case 2: 
      this.text = "Money per second: "+ nf(player.moneyPerSecond, 0, 1);
      break;
    }
    stroke(0);
    fill(255, 0, 0);
    text(text, x, y);
  }

  void setCode(int c) {
    code = c;
  }
}
