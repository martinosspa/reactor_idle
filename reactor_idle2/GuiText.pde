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
        this.text = "Balance: " + player.balance;
        break;
      case 2: 
        this.text = "Money per second: "+ player.moneyPerSecond;
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
