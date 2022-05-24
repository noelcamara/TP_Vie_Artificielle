
import java.util.*;

int row = 25, column = 25;
int grid[][] = new int[row][column];
boolean alterne = false, go = false;
boolean rectOverPlay = false, rectOverInit = false, rectOverCell = false;
int rectPlayX, rectPlayY, rectPlaySizeX, rectPlaySizeY;
int rectInitX, rectInitY, rectInitSizeX, rectInitSizeY;
int rectCellX, rectCellY, rectCellSizeX, rectCellSizeY;

/*
Initialisation de la fenêtre
*/
void setup() {
  size(500, 550);
  
  // Bouton Lancer/Arreter
  rectPlayX = width - 65;
  rectPlayY = height - 35;
  rectPlaySizeX = 50;
  rectPlaySizeY = 20;
   
  // Bouton Initialiser
  rectInitX = 10;
  rectInitY = height - 35;  
  rectInitSizeX = 50;
  rectInitSizeY = 20;
  
  background(230);
  frameRate(4);
}

/*
Initialisation d'une grille vide
*/
void setupEmpty() {
  for (int i = 0; i < row; i++) 
    for (int j = 0; j < column; j++) 
      grid[i][j] = 0; // 0 = cellule inactive
}

/*
Initialisation de la grille au hasard avec au plus 20 cellules actives 
*/
void setupRandom() {
  for(int i = 0; i < 20; i++) 
    grid[(int)(random(row))][(int)(random(column))] = 1;
}

/*
Dessin de la fenêtre
*/
void draw() {
  checkButtons(); // Vérifie si l'utilisateur appuie sur un bouton
  
  drawGrid();  // Dessine la grille
  drawButtons();  // Dessine les boutons
  
  playStop(); // Lance/Arrête l'automate
}


/*
Dessine la grille à partir du haut
*/

void drawGrid() {
   stroke(128,208,208);

  for (int i = 0; i < row; i++) {
    for (int j = 0; j < column; j++) {
      fill(255);
      rect(i*20,  j*20,  19,  19);
      if(grid[i][j] == 1){ 
         float r =random(255); // changement de couleur a chaque mouvement
      float g = random(255);
      float b = random(255);
      fill(r,g,b);
      ellipse(i*20+10, j*20+10, 15, 15);
      }
    }
  }
}

/*
Dessine les boutons en bas avec leur label
*/
void drawButtons() {
  // Dessin des rectangles
  fill(255);
  stroke(0);
  rect(rectPlayX,rectPlayY,rectPlaySizeX,rectPlaySizeY);
  rect(rectInitX,rectInitY,rectInitSizeX,rectInitSizeY);  

  
  // Ecriture des labels
  fill(0);
  if(go)  text("STOP",rectPlayX + 10, rectPlayY + 15);
  else    text("GO",rectPlayX + 10, rectPlayY + 15);
  text("SETUP",rectInitX + 5, rectInitY + 15);

}

/*
Lance ou arrête l'automate si nécessaire
*/
void playStop() {
  fill(0);
  if(go) { 
    if(!alterne)  update(0);
    else  update(1);
    alterne = !alterne;
  }
}

/*
Mise à jour de la grille 
*/
void update(int index) {
   for (int i = index; i < row - 1; i+=2) 
    for (int j = index; j < column - 1; j+=2) 
      rotateIfHasTo(i,j);
}

/*
Effectue la rotation d'une case donnée si nécessaire
*/
void rotateIfHasTo(int i, int j) {
  switch(getCaseToRotate(i,j)) {
    case 1 : // En haut à gauche 
      grid[i][j] = 0; 
      grid[i][j+1] = 1;  
     
    break;
    case 2 :  // En haut à droite 
      grid[i][j+1] = 0; 
      grid[i+1][j+1] = 1;  
    break;
    case 3 :  // En bas à gauche 
      grid[i+1][j] = 0; 
      grid[i][j] = 1;  
    break;
    case 4 :  // En bas à droite 
      grid[i+1][j+1] = 0; 
      grid[i+1][j] = 1;  
    break;
    default: // On ne fait rien
    break;
   }
}

/*
Renvoie la case à rotater si elle existe
*/
int getCaseToRotate(int i, int j) {
  int nb_cells_on = 0;
  int ret = -1;
  
  if(grid[i][j] == 1) { // En haut à gauche
    nb_cells_on++;
    ret = 1; 
  }
    
  if(grid[i][j+1] == 1) { // En haut à droite
    nb_cells_on++;
    ret = 2;
  }
  
  if(grid[i+1][j] == 1) { // En bas à gauche
    nb_cells_on++;
    ret = 3;
  }
    
  if(grid[i+1][j+1] == 1) { // En haut à droite
    nb_cells_on++;
    ret = 4;
  }
    
  if(nb_cells_on > 1)  ret = -1;
  return ret;
}

/*
Vérifie si la souris est sur l'un des boutons
*/
void checkButtons() {
  if(overRect(rectPlayX, rectPlayY, rectPlaySizeX, rectPlaySizeY))  {
    rectOverPlay = true;
    rectOverInit = false;
    rectOverCell = false;
  }
  else if(overRect(rectInitX, rectInitY, rectInitSizeX, rectInitSizeY))  {
    rectOverInit = true;
    rectOverPlay = false;
    rectOverCell = false;
  }
  else if(overRect(rectCellX, rectCellY, rectCellSizeX, rectCellSizeY))  {
    rectOverCell = true;
    rectOverPlay = false;
    rectOverInit = false;
  }
  else {
    rectOverPlay = false;
    rectOverInit = false;
    rectOverCell = false;
  } 
}

/*
Gestion du clic de la souris
*/
void mousePressed() {
  // Lance ou arrête le jeu
  if (rectOverPlay)  go = !go;
 
  
  // Réinitialise la grille
  if (rectOverInit) {
    setupEmpty();
    setupRandom();
  }
}

/*
Vérifie si la souris est sur le rectangle donné
*/
boolean overRect(int x, int y, int width, int height)  {
  if (mouseX >= x && mouseX <= x+width && 
      mouseY >= y && mouseY <= y+height) {
    return true;
  } 
  return false;
}
