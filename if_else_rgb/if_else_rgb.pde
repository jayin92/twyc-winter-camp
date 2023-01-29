color red   = color(255, 0, 0);
color green = color(0, 255, 0);
color blue  = color(0, 0, 255);

void setup(){
  size(900, 900);
  strokeWeight(5); // 長方形線寬
}

void draw(){
  if (mouseX < 300) {
    background(red);
  } else if (mouseX < 600) {
    background(green);
  } else if (mouseX < 900){
    background(blue);
  }
  line(300, 0, 300, 900);
  line(600, 0, 600, 900);
}
