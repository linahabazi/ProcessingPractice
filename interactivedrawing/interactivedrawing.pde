float r;
float g;
float b;

float diam=100;
float x;
float y;

boolean on = false; //mousepress
boolean showImage = true; //keypress
boolean redraw = true; //after keypress

PImage img, img2;

class ellipse {
  int x, y;
  float r, g, b, diam;
  
  ellipse (int X, int Y, float R, float G, float B, float Diameter) {
    x = X;
    y = Y;
    r = R;
    g = G;
    b = B;
    diam = Diameter;
  }
}

ArrayList<ellipse> drawing = new ArrayList<ellipse>();

void setup() {
  size(500, 750);
  background(255);
  frameRate(100);
  
  img = loadImage("dome.jpg");
  img2 = loadImage("dome2.jpg");
  
  image(img2, 0, 0, width, height);
  image(img, 0, 0, width, height);
}

void draw() {  
  int loc = mouseX + mouseY*img.width;
  
  loadPixels();
  if(loc < img.width * img.height && loc > 0) {
    r = red(img2.pixels[loc]);
    g = green(img2.pixels[loc]);
    b = blue(img2.pixels[loc]);
  }
  noStroke();
  //get center of last drawn circle
  
  if(on) {
    if(drawing.size() > 0) {
      int pX = drawing.get(drawing.size()-1).x;
      int pY = drawing.get(drawing.size()-1).y;
      
      if(abs(pX - mouseX) >= diam/4 || abs(pY - mouseY) >=diam/4) {
        drawShape(new ellipse(mouseX, mouseY, r, g, b, diam));  
        if(drawing.size() % 10 == 0) {
          diam -= 1;
        }
      }
    }
    else {
      drawShape(new ellipse(mouseX, mouseY, r, g, b, diam));  
    }
  }
}

void mousePressed() {
  on = true;
}

void mouseReleased() {
  on = false;
}

void keyPressed() {
  if(showImage){
    background(255);
  }
  else {
    image(img, 0, 0, width, height);
  }
  showImage = !showImage;
  drawDrawing();
}

void drawDrawing() {
  for(ellipse ellipse : drawing){
    noStroke();
    fill(ellipse.r, ellipse.g, ellipse.b, 127);
    ellipse(ellipse.x, ellipse.y, ellipse.diam, ellipse.diam);
  }
}

void drawShape(ellipse ellipse) {
    drawing.add(ellipse);
    noStroke();
    fill(ellipse.r, ellipse.g, ellipse.b, 127);
    ellipse(ellipse.x, ellipse.y, ellipse.diam, ellipse.diam);
}
