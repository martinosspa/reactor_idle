class Button {
  float x;
  float y;
  float buttonWidth;
  color base_color;
  color alpha = 255;
  float type = 0;
  float cooldown = 0;
  int _tempPlaceType;
  int _tempPlaceSubType;






  Button(float tempX, float tempY, float tempButtonWidth, color tempColor, float tempType) {
    x = tempX * gridSize;
    y = tempY * gridSize;
    base_color = tempColor;
    buttonWidth = tempButtonWidth;
    type = tempType;
  }

  Button(float tempX, float tempY, float tempButtonWidth, color tempColor, float tempType, int tempPlaceType, int tempPlaceSubType) {
    x = tempX * gridSize;
    y = tempY * gridSize;
    base_color = tempColor;
    buttonWidth = tempButtonWidth;
    type = tempType;
    _tempPlaceType = tempPlaceType;
    _tempPlaceSubType = tempPlaceSubType;
  }




  void render() {
    if (cooldown > 0 && type > 0) {
      alpha = 150;
    } else {
      alpha = 255;
    }
    if (type == 0) {
      if (placeType == _tempPlaceType && placeSubType == _tempPlaceSubType) {
        tint(255, 100);
      } else {
        tint(255, 255);
      }
      image(group_image[_tempPlaceType * 5 + _tempPlaceSubType], x, y, gridSize, gridSize);
    } else if (type == 1 || type == 2) {
      fill(base_color, alpha);
      rect(x, y, buttonWidth, gridSize);
      cooldown = constrain(cooldown - 1, 0, 50);
      
    }

  }

  boolean pressedButton() {
    if (x < mouseX && x + buttonWidth > mouseX && y < mouseY && y+gridSize > mouseY && mousePressed && cooldown == 0) {
      return true;
    } else {
      return false;
    }
  }


  void function() {
    if (type == 0) {
      placeType = _tempPlaceType;
      placeSubType = _tempPlaceSubType;
      cooldown = 0;
    } else if (type == 1) {
      // Sell power button
      balance += totalCapacity;
      totalCapacity = 0;
      for (component gen : generators) {
        gen.capacity = 0;
        cooldown = 50;
      }
    } else if (type == 2) {
      // auto replace button
      if (autoReplace) {
        autoReplace = false;
        cooldown = 50;
      } else {
        autoReplace = true;
        cooldown = 50;
      }
    }
  }
}