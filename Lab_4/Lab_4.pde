/*
  IELM2150 Lab 4
  Dhesant Nakka
  20146587
  
  
*/

int grid_size = 50;

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
}

void draw() {
  background(#FFFFFF);

  // Open a file and read its binary data 
  byte map[] = loadBytes("map");
  
  int x = 0;
  int y = 0;
  
  for (int i = 0; i < map.length; i++) { 
    if (map[i] == 10) { 
      y++;
      x = 0;
    }  
    else {
      if (map[i] == 49) {
        drawClock(x * grid_size + grid_size/2, y * grid_size + grid_size/2, (int)map(x, 0, 29, 0, 24));
      }
      x++;
    }
  }
}

void setFill(int h, int m) {
  float inter = map(h + map(m, 0, 60, 0, 1), 0, 24, 0, 8);
  int i = (int)inter;
  inter -= i;
  
  //println(h + " " + i + " " + inter); // Debug print
  
  color c = lerpColor(g[i], g[i+1], inter);
  fill(c);
  
  return;  
}

void drawClock(int x, int y, int offset) {
  int m = minute();
  int h = hour()+offset;
  
  if (h < 0) {
    h += 24;
  }
  
  if (h >= 24) {
    h -= 24;
  }
  
  float t_m = map(m, 0, 60, 0, PI*2);
  float t_h = map(h+map(m, 0, 60, 0, 1), 0, 12, 0, PI*4); 

  noStroke();
  setFill(h, m);  
  rect(x-grid_size/2, y-grid_size/2, grid_size, grid_size);
  
  noFill();
  stroke(#FFFFFF);
  
  strokeWeight(5);
  drawHand(x, y, 20, t_h);
  strokeWeight(3);
  drawHand(x, y, 15, t_m);
  
}

void drawHand(int x, int y, int r, float theta) {
 int dX, dY;
 
 theta -= PI/2; // Set 0 radiands to north
 dX = (int)(r*cos(theta)); // Get x length
 dY = (int)(r*sin(theta)); // Get y length
 
 line(x, y, x+dX, y+dY); 
}