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

public class presentation extends PApplet {

PImage person;
int personH; // person size - important for scaling of rest of the objects
int personPosX;

Organ [] organs;

Organ blank; // place holder for blank organ

Organ selection; // currently showed organ

PFont font; // font to use
PImage cursorImg; // cursor image

public void setup(){
  frameRate(30);
  size(displayWidth, displayHeight, P2D);
  background(0);
  // load images
  person = loadImage("fullbodyturn12.png");
  personH = PApplet.parseInt(height/1.1f);
  personPosX = PApplet.parseInt(height/2.1f);
  person.resize(0, personH);
  // initiate all the organs
  blank = new Organ("Blank", relPos(0,0), relPos(0,0), "blank_L.png", "blank_R.png" );
  organs = new Organ[7];
  organs[0] = new Organ("heart", relPos(-0.020f,0.25f), relPos(0.02f,0.2f), "Heart_L.png", "Heart_R.png" );
  organs[1] = new Organ("lungs", relPos(-0.065f,0.3f), relPos(0.06f,0.25f), "Lungs_L.png", "Lungs_R.png" );
  organs[2] = new Organ("breasts", relPos(-0.07f,0.25f), relPos(0.06f,0.18f), "Breast_L.png", "Breast_R.png" );
  organs[3] = new Organ("liver", relPos(-0.06f,0.18f), relPos(0.06f,0.14f), "Liver_L.png", "Liver_R.png" );
  organs[4] = new Organ("bones", relPos(-0.06f,0.14f), relPos(0.06f,-0.05f), "Bones_L.png", "Bones_R.png" );
  organs[5] = new Organ("thyroid", relPos(-0.02f,0.35f), relPos(0.02f,0.3f), "Thyroid_L.png", "Thyroid_R.png" );
  organs[6] = new Organ("brain", relPos(-0.05f,0.48f), relPos(0.05f,0.35f), "Brain_L.png", "Brain_R.png" );
  // organ to show
  selection = blank;
  font = loadFont("Helvetica-Light-56.vlw");
  textFont(font, 56);
  cursorImg = loadImage("cursor.png");
  cursor(cursorImg, 0, 15 );
}

public void draw(){
  background(0);
  imageMode(CENTER);
  image(person,width/2,personPosX);
  
  if( selection.img1 != null && selection.img2 != null) {
    image(selection.img1, width/4* (0.8f), height/2);
    image(selection.img2, width*3/4*1.1f, height/2);
  }
  
  drawScanningText();
  drawSelectedOrgan();
  // drawAllRegions(); //testing
  drawMouseAnotation();
}


// run in full screen?
public boolean sketchFullScreen() { return true; } 
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
public void drawAllRegions(){
  for( int i=0; i<organs.length; i++){
    drawSingleRegions(organs[i]);
  }
}

public void drawSingleRegions(Organ organ){
  stroke( 255, 0, 0 );
  noFill();
  PVector size = organ.max.get();
  size.sub( organ.min );
  rect(organ.min.x, organ.min.y, size.x, size.y );
}

// gives relative position to the person
public PVector relPos(float x, float y) {
  return new PVector( x*personH + width/2, -y*personH + personPosX ); 
} 

public void drawScanningText(){
   if( selection != null && selection != blank) {
    fill(0xffF21111);
    textAlign(CENTER, BOTTOM);
    textSize( PApplet.parseInt(height/20) );
    text("...scanning: "+selection.name, width/2 , height - 30); 
  }
}

// check where it was clicked and activate that organ
public void drawMouseAnotation() {
  Organ above = selectOrgan();
  if (above != null && above != blank) {
    fill(255);
    textAlign(LEFT, CENTER);
    textSize(25);
    text(above.name,  mouseX +65, mouseY); 
  }
}


public void drawSelectedOrgan(){
 if( selection != null && selection != blank) {
   fill(0xffF21111);
   //stroke(#F21111);
   float size = 15 + 5*sin( millis()*1.0f / 600.0f );
   ellipse(lastMouseX,lastMouseY,size,size);
 }
}
int lastMouseX = 0;
int lastMouseY = 0;

// check where it was clicked and activate that organ
public void mouseReleased() {
  lastMouseX = mouseX;
  lastMouseY = mouseY;
  selection = selectOrgan();
  //println( "selected: " + selection.name );
}



// produces selection for organs
public Organ selectOrgan(){
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

public boolean isWithin(PVector p, PVector min, PVector max) {
  return ( p.x >= min.x && p.x <= max.x && p.y >= min.y && p.y <= max.y ); 
}

  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "--full-screen", "--bgcolor=#000000", "--hide-stop", "presentation" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
