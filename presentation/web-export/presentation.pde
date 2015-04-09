PImage person;
int personH; // person size - important for scaling of rest of the objects
int personPosX;

Organ [] organs;

Organ blank; // place holder for blank organ

Organ selection; // currently showed organ

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
  organs[0] = new Organ("Heart", relPos(-0.020,0.25), relPos(0.02,0.2), "Heart_L.png", "Heart_R.png" );
  organs[1] = new Organ("Lungs", relPos(-0.065,0.3), relPos(0.06,0.25), "Lungs_L.png", "Lungs_R.png" );
  organs[2] = new Organ("Breasts", relPos(-0.07,0.25), relPos(0.06,0.18), "Breast_L.png", "Breast_R.png" );
  organs[3] = new Organ("Liver", relPos(-0.06,0.18), relPos(0.06,0.14), "Liver_L.png", "Liver_R.png" );
  organs[4] = new Organ("Bones", relPos(-0.06,0.14), relPos(0.06,-0.05), "Bones_L.png", "Bones_R.png" );
  organs[5] = new Organ("Thyroid", relPos(-0.02,0.35), relPos(0.02,0.3), "Thyroid_L.png", "Thyroid_R.png" );
  organs[6] = new Organ("Brain", relPos(-0.05,0.48), relPos(0.05,0.35), "Brain_L.png", "Brain_R.png" );
  // organ to show
  selection = blank;
}

void draw(){
  background(0);
  imageMode(CENTER);
  image(person,width/2,personPosX);
  
  if( selection.img1 != null && selection.img2 != null) {
    image(selection.img1, width/4* (0.8), height/2);
    image(selection.img2, width*3/4*1.1, height/2);
  }
  
  //drawAllRegions(); //testing
}


// run in full screen?
boolean sketchFullScreen() { return true; } 
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
// draw all selection regions
void drawAllRegions(){
  for( int i=0; i<organs.length; i++){
    drawSingleRegions(organs[i]);
  }
}

void drawSingleRegions(Organ organ){
  stroke( 255, 0, 0 );
  noFill();
  PVector size = organ.max.get();
  size.sub( organ.min );
  rect(organ.min.x, organ.min.y, size.x, size.y );
}

// gives relative position to the person
PVector relPos(float x, float y) {
  return new PVector( x*personH + width/2, -y*personH + personPosX ); 
} 
// check where it was clicked and activate that organ
void mouseMoved() {
  selection = selectOrgan();
  println( "selected: " + selection.name );
}

// produces selection for organs
Organ selectOrgan(){
   PVector c = new PVector(mouseX, mouseY);
   //println("mouse: "+c.x +"   "+c.y);
   for(int i=0; i<organs.length; i++){
     //println("  name: "+organs[i].name);
     //println("min:   "+organs[i].min.x +"   "+organs[i].min.y);
     //println("max:   "+organs[i].max.x +"   "+organs[i].max.y);
     if ( isWithin(c, organs[i].min, organs[i].max) ) {
       return organs[i];
     }
   } 
   return blank; // fall back option
}

boolean isWithin(PVector p, PVector min, PVector max) {
  return ( p.x >= min.x && p.x <= max.x && p.y >= min.y && p.y <= max.y ); 
}

