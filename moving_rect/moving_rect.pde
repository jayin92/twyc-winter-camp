void setup(){
  size(800, 800);
  background(255, 255, 255);
  noFill(); // 不填色
  strokeWeight(5); // 長方形線寬
  rectMode(CENTER); // 座標代表長方形中間位置
}

void draw(){
  background(255, 255, 255);
  // mouseX, mouseY 代表滑鼠的 x 和 y 座標
  rect(mouseX, mouseY, 100, 100);
}
