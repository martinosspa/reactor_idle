class SpriteHandler {
  // loads all sprites
  PImage[] loaded_images = new PImage[100];

  PImage get_image(int type) {
    String component_name = null;
    switch (type) {
    case 1:
      component_name = "wind_turbine.png";
      break;

    case 2:
      component_name = "solar_panel.png";
      break;

    case 3:
      component_name = "coal_burner.png";
      break;

    case 4:
      component_name = "gas_burner.png";
      break;
    }






    if (component_name != null) {
      loaded_images[type] = loadImage(component_name);

      return loaded_images[type];
    } else {
      return null;
    }
  }
}
