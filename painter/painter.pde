void setup(){
  size(800, 600);
  background(0, 0, 0); // R, G, B
  stroke(255, 255, 255); // R, G, B
  strokeWeight(4); // 寬度
}

void draw(){
  if(mousePressed){
    line(pmouseX, pmouseY, mouseX, mouseY);
  }
}
