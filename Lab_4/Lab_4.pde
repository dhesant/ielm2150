/*

   IELM2150 Lab 4
   Dhesant Nakka
   20146587
   
   Draw a world map using square clocks to represent different cities and their current time. Background color is
   automatically chosen based on the current time against a multi-color gradient. Mouse over certain blocks to see the 
   name of a nearby major city.
   
   Note: Does not support daylight savings time.
   
   IMPORTANT: This code was developed with Processing 3, compatibility with Processing 2 is untested.
   
 */

// Set each clock size to 50 px
int grid_size = 50;

// Initialize complex gradient setpoint holder 
color[] g = new color[9];

// Variable to hold current time zone
int cur_tz = 8;

// Major cities indexs
int[] cit_key = { 113, 142, 153, 154, 148, 183, 227, 230, 244, 250, 275, 285, 300, 330, 359, 374, 408, 428, 
  448, 471, 474, 219, 360, 248, 209, 128, 342, 427, 286, 120, 171, 147 };
String[] cit_str = { "Anchorage", "Vancouver", "London", "Paris", "New York", "Rome", "Los Angeles", "Miami", 
  "New Dehli", "Tokyo", "Hong Kong", "Mexico City", "Mumbai", "Singapore", "Jakarta", "Rio De Janeiro", 
  "Johannesburg", "Buenos Aires", "Auckland", "Perth", "Sydney", "Beijing", "Bali", "Shanghai", "Madrid", 
  "Moscow", "Lima", "Santiago", "Bogota", "St. Johns", "Seattle", "Toronto" };

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
}

void draw() {
  background(#FFFFFF); // Set background to white
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
    } else {
      if (map[i] == 49) { // If map[i] = 1 (49 dec), draw clock using offsets from h_oset and m_oset
        //println(i + "  " + h_oset[i] + " " + m_oset[i]); // Debug print
        drawClock(x * grid_size + grid_size/2, y * grid_size + grid_size/2, h_oset[i]-12, m_oset[i]);
      }
      x++;
    }
  }

  int m_x, m_y; // Get mouse grid coordinates
  m_x = mouseX/grid_size;
  m_y = mouseY/grid_size;

  //println(m_x + " " + m_y); // Debug print

  for (int i = 0; i < cit_key.length; i++) { // Search city index for match
    if ((m_x+m_y*28) == cit_key[i]) {
      printCity(cit_str[i], m_x, m_y);
      break;
    }
  }
}

void printCity(String city, int x, int y) {
  textSize(32); // Setup font print
  textAlign(RIGHT, TOP);
  noStroke();
  fill(g[0]);

  text(city, width-32, 32);
}

void setHourFill(int h, int m) {
  float inter = map(h + map(m, 0, 60, 0, 1), 0, 24, 0, 8); // Calculate gradient interpolation value (7 unique gradients)
  int i = (int)inter; // Extract interpolation interger
  inter -= i; // Extract interpolation decimal

  //println(h + " " + i + " " + inter); // Debug print

  color c = lerpColor(g[i], g[i+1], inter); // Automatically derive color and set it as fill
  fill(c);

  return;
}

void drawClock(int x, int y, int h_oset, int m_oset) {
  int m = minute()+m_oset;
  int h = hour()+h_oset-cur_tz;

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
  float t_h = map(h+map(m, 0, 60, 0, 1), 0, 24, 0, PI*4); 

  noStroke(); // Fill background using setHourFill function
  setHourFill(h, m);  
  rect(x-grid_size/2, y-grid_size/2, grid_size, grid_size);

  noFill(); // Draw hour hand
  stroke(#FFFFFF);
  strokeWeight(4);
  drawHand(x, y, 12, t_h);

  strokeWeight(2); // Draw minute hand
  drawHand(x, y, 20, t_m);

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