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
  color _color = 0;


  float group_produceRate[] = {0, 0, 0, 0, 0, 0.1, 3, 380, 75000};
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


  void render() {
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