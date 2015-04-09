class Organ {
  
  String name;
  // containeds for images
  PImage img1, img2;
  // positions for mouse triger
  PVector min, max;
  
  Organ (String name, PVector min, PVector max, String img1, String img2) {
    this.name = name;
    this.min = min;
    this.max = max;
    this.img1 = loadImage(img1);
    this.img2 = loadImage(img2);
    if(this.img1 != null && this.img2 != null){
      this.img1.resize(0, height);
      this.img2.resize(0, height);
    }

  }
}
