int lastMouseX = 0;
int lastMouseY = 0;

// check where it was clicked and activate that organ
void mouseReleased() {
  lastMouseX = mouseX;
  lastMouseY = mouseY;
  selection = selectOrgan();
  //println( "selected: " + selection.name );
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

