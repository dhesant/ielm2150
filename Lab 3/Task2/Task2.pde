/*
  IELM2150 Lab 3 - Task 2
  Dhesant Nakka
  20146587
  
  The code will generate multiple solid outlines on top of a gradient pattern until the entire space is filled.
  It creates a sort of interleaved pattern with gradients going in opposite directions despite one
  of the lines being made of a solid fill.
  
  The code is fully scripted, and therefore changing the window size causes the pattern to be redrawn.
  The start and end points of the gradient can be chosen at random, and solid color is automatically 
  chosen from the middle.
  
*/

// Define gradient colors
color bm, b1, b2;

void setup() {
  size(1440, 900); // Set window size to window constants

  b1 = color(#d0e9fb); // Light blue
  b2 = color(#084977); // Dark blue

  bm = lerpColor(b1, b2, 0.5); // Automatically get the middle color
  
  surface.setResizable(true); // Enable window resizing
}

void draw() {
  setGradient(0, 0, width, height, b1, b2); // Set background gradient
  int diff = 80; // Intialize offset variables
  int a = (int)(diff*1.5);
  
  while (a < width/2 && a < height/2) { // Repeat loop for as long as possible
    stroke(bm); // Setup outline fill parameters
    strokeWeight(diff);
    rect(a, a, width-a*2, height-a*2); // Generate solid outline of width diff
    a += 2*diff; // Increase offset
  }
}

void setGradient(int x, int y, float w, float h, color c1, color c2) {
  noFill();
  strokeWeight(1);
  for (int i = x; i <= x+w; i++) {
    float inter = map(i, x, x+w, 0, 1); // Use map command to create an interpolation map
    color ci = lerpColor(c1, c2, inter);  // Use lerpColor to interpolate the colors
    stroke(ci);
    line(i, y, i, y+h);
  }
}