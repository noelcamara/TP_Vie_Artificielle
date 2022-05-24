
Regles regle;
int [][]etatIniatial = {
  {0, 2, 2, 2, 2, 2, 2, 2, 2, 0, 0, 0, 0, 0, 0}, 
  {2, 1, 7, 0, 1, 4, 0, 1, 4, 2, 0, 0, 0, 0, 0}, 
  {2, 0, 2, 2, 2, 2, 2, 2, 0, 2, 0, 0, 0, 0, 0}, 
  {2, 7, 2, 0, 0, 0, 0, 2, 1, 2, 0, 0, 0, 0, 0}, 
  {2, 1, 2, 0, 0, 0, 0, 2, 1, 2, 0, 0, 0, 0, 0}, 
  {2, 0, 2, 0, 0, 0, 0, 2, 1, 2, 0, 0, 0, 0, 0}, 
  {2, 7, 2, 0, 0, 0, 0, 2, 1, 2, 0, 0, 0, 0, 0}, 
  {2, 1, 2, 2, 2, 2, 2, 2, 1, 2, 2, 2, 2, 2, 0}, 
  {2, 0, 7, 1, 0, 7, 1, 0, 7, 1, 1, 1, 1, 1, 2}, 
  {0, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 0}
};

color[] colors = new color[]{
  color(  0, 0, 0), 
  color(  0, 0, 255), 
  color(255, 0, 0), 
  color(  0, 255, 0), 
  color(255, 255, 0), 
  color(255, 0, 255), 
  color(255, 255, 255), 
  color(  0, 255, 255)
};

int scl = 6;
int cols ;
int rows ;
int [][]langtonLoop;
int [][]nextStape;

void setup() {

  size(1000, 1000);
  regle = new Regles("langtonloop.txt");
  cols = floor(width/scl);
  rows = floor(height/scl);
  langtonLoop = new int[cols][rows];
  nextStape = new int[cols][rows];;
  setupFirstEtat();
}

void draw() {
  displayLangtonLoop();
  nextStape();
}

void setupFirstEtat() {

  int x = (width/scl)/2;
  int y = (height/scl)/2;
  for (int i = x; i < x+ etatIniatial.length; i++) {
    for (int j = y; j < y + etatIniatial[i-x].length; j++)
      langtonLoop[j][i] = etatIniatial[i-x][j-y];
  }
}

void displayLangtonLoop() {
  for (int i = 0; i < langtonLoop.length; i++) {
    for (int j = 0; j < langtonLoop[i].length; j++) {
      fill(colors[langtonLoop[i][j]]);
      rect(i*scl, j*scl, scl, scl);
    }
  }
}

public void nextStape() {
  for (int i = 1; i < langtonLoop.length-1; i++) {
    for (int j = 1; j < langtonLoop[i].length-1; j++) {
      nextStape[i][j] = regle.correspond(langtonLoop[i][j], langtonLoop[i][j-1], langtonLoop[i+1][j], langtonLoop[i][j+1], langtonLoop[i-1][j]);
    }
  }
  for (int i = 0; i < langtonLoop.length; i++) {
    System.arraycopy(nextStape[i], 0, langtonLoop[i], 0, nextStape[i].length);
  }
}
