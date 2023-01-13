int[] px = new int[10000];
int[] py = new int[10000];
int[] x = new int[10000];
int[] y = new int[10000];
int idx = 0;

void setup(){
  size(800, 600);
  background(255, 255, 255); // R, G, B
  stroke(0, 0, 0); // R, G, B
  strokeWeight(5); // 寬度
  noFill();
  noCursor();
}

void draw(){
  background(255, 255, 255); // R, G, B
  if(mousePressed){
    px[idx] = pmouseX;
    py[idx] = pmouseY;
    x[idx] = mouseX;
    y[idx] = mouseY;
    idx = idx + 1;
  }
  for(int i = 0; i < idx; i++) {
    strokeWeight(5);
    line(px[i], py[i], x[i], y[i]);
  }
  strokeWeight(2);
  line(mouseX - 10, mouseY, mouseX + 10, mouseY);
  line(mouseX, mouseY - 10, mouseX, mouseY + 10);
}
