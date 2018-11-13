package processing.test.reactor_idle;

import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class reactor_idle extends PApplet {

int gridSize = 30;
int gridX;
int gridY;
int placeType = 1;
int placeSubType = 0;
float balance = 10;

float totalCapacity = 0;
float baseMaxCapacity = 1000;
float totalMaxCapacity;
float generateRate = 0;
float totalSellRate = 0;

int[] prices = 
  {0, 0, 0, 0, 0, 
  1, 200, 10000, 0, 0, 
  100, 1000, 0, 0, 0, 
  100};

float frames = 60;
float menuBarSize = gridSize*3;

boolean stroke = true;
boolean drawLines = true;
boolean autoReplace = true;

ArrayList<component> generators = new ArrayList<component>();
ArrayList<Button> buttons = new ArrayList<Button>();

PImage group_image[] = new PImage[20];
boolean makeButtons = true;

PrintWriter file;
BufferedReader reader;
String line;
boolean readFile = true;
public void setup() {
  

  group_image[0] = loadImage("debug_icon.png");
  group_image[1] = loadImage("debug_icon.png");
  group_image[2] = loadImage("debug_icon.png");
  group_image[3] = loadImage("debug_icon.png");
  group_image[4] = loadImage("debug_icon.png");

  group_image[5] = loadImage("wind_turbine.png");
  group_image[6] = loadImage("solar_panel.png");
  group_image[7] = loadImage("coal_burner.png");
  group_image[8] = loadImage("gas_burner.png");
  group_image[9] = loadImage("nuclear_cell.png");

  group_image[10] = loadImage("battery1.png");
  group_image[11] = loadImage("battery2.png");
  //group_image[12] = loadImage("battery2.png")
  //group_image[13] = loadImage("battery2.png")
  //group_image[14] = loadImage("battery2.png")

  group_image[15] = loadImage("sell_station1.png");

  totalMaxCapacity = baseMaxCapacity;
  frameRate(frames);
  gridX = width / gridSize;
  gridY = height / gridSize;

  if (!stroke) {
    noStroke();
  }


  file = createWriter("save.txt");
  reader = createReader("save.txt");
}

public void draw() {
  try {
    line = reader.readLine();
  } 
  catch (IOException e) {
    e.printStackTrace();
    line = null;
  }

  
  if (line == null) {
    // Stop reading because of an error or file is empty
    
  } else {
    balance = PApplet.parseInt(line);
    String[] comp = split(line, " ");
    String test;
    test = comp.toString();
    println(test);
    generators.add(new component(PApplet.parseFloat(comp[0]), PApplet.parseFloat(comp[1]), PApplet.parseInt(comp[2]), PApplet.parseInt(comp[3]), PApplet.parseFloat(comp[4]), PApplet.parseFloat(comp[5])));
  }










  if (autoReplace) {
    for (component comp : generators) {
      if (comp.dead && balance >= prices[comp.type*5 + comp.subType] && comp.type == 1) {
        comp.dead = false;
        comp.tick = comp.maxTick;
        balance -= prices[comp.type*5 + comp.subType];
      }
    }
  }

  for (component gen : generators) {

    if (gen.type == 2) {
      totalMaxCapacity += gen.maxCapacity;
    }
    if (!gen.dead) {
      generateRate += gen.produceRate;
    }
  }
  renderBackground();
  for (component gen : generators) {
    gen.render();
  }

  if (totalCapacity - totalSellRate > 0) {
    totalCapacity -= totalSellRate;
    balance += totalSellRate;
    //print(totalSellRate);
  }



  if (frameCount % 240 == 0) {
    println("components: " + generators.size());
    //println(placeType);
  }

  generateRate = 0;
  totalSellRate = 0;
  totalMaxCapacity = baseMaxCapacity;
}

public void mousePressed() {
  if (mouseY > menuBarSize) {
    if (mouseButton == LEFT) {
      if (balance - prices[placeType*5 + placeSubType] >= 0) {

        if (generators.size() > 1) {

          if (overlapping()) {
            //print(true);
            component tempGen = whatOverlap();
            if (tempGen.dead && placeType == tempGen.type && placeSubType == tempGen.subType) {
              //println("dead and/or same type");
              tempGen.tick = tempGen.maxTick;
              balance -= prices[placeType*5 + placeSubType];
            } else {
              println("error: not same type");
            }
          } else {
            //println(" its NOT overlapping");'
            //println(placeType);
            generators.add(new component(mouseX, mouseY, placeType, placeSubType));
            balance -= prices[placeType*5 + placeSubType];
          }
        } else {
          //println("size smaller than 1");
          generators.add(new component(mouseX, mouseY, placeType, placeSubType));
          //int temp = generators.size();
          balance -= prices[placeType*5 + placeSubType];
        }
      } else {
        println("error: insufficient balance, new balance would be: " + PApplet.parseInt(balance - prices[placeType*5 + placeSubType]));
      }
    } else if (mouseButton == RIGHT) {
      if (overlapping()) {
        component tempGen = whatOverlap();
        generators.remove(tempGen);
      }
    }
  }
}

public void keyPressed() {
  if (key == ESC) {
    endSketch();
  }
}
class Button {
  float x;
  float y;
  float buttonWidth;
  int base_color;
  int alpha = 255;
  float type = 0;
  float cooldown = 0;
  int _tempPlaceType;
  int _tempPlaceSubType;






  Button(float tempX, float tempY, float tempButtonWidth, int tempColor, float tempType) {
    x = tempX * gridSize;
    y = tempY * gridSize;
    base_color = tempColor;
    buttonWidth = tempButtonWidth;
    type = tempType;
  }

  Button(float tempX, float tempY, float tempButtonWidth, int tempColor, float tempType, int tempPlaceType, int tempPlaceSubType) {
    x = tempX * gridSize;
    y = tempY * gridSize;
    base_color = tempColor;
    buttonWidth = tempButtonWidth;
    type = tempType;
    _tempPlaceType = tempPlaceType;
    _tempPlaceSubType = tempPlaceSubType;
  }




  public void render() {
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
      image(group_image[_tempPlaceType * 5 + _tempPlaceSubType], x, y);
    } else if (type == 1 || type == 2) {
      fill(base_color, alpha);
      rect(x, y, buttonWidth, gridSize);
      cooldown = constrain(cooldown - 1, 0, 50);
      
    }

  }

  public boolean pressedButton() {
    if (x < mouseX && x + buttonWidth > mouseX && y < mouseY && y+gridSize > mouseY && mousePressed && cooldown == 0) {

      return true;
    } else {
      return false;
    }
  }


  public void function() {
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
class component {
  float capacity = 0;
  float maxCapacity = 0;
  float produceRate = 0;
  float maxTick = 0;
  float tick = 0;
  float x = 0;
  float y = 0;
  float alpha = 255;
  float sellRate = 0;

  int type = 0;
  int subType = 0;


  boolean dead = false;
  boolean mouseOver = false;
  int _color = 0;


  float group_produceRate[] = {0, 0, 0, 0, 0, 0.1f, 3, 380, 75000};
  float group_tick[] = {0, 0, 0, 0, 0, 20, 100, 400, 400};
  float group_maxCapacity[] = {500, 100000};
  float group_sellRate[] = {10, 1000, 100000};
  //color group_color[] = {color(255, 0, 0), color(0, 0, 255)};

  /*
 type 0: debug icon // 0 
   type 1: generators heat & energy
   type 2: heat --> power  type 3: power --> money
   type 4: storage components
   type 5: pipes (?)
   
   Type 1:
   sub type 0: wind turbine // 1
   sub type 1: solar panel // 2
   sub type 2: coal burner // 3
   sub type 3: gas burner // 4
   sub type 4: nuclear cell // 5
   
   Type 2:
   type 0: tier 1
   type 1: tier 2
   
   Type 3:
   type 0: tier 1
   */


  component(float tempX, float tempY, int tempType, int tempSubType) {
    x = gridSize * gridPos(tempX);
    y = gridSize * gridPos(tempY);
    type = tempType;
    subType = tempSubType;
    if (type < 2) {
      //maxCapacity = group_maxCapacity[type];
      produceRate = group_produceRate[type * 5 + subType];
      tick = group_tick[type * 5 + subType];
      maxTick = group_tick[type * 5 + subType];
      maxCapacity = tick * produceRate;
    } else if (type == 2) {
      maxCapacity = group_maxCapacity[subType];
    }
    if (type == 3) {

      sellRate = group_sellRate[subType];
      println(sellRate);
    }
  }

  component(float tempX, float tempY, int tempType, int tempSubType, float tempCapacity, float tempTick) {
    x = gridSize * gridPos(tempX);
    y = gridSize * gridPos(tempY);
    type = tempType;
    subType = tempSubType;
    if (type < 2) {
      //maxCapacity = group_maxCapacity[type];
      produceRate = group_produceRate[type * 5 + subType];
      tick = group_tick[type * 5 + subType];
      maxTick = group_tick[type * 5 + subType];
      maxCapacity = tick * produceRate;
    } else if (type == 2) {
      maxCapacity = group_maxCapacity[subType];
    }
    if (type == 3) {

      sellRate = group_sellRate[subType];
      println(sellRate);
    }
    capacity = tempCapacity;
    tick = tempTick;
  }


  public void render() {
    if (dead && tick > 0) {
      dead = false;
    }



    if (frameCount % 30 == 0) {
      if (tick > 0) {
        capacity = calcEnergy(capacity, maxCapacity, produceRate);
        tick -= 1;
      } else if (tick == 0) {
        dead = true;
      }
      if (type == 3 && totalCapacity - sellRate > 0) {
        totalCapacity -= sellRate;
        balance += sellRate;
      }
    }

    stroke(0);
    tint(255, alpha);
    //println(type * 5 + subType);
    image(group_image[type * 5 + subType], x, y, gridSize, gridSize);
    tint(255, 255);
    if (type == 2) {
    }
    if (dead && type < 2) {
      capacity = 0;
      alpha = 150;
    } else if (!dead && type < 2) {
      alpha = 255;
      textSize(gridSize/2);
      fill(0);
      float tempBar = map(tick, 0, maxTick, 0, gridSize);
      line(x, y + gridSize - 1, x + gridSize, y + gridSize - 1);
      stroke(255, 255, 0);
      line(x + 1, y + gridSize - 1, x + tempBar, y + gridSize - 1);
    }
  }
}
public void renderBackground() {
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

    buttons.add(new Button(10, 0, gridSize*2.5f, color(243, 255, 79), 1)); // sell power button
    buttons.add(new Button(0.5f, 0, gridSize*4.4f, color(70), 2)); // auto replace

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

public float gridPos(float temp) {
  float modulo = temp % gridSize;
  float mult = round(temp-modulo) / gridSize;
  return mult;
}





public void renderAllText() {
  strokeWeight(3);
  stroke(0, 255, 0);
  line(6 * gridSize, 2 * gridSize, 10 * gridSize, 2 * gridSize);
  stroke(255, 0, 0);
  line(6 * gridSize, 2* gridSize, map(totalCapacity, 0, totalMaxCapacity, 6 * gridSize, 10 * gridSize), 2 * gridSize);
  strokeWeight(1);
  stroke(0); 
  fill(0);


  renderText(10.1f, 1.5f, nf(generateRate, 0, 1) + " / tick");
  renderText(0.5f, 0, "Auto Replace:" + autoReplace, autoReplace);
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



public float calcEnergy(float capacity, float maxCapacity, float tempRate) {
  if (capacity < maxCapacity) {
    capacity = constrain(capacity + tempRate, 0, maxCapacity);
    totalCapacity = constrain(tempRate + totalCapacity, 0, totalMaxCapacity);
  } else {
    capacity = constrain(capacity + tempRate, 0, maxCapacity);
  }

  return capacity;
}
public boolean overlapping() {
  for (component gen : generators) {
    if (gen.x <= mouseX && gen.x+gridSize > mouseX && gen.y <= mouseY && gen.y+gridSize > mouseY) {
      //print("true");
      return true;
    }
  }
  return false;
}

public component whatOverlap() {
  for (component gen : generators) {
    if (gen.x <= mouseX && gen.x+gridSize > mouseX && gen.y <= mouseY && gen.y+gridSize > mouseY) {
      return gen;
    }
  }
  return null;
}

public component mouseOverGenerator() {
  for (component gen : generators ) {
    if (gen.x < mouseX && gen.x+gridSize > mouseX && mouseY < gen.y && gen.y+gridSize > mouseY) {
      return gen;
    }
  }
  return null;
}



public void renderText(float tempX, float tempY, String text) {

  textSize(gridSize/2);
  text(text, tempX * gridSize + 1, tempY * gridSize + gridSize - gridSize/3);
  fill(0);
}

public void renderText(float tempX, float tempY, String text, boolean condition) {
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

public void endSketch() {

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
  exit();
  
}
  public void settings() {  size(600, 600); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "reactor_idle" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
