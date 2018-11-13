void renderBackground() {
  background(165, 165, 165);
  if (drawLines) {
    stroke(0);
    for (int i = 0; i < height; i += gridSize) {
      line(0, i, width, i);
    }

    for (int i = 0; i < width; i += gridSize) {
      line(i, height, i, 0);
    }
  }
  // menu bar
  fill(102, 102, 102);
  rect(0, 0, width, menuBarSize);

  // buttons
  for (Button currentButton : buttons ) {
    currentButton.render();
  }

  if (makeButtons) {
    buttons.add(new Button(15, 0, gridSize, color(0), 0, 1, 0));  // Wind mill button
    buttons.add(new Button(15, 1, gridSize, color(0), 0, 1, 1));  // Solar panel button
    buttons.add(new Button(15, 2, gridSize, color(0), 0, 1, 2)); // Coal burner
    buttons.add(new Button(16, 0, gridSize, color(0), 0, 1, 3)); // gas burner

    buttons.add(new Button(17, 0, gridSize, color(0), 0, 2, 0)); // battery 1
    buttons.add(new Button(17, 1, gridSize, color(0), 0, 2, 1)); // battery 2

    buttons.add(new Button(18, 0, gridSize, color(0), 0, 3, 0)); // sell station 1

    buttons.add(new Button(10, 0, gridSize*2.5, color(243, 255, 79), 1)); // sell power button
    buttons.add(new Button(0.5, 0, gridSize*4.4, color(70), 2)); // auto replace

    renderAllText();

    makeButtons = false;
  } else { 
    renderAllText();
    for (Button _button : buttons) {
      if (_button.pressedButton()) {
        _button.function();
      }
    }
  }
}

float gridPos(float temp) {
  float modulo = temp % gridSize;
  float mult = round(temp-modulo) / gridSize;
  return mult;
}





void renderAllText() {
  strokeWeight(3);
  stroke(0, 255, 0);
  line(6 * gridSize, 2 * gridSize, 10 * gridSize, 2 * gridSize);
  stroke(255, 0, 0);
  line(6 * gridSize, 2* gridSize, map(totalCapacity, 0, totalMaxCapacity, 6 * gridSize, 10 * gridSize), 2 * gridSize);
  strokeWeight(1);
  stroke(0); 
  
  fill(255, 0, 0);
  renderText(0, 2, "Component Price: " + prices[placeType*5 + placeSubType]);
  fill(0);
  renderText(10.1, 1.5, nf(generateRate, 0, 1) + " / tick");
  renderText(0.5, 0, "Auto Replace:" + autoReplace, autoReplace);
  //println("generateRate : " + generateRate);
  renderText(6, 2, nf(totalCapacity, 0, 1) + " / " + str(totalMaxCapacity));
  renderText(10, 0, "Sell Power");
  fill(23, 178, 28);
  renderText(5, 0, "Balance: " + nf(balance, 0, 1) + "$");
  //renderText(5, 2, str(int(totalCapacity)));
  //renderText(1, 0, "Windmill");
  //renderText(1, 1, "Solar Panel");
  //renderText(1, 2, "Coal burner");
}



float calcEnergy(float capacity, float maxCapacity, float tempRate) {
  if (capacity < maxCapacity) {
    capacity = constrain(capacity + tempRate, 0, maxCapacity);
    totalCapacity = constrain(tempRate + totalCapacity, 0, totalMaxCapacity);
  } else {
    capacity = constrain(capacity + tempRate, 0, maxCapacity);
  }

  return capacity;
}
boolean overlapping() {
  for (component gen : generators) {
    if (gen.x <= mouseX && gen.x+gridSize > mouseX && gen.y <= mouseY && gen.y+gridSize > mouseY) {
      //print("true");
      return true;
    }
  }
  return false;
}

component whatOverlap() {
  for (component gen : generators) {
    if (gen.x <= mouseX && gen.x+gridSize > mouseX && gen.y <= mouseY && gen.y+gridSize > mouseY) {
      return gen;
    }
  }
  return null;
}

component mouseOverGenerator() {
  for (component gen : generators ) {
    if (gen.x < mouseX && gen.x+gridSize > mouseX && mouseY < gen.y && gen.y+gridSize > mouseY) {
      return gen;
    }
  }
  return null;
}



void renderText(float tempX, float tempY, String text) {

  textSize(gridSize/2);
  text(text, tempX * gridSize + 1, tempY * gridSize + gridSize - gridSize/3);
  fill(0);
}

void renderText(float tempX, float tempY, String text, boolean condition) {
  if (condition) {
    stroke(0, 255, 0);
    fill(0, 255, 0);
  } else {
    stroke(255, 0, 0);
    fill(255, 0, 0);
  }
  textSize(gridSize/2);
  text(text, tempX * gridSize + 1, tempY * gridSize + gridSize - gridSize/3);
  fill(0);
}



void endSketch() {

  file.println(balance);
  for (component comp : generators) {
    file.print(str(comp.x) + " ");
    file.print(str(comp.y) + " ");
    file.print(str(comp.type) + " ");
    file.print(str(comp.subType) + " ");
    file.print(str(comp.capacity) + " ");
    file.println(str(comp.tick));
  }
  file.flush();
  file.close();
  
}