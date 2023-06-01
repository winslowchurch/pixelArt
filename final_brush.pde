// Final Brush

// s toggles stroke
// space toggles drawing
// r refreshes page
// clicking changes colors

int pixl = 15; // pixel length
boolean is_Stroke = false;
boolean is_Drawing = true;
// randomly select initial background
float rval_l = random(0, 240);
float rval_h = random(rval_l + 10, 255);
float gval_l = random(0, 250);
float gval_h = random(gval_l + 10, 255);
float bval_l = random(0, 250);
float bval_h = random(bval_l + 10, 255);

// set up screen size and initialize background pixels
void setup() {
  size(1040, 700);
  surface.setTitle("Pixel Brush");
  surface.setResizable(true);
  pixelDensity(2);
  noStroke();
  // draw initial grid of blocks
  for (int i = 0; i < 100; i++) {
    for (int j = 0; j < 70; j++) {
      fill(random(rval_l, rval_h), random(gval_l, gval_h), random(bval_l, bval_h)); 
      rect(i*pixl,j*pixl, pixl, pixl);
    }
  }
  
  /*fill(255,255,255);
  textSize(50);
  text("s key toggles stroke", 200, 100);
  text("space pauses drawing", 200, 200);
  text("clicking changes color", 200, 300);*/
}


void change_colors() {
  rval_l = random(0, 240);
  rval_h = random(rval_l + 10, 255);
  gval_l = random(0, 250);
  gval_h = random(gval_l + 10, 255);
  bval_l = random(0, 250);
  bval_h = random(bval_l + 10, 255); 
}


// rounds the current value down to the nearest pixel
int round_down(int current) {
  if ((current % pixl) == 0) {
    return current;
  } else {
    return current - (current % pixl);
  }
}

// returns true if we don't want to color the pixel
boolean skip_pixel(int i, int j) {
  if (i == 0 & j == -2) return true;
  else if (i == 2 & j == 2) return true;
  else if (i == -1 & j == 2) return true;
  else if (i == 1 & j == 1) return true;
  else if (i == -1 & j == -1) return true;
  else if (i == -2 & j == 1) return true;
  else if (i == 2 & j == -1) return true;
  else if (i == -2 & j == -1) return true;
  else if (i == 1 & j == 0) return true;
  // don't skip 
  else return false;
}

// draw the color on the brush
void draw(){
  if (is_Drawing) {
    int currentx = round_down(mouseX);
    int currenty = round_down(mouseY);
    for (int i = -2; i < 3; i++) {
      for (int j = -2; j < 3; j++) {
        if (!skip_pixel(i,j)) {
          // give a stroke that matches the current colors
          if (is_Stroke) stroke(random(255), gval_h, bval_h);
          // determine color
          fill(random(rval_l, rval_h), random(gval_l, gval_h), random(bval_l, bval_h));        
          // fill in the pixel
          rect(currentx + (i*pixl), currenty + (j*pixl), pixl, pixl);
        }  
      }
    }
  }
}

// clicking changes the color range
void mouseClicked() {
  change_colors();
}

// use up and down arrows to change pixel size
void keyPressed() {
  // save file as tif
  if (keyCode == ESC) {
    save("untitled.tif");
    
  // change pixel size
  } else if (keyCode == UP) {
    if (pixl < 35) pixl = pixl + 3;
  } else if (keyCode == DOWN) {
    if (pixl > 5) pixl = pixl - 3;
    
  // drawing on and off
  } else if (key == ' ') { //spacebar
    is_Drawing = !is_Drawing;
    
  // turn stroke on and off
  } else if (key == 's') {
    if (is_Stroke) {
      noStroke();
    }
    is_Stroke = !is_Stroke;
    
  // refresh page
  } else if (key == 'r') {
    change_colors(); // new set of colors
    int lmax = 1000/pixl + pixl;
    int hmax = 700/pixl + pixl;
    for (int i = 0; i < lmax; i++) {
      for (int j = 0; j < hmax; j++) {
        fill(random(rval_l, rval_h), random(gval_l, gval_h), random(bval_l, bval_h)); 
        rect(i*pixl,j*pixl, pixl, pixl);
      }
    }
  }
}
