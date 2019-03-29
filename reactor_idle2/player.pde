class Player {
  float balance = 0;
  float moneyPerSecond = 0;

  void addMoneyPerSecond(float f) {
    moneyPerSecond += f;
  }
  void updateBalance() {
    balance += moneyPerSecond;
    if (0 < moneyPerSecond && moneyPerSecond < 0.1f) {
      moneyPerSecond = 0;
    }
  }

  void removeMoneyPerSecond(float f) {
    if (moneyPerSecond - f > 0) {
      moneyPerSecond = 0;
    } else {
      moneyPerSecond -= f;
    }
  }
}
