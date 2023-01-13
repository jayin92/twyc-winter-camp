void setup(){
  size(800, 600);
  background(255, 255, 255); // R, G, B
  stroke(0, 0, 0); // R, G, B
  strokeWeight(4); // 寬度
}

void draw(){
  if(mousePressed && mouseButton == LEFT){
    stroke(0, 0, 0);
    line(pmouseX, pmouseY, mouseX, mouseY);
  } else if(mousePressed && mouseButton == RIGHT){
    stroke(255, 255, 255);
    strokeWeight(20);
    line(pmouseX, pmouseY, mouseX, mouseY);
  }
}
