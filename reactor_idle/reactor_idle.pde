int gridSize = 0;
int gridX;
int gridY;
int placeType = 1;
int placeSubType = 0;
int tapTime = 0;
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

int frames = 60;
float menuBarSize = 0;

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
void setup() {
  //size(600, 600);
  fullScreen();
  gridSize = width/20;
  menuBarSize = gridSize*3;
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

void draw() {
  if (mousePressed) {
    tapTime = constrain(tapTime + 1, 0, frames*2);
  } else {
    tapTime = 0;
  }
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
    balance = int(line);
    String[] comp = split(line, " ");
    String test;
    test = comp.toString();
    println(test);
    generators.add(new component(float(comp[0]), float(comp[1]), int(comp[2]), int(comp[3]), float(comp[4]), float(comp[5])));
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

void mouseReleased() {
  if (mouseY > menuBarSize) {
    if (tapTime < frames/2) {
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
        println("error: insufficient balance: " + int(balance - prices[placeType*5 + placeSubType]));
      }
    } else if (frames/2 < tapTime) {
      if (overlapping()) {
        component tempGen = whatOverlap();
        generators.remove(tempGen);
      }
    }
  }
}


void keyPressed() {
  if (key == ESC) {
    endSketch();
  }
}