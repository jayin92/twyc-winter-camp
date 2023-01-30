// Flappy Bird
// Adapted by Jie-Ying Lee for NYCU WEEC Camp
// 若有不懂的語法可以參考補充資料

bird b = new bird(); // 創造一個鳥的物件
pillar[] p = new pillar[3]; // 創造一個柱子物件的陣列，這個陣列共有三個物件
boolean end = true; // 追蹤遊戲是否結束
boolean intro = true; // 追蹤是否進入開始畫面
int score = 0; // 用來紀錄分數的變數

// ----- 可以改變的參數 ----- //
int opening_half_width = 50; // 柱子間開口的一半高度
float gravity = 0.4; // 重力加速度的值
float jump_velocity = 10; // 跳一下的速度改變
int pillar_velocity = 3; // 柱子移動的速度
// ----------------------- //

PImage bg, bird, pillar_up, pillar_down, floor; // PImage 物件，用來儲存圖片

void setup() {
  bg = loadImage("background.jpg"); // 讀取背景圖片
  floor = loadImage("floor.jpg"); // 讀取地板圖片
  bird = loadImage("bird.png"); // 讀取鳥的圖片
  pillar_up = loadImage("pillar_up.png"); // 讀取上面的柱子的圖片
  pillar_down = loadImage("pillar_down.png"); // 讀取下面的柱子的圖片
  size(500, 800); // 視窗大小為 500 x 800
  bg.resize(500, 800); // 將背景圖片調整成 500 x 800

  // 利用 for 迴圈，初始化畫面中的三個柱子
  for (int i = 0; i < 3; i++) {
    p[i] = new pillar(i);
  }
}
void draw() {
  background(bg); // 將背景設為剛剛讀進來的背景圖片

  // 如果遊戲沒有結束，鳥會持續移動
  if (end == false) {
    b.move(); // 根據速度計算鳥目前的位置
  }

  // 把鳥畫在畫面上
  b.drawBird();

  // 如果遊戲沒有結束，讓鳥持續往下掉
  if (end == false) {
    b.drag();
  }

  b.checkCollisions(); // 檢查鳥有沒有和柱子相撞

  for (int i = 0; i < 3; i++) {
    p[i].drawPillar(); // 將第 i 根柱子繪製在畫面上
    p[i].checkPosition(); // 檢查第 i 根柱子有沒有超出畫面
  }

  imageMode(CORNER); // 下方 image 函數的坐標代表圖片的中央位置
  image(floor, 0, 610, 800, 190); // 將地板畫在畫面上
  fill(0); // 遊戲標題及分數的填色為黑色
  stroke(255); // 外框則為白色
  textSize(32); // 文字大小為 32 點

  // 如果遊戲沒有結束，則顯示目前的分數
  textAlign(CENTER);
  rectMode(CENTER);
  if (end == false) {
    rect(75, 50, 100, 50);
    fill(255);
    text(score, 75, 63);
  } else {
    // 若遊戲結束，則檢查是否為尚未開始，或是為開始畫面
    rect(250, 100, 200, 50);
    rect(250, 200, 200, 50);
    fill(255);
    if (intro) {
      // 如果是開始畫面，則顯示 Flappy Bird 和開始遊戲
      text("Flappy Bird", 250, 113);
      text("Play Game", 250, 213);
    } else {
      // 如果是結束畫面，則顯示 Game Over 和分數
      text("Game Over", 250, 113);
      text("Score", 205, 213);
      text(score, 285, 213);
    }
  }
}

// 定義一個新的類別，鳥
class bird {
  float xPos, yPos, ySpeed; // 鳥擁有三個成員變數，分別為 x 座標、y 座標和 y 方向上的速度
  
  // 鳥的建構子 (constructor)，預設位置為 (200, 400)
  bird() {
    xPos = 200;
    yPos = 400;
  }

  // 將鳥繪製在畫面上的函數
  void drawBird() {
    imageMode(CENTER);
    image(bird, xPos, yPos, 35, 35); // 鳥的位置大小為 35 x 35
  }

  // 鳥跳一下的函數
  void jump() {
    ySpeed = -jump_velocity; // y 方向上的速度變小 10 (往上跳)
  }

  // 讓鳥自然下落的函數
  void drag() {
    ySpeed += gravity; // y 方向上的速度每次更新都會變大 0.4 (重力加速度為 0.4)
  }

  // 利用目前速度和位置更新 y 座標
  void move() {
    yPos += ySpeed; // 利用 y 方向上的速度更新 y 座標
    for (int i = 0; i < 3; i++) {
      p[i].xPos -= pillar_velocity; // 順便讓第 i 根柱子往左移動
    }
  }

  // 碰撞檢測的函數
  void checkCollisions() {
    // 如果 y 方向超出遊戲畫面
    if (yPos > 610 || yPos < 0) {
      end = true;
    }
    for (int i = 0; i < 3; i++) {
      // 檢查和第 i 根柱子有沒有發生碰撞
      if ((xPos < p[i].xPos + 20 && xPos > p[i].xPos - 20) && (yPos < p[i].opening - opening_half_width || yPos > p[i].opening + opening_half_width)) {
        end = true;
      }
    }
  }
}

// 定義一個新的類別，柱子
class pillar {
  float xPos, opening; // xPos 紀錄柱子的 x 座標，opening 紀錄開口中央的 y 座標
  boolean cashed = false; // cashed 紀錄是否已經經過柱子，預設為 false，避免重複加分

  // pillar 的建構子 (constructor)，預設位置為 (100 + i * 200, 隨機開口位置)，其中 i 為第 i 根柱子
  pillar(int i) {
    xPos = 100 + (i * 200);
    opening = random_opening();
  }
  
  // 將柱子繪製在畫面上的函數
  void drawPillar() {
    imageMode(CENTER);
    image(pillar_up, xPos, opening - opening_half_width - 350, 40, 700);
    image(pillar_down, xPos, opening + opening_half_width + 350, 40, 700);
  }

  // 檢查柱子是不是已經到達畫面最左邊及是否通過鳥的位置
  void checkPosition() {
    // 如果已經到達畫面最左邊，則將柱子移到畫面最右邊
    // 並重新隨機產生開口位置
    if (xPos < 0) {
      xPos += (200 * 3);
      opening = random_opening();
      cashed = false;
    }
    // 如果鳥已經經過柱子，則加分
    // 並將柱子標記為已經經過
    if (xPos < 250 && cashed == false) {
      cashed = true;
      score++;
    }
  }
}

// 重置遊戲的函數
void reset() {
  end = false;
  score = 0;
  b.yPos = 400;
  for (int i = 0; i < 3; i++) {
    p[i].xPos += 550;
    p[i].cashed = false;
  }
}

// 如果按下滑鼠或按下空白鍵
void mousePressed() {
  b.jump(); // 鳥跳一下
  intro = false;

  // 如果遊戲已經結束，按一下滑鼠會重置遊戲
  if (end == true) {
    reset();
  }
}
void keyPressed() {
  b.jump(); // 鳥跳一下
  intro = false;

  // 如果遊戲已經結束，按一下任意鍵會重置遊戲
  if (end == true) {
    reset();
  }
}

// 產生隨機開口位置的函數
float random_opening() {
  return random(300) + 100;
}
