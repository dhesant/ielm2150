/*
  IELM2150 Lab 3 - Task 1 - Image 2
  Dhesant Nakka
  20146587
  
  Generate optical illusion using continuity principle, use loops and functions to automatically generate key elements.
  
*/

// Window Constants
int X_LEN = 1440;
int Y_LEN = 900;

// Define color placeholders
color f, b;

int dia1 = 150; // Define outer circle diameters
int diat = 320; // Define total shape diameter

// Containers for triangle generation coordinates
float[][] tri1 = new float[3][];
float[][] tri2 = new float[3][];

void setup() {
  size(X_LEN, Y_LEN);
  f = color(#36a4f1); // Blue foreground color
  b = color(#FFFFFF); // White background color
}

void draw() {
  background(b); // Set background color
  
  translate(width/2, height/2); // Set origin to middle of window
    
  for(int i = 0; i < 3; i++) { // Loop to generate 3 circles
    float[] xy = P2C(diat, i*120-30); // Generate XY coordinates using polar coorinate function

    ellipseMode(CENTER); // Draw ellipse at each coordinate (no stroke, fill with foreground color)
    noStroke();
    fill(f);
    ellipse(xy[0], xy[1], dia1, dia1);

    tri2[i] = xy; // Add XY coordinates to tri2 to generate negative triangle
  }

  for (int i = 0; i < 3; i++) { // Loop to fill triangle coordinates using polar function
    tri1[i] = P2C(diat, i*120+30); // Generate XY coordinates for outline triangle
  }
  
  noFill(); // Create outline triangle in foreground color using tri1 coordinates
  stroke(f);
  strokeWeight(5);
  triangle(tri1[0][0], tri1[0][1], tri1[1][0], tri1[1][1], tri1[2][0], tri1[2][1]);
  
  noStroke(); // Create negative triangle in background color using tri2 coordinates
  fill(b);
  triangle(tri2[0][0], tri2[0][1], tri2[1][0], tri2[1][1], tri2[2][0], tri2[2][1]);
}

float[] P2C(float r, float theta) {
  float[] xy = new float[2];
  theta *= PI/180;
  xy[0] = r*cos(theta);
  xy[1] = r*sin(theta);
  return xy;
}
