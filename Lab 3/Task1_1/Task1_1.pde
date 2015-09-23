/*
  IELM2150 Lab 3 - Task 1 - Image 1
  Dhesant Nakka
  20146587
  
  Generate optical illusion using proximity principle, use loops and functions to automatically generate key elements.
  
*/

// Define colors
color o, e;

// Define circle diameters
int dia1 = 50;
int dia2 = 150;
int diac = 100;

void setup() {
  size(1440, 900); // Define screen size
  e = color(#FA6900); // Set e to inner color
  o = color(#69D2E7); // Set o to outer color
}

void draw() {
  background(#FFFFFF); // White background
  
  // Draw smaller half of illusion
  translate(width/2-300, height/2); // Set origin to middle of drawing 1
  
  ellipseMode(CENTER); // Draw the center ellipse (no stroke, fill with dark blue)
  noStroke();
  fill(e);
  ellipse(0, 0, diac, diac);

  fill(o); // Set ellipse parameters for side ellipses (no stroke, fill with light blue)
  
  for(int i = 0; i < 10; i++) { // Loop to generate 10 circles that are evenly spaced
    float[] xy = P2C(90, i*(360/10)); // Get cartesian coordinates using custom function
    ellipse(xy[0], xy[1], dia1, dia1); // Draw side ellipse at the chosen coordinates with diamater dia1
  }

  // Draw bigger half of illusion
  translate(500, 0); // Set origin to middle of drawing 2  
  
  fill(e);// Draw the center ellipse (no stroke, fill with dark blue)
  ellipse(0, 0, diac, diac);
  
  fill(o); // Set ellipse parameters for side ellipses (no stroke, fill with light blue)
    
  for(int i = 0; i < 6; i++) { // Loop to generate 6 circles that are evenly spaced
    float[] xy = P2C(160, i*(360/6)); // Get cartesian coordinates using custom function
    ellipse(xy[0], xy[1], dia2, dia2); // Draw side ellipse at the chosen coordinates with diamater dia2
  }
}

float[] P2C(float r, float theta) { // Function to convert polar coordinates to cartesian coordinates
  float[] xy = new float[2]; // Create return variable
  theta *= PI/180; // Convert degrees to radians
  xy[0] = r*cos(theta); // Get X coordinate
  xy[1] = r*sin(theta); // Get Y coordinate
  return xy;
}