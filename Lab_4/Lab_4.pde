/*
  IELM2150 Lab 4
  Dhesant Nakka
  20146587
  
  
*/

// Set each clock size to 50 px
int grid_size = 50;

// Initialize complex gradient setpoint holder 
color[] g = new color[9];

void setup() {
  size(1450, 950);
  
  // Initialize complex gradient setpoints
  g[0] = color(#160114);
  g[1] = color(#97003C);
  g[2] = color(#DE2C3A);
  g[3] = color(#FF5437);
  g[4] = color(#F28739);
  g[5] = g[3];
  g[6] = g[2];
  g[7] = g[1];
  g[8] = g[0];

  background(#FFFFFF); // Set background to white
}

void draw() {
  // Load map input files from disk
  byte map[] = loadBytes("map");
  byte h_oset[] = loadBytes("h_oset");
  byte m_oset[] = loadBytes("m_oset");
  
  // Initialize position variables to (0,0)n
  int x = 0;
  int y = 0;
  
  // Iterate through map input files to draw clocks
  for (int i = 0; i < map.length; i++) { 
    if (map[i] == 10) { // If map[i] = new line (10 dec), increment y, reset x
      y++;
      x = 0;
    }  
    else {
      if (map[i] == 49) { // If map[i] = 1 (49 dec), draw clock using offsets from h_oset and m_oset
        drawClock(x * grid_size + grid_size/2, y * grid_size + grid_size/2, (int)map(x, 0, 29, 0, 24));
      }
      x++;
    }
  }
}

void setHourFill(int h, int m) {
  float inter = map(h + map(m, 0, 60, 0, 1), 0, 24, 0, 8); // Calculate gradient interpolation value (7 unique gradients)
  int i = (int)inter; // Extract interpolation interger
  inter -= i; // Extract interpolation decimal
  
  color c = lerpColor(g[i], g[i+1], inter); // Automatically derive color and set it as fill
  fill(c);
  
  return;  
}

void drawClock(int x, int y, int h_oset, int m_oset) {
  int m = minute()+m_oset;
  int h = hour()+h_oset;
  
  // Ensure inputs are in a valid range
  if (h < 0) {
    h += 24;
  }
  
  if (h >= 24) {
    h -= 24;
  }

  if (m < 0) {
    m += 60;
    h--;
  }

  if (m >= 60) {
    m -= 60;
    h++;
  }
  
  // Calculate angles for hour and minute hand
  float t_m = map(m, 0, 60, 0, PI*2);
  float t_h = map(h+map(m, 0, 60, 0, 1), 0, 12, 0, PI*4); 

  noStroke(); // Fill background using setHourFill function
  setHourFill(h, m);  
  rect(x-grid_size/2, y-grid_size/2, grid_size, grid_size);
  
  noFill(); // Draw hour hand
  stroke(#FFFFFF);
  strokeWeight(4);
  drawHand(x, y, 20, t_h);

  strokeWeight(2); // Draw minute hand
  drawHand(x, y, 15, t_m);
  
  return;
}

void drawHand(int x, int y, int r, float theta) {
  int dX, dY;
 
  theta -= PI/2; // Set 0 radiands to north
  dX = (int)(r*cos(theta)); // Get x length
  dY = (int)(r*sin(theta)); // Get y length
 
  line(x, y, x+dX, y+dY); 

  return;
}
