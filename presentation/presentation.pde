PImage person;
int personH; // person size - important for scaling of rest of the objects
int personPosX;

Organ [] organs;

Organ blank; // place holder for blank organ

Organ selection; // currently showed organ

PFont font; // font to use
PImage cursorImg; // cursor image

void setup(){
  frameRate(30);
  size(displayWidth, displayHeight, P2D);
  background(0);
  // load images
  person = loadImage("fullbodyturn12.png");
  personH = int(height/1.1);
  personPosX = int(height/2.1);
  person.resize(0, personH);
  // initiate all the organs
  blank = new Organ("Blank", relPos(0,0), relPos(0,0), "blank_L.png", "blank_R.png" );
  organs = new Organ[7];
  organs[0] = new Organ("heart", relPos(-0.020,0.25), relPos(0.02,0.2), "Heart_L.png", "Heart_R.png" );
  organs[1] = new Organ("lungs", relPos(-0.065,0.3), relPos(0.06,0.25), "Lungs_L.png", "Lungs_R.png" );
  organs[2] = new Organ("breasts", relPos(-0.07,0.25), relPos(0.06,0.18), "Breast_L.png", "Breast_R.png" );
  organs[3] = new Organ("liver", relPos(-0.06,0.18), relPos(0.06,0.14), "Liver_L.png", "Liver_R.png" );
  organs[4] = new Organ("bones", relPos(-0.06,0.14), relPos(0.06,-0.05), "Bones_L.png", "Bones_R.png" );
  organs[5] = new Organ("thyroid", relPos(-0.02,0.35), relPos(0.02,0.3), "Thyroid_L.png", "Thyroid_R.png" );
  organs[6] = new Organ("brain", relPos(-0.05,0.48), relPos(0.05,0.35), "Brain_L.png", "Brain_R.png" );
  // organ to show
  selection = blank;
  font = loadFont("Helvetica-Light-56.vlw");
  textFont(font, 56);
  cursorImg = loadImage("cursor.png");
  cursor(cursorImg, 0, 15 );
}

void draw(){
  background(0);
  imageMode(CENTER);
  image(person,width/2,personPosX);
  
  if( selection.img1 != null && selection.img2 != null) {
    image(selection.img1, width/4* (0.8), height/2);
    image(selection.img2, width*3/4*1.1, height/2);
  }
  
  drawScanningText();
  drawSelectedOrgan();
  // drawAllRegions(); //testing
  drawMouseAnotation();
}


// run in full screen?
boolean sketchFullScreen() { return true; } 
