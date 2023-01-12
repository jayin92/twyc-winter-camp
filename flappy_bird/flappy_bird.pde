//Flappy Code
bird b = new bird();
pillar[] p = new pillar[3];
boolean end = false;
boolean intro = true;
int score = 0;

PImage bg, bird, pillar_up, pillar_down;

void setup() {
  bg = loadImage("background.jpg");
  bird = loadImage("bird.png");
  pillar_up = loadImage("pillar_up.png");
  pillar_down = loadImage("pillar_down.png");
  bg.resize(500, 800);
  size(500, 800);
  for (int i = 0; i < 3; i++) {
    p[i] = new pillar(i);
  }
}
void draw() {
  background(bg);
  if (end) {
    b.move();
  }
  b.drawBird();
  if (end) {
    b.drag();
  }
  b.checkCollisions();
  for (int i = 0; i < 3; i++) {
    p[i].drawPillar();
    p[i].checkPosition();
  }
  fill(0);
  stroke(255);
  textSize(32);
  if (end) {
    rect(20, 20, 100, 50);
    fill(255);
    text(score, 30, 58);
  } else {
    rect(150, 100, 200, 50);
    rect(150, 200, 200, 50);
    fill(255);
    if (intro) {
      text("Flappy Code", 155, 140);
      text("Play Game", 155, 240);
    } else {
      text("Game Over", 170, 140);
      text("Score", 180, 240);
      text(score, 280, 240);
    }
  }
}
class bird {
  float xPos, yPos, ySpeed;
  bird() {
    xPos = 200;
    yPos = 400;
  }
  void drawBird() {
    stroke(255);
    noFill();
    strokeWeight(2);
    //ellipse(xPos, yPos, 20, 20);
    image(bird, xPos, yPos, 60, 60);
  }
  void jump() {
    ySpeed = -10;
  }
  void drag() {
    ySpeed += 0.4;
  }
  void move() {
    yPos += ySpeed;
    for (int i = 0; i < 3; i++) {
      p[i].xPos -= 3;
    }
  }
  void checkCollisions() {
    if (yPos > 800) {
      end = false;
    }
    for (int i = 0; i < 3; i++) {
      if ((xPos < p[i].xPos + 10 && xPos > p[i].xPos - 10) && (yPos < p[i].opening - 100 || yPos > p[i].opening + 100)) {
        end = false;
      }
    }
  }
}
class pillar {
  float xPos, opening;
  boolean cashed = false;
  pillar(int i) {
    xPos = 100 + (i * 200);
    opening = random_opening();
  }
  void drawPillar() {
    imageMode(CENTER);
    image(pillar_up, xPos, opening - 100 - 350, 40, 700);
    image(pillar_down, xPos, opening + 100 + 350, 40, 700);
    //line(xPos, 0, xPos, opening - 100);
    //line(xPos, opening + 100, xPos, 800);
  }
  void checkPosition() {
    if (xPos < 0) {
      xPos += (200 * 3);
      opening = random_opening();
      cashed = false;
    }
    if (xPos < 250 && cashed == false) {
      cashed = true;
      score++;
    }
  }
}
void reset() {
  end = true;
  score = 0;
  b.yPos = 400;
  for (int i = 0; i < 3; i++) {
    p[i].xPos += 550;
    p[i].cashed = false;
  }
}
void mousePressed() {
  b.jump();
  intro = false;
  if (end == false) {
    reset();
  }
}
void keyPressed() {
  b.jump();
  intro = false;
  if (end == false) {
    reset();
  }
}

float random_opening() {
  return random(400) + 200;
}