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

void drawScanningText(){
   if( selection != null && selection != blank) {
    fill(#F21111);
    textAlign(CENTER, BOTTOM);
    textSize( int(height/20) );
    text("...scanning: "+selection.name, width/2 , height - 30); 
  }
}

// check where it was clicked and activate that organ
void drawMouseAnotation() {
  Organ above = selectOrgan();
  if (above != null && above != blank) {
    fill(255);
    textAlign(LEFT, CENTER);
    textSize(25);
    text(above.name,  mouseX +65, mouseY); 
  }
}


void drawSelectedOrgan(){
 if( selection != null && selection != blank) {
   fill(#F21111);
   //stroke(#F21111);
   float size = 15 + 5*sin( millis()*1.0 / 600.0 );
   ellipse(lastMouseX,lastMouseY,size,size);
 }
}
