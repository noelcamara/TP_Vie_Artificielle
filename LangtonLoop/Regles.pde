class Regles {
  /** Ensemble de règles, chaque règle est un tableau d'entiers
    * au format CNESOC ou le premier C correspond à la valeur
    * actuelle de la cellule, N à la case au nord, etc. et le
    * dernier C à la valeur résultat de la cellule si la règle
    * s'applique. */
  int[][] regles;
  
  Regles(String fichier) {
    String[] lines = loadStrings(fichier);
    regles = new int[lines.length*4][6];
    
    for(int i=0; i<lines.length; i++) {
      for(int j=0; j<6; j++) {
        regles[i*4][j] = lines[i].charAt(j)-48;
      }
      rotations(i*4, 1);
      rotations(i*4, 2);
      rotations(i*4, 3);
    }
  }
  
  void rotations(int src, int off) {
    regles[src+off][0] = regles[src][0];
    regles[src+off][5] = regles[src][5];
    for(int i=0; i<4; i++) {
      regles[src+off][i+1] = regles[src][1+((i+off)%4)];
    }
  }
  
  int correspond(int c, int h, int d, int b, int g) {
  for(int i = 0;i < regles.length;i++){
      if(regles[i][0] == c && regles[i][1] == h && regles[i][2] == d && regles[i][3] == b && regles[i][4] == g)
        return regles[i][5];
     }
     return 0;
  }
}
