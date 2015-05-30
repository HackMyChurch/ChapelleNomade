
// Projet "Chapelle Nomade"
// de l'événement HackMyChurch 2015
// http://www.hackmychurch.com/

// Code Processing qui exécute le dispositif
// Testé avec Processing 2.2.1
// Fonctionne sous Mac

// Taille de l'écran
int WIDTH = 800;
int HEIGHT = 600;

// Durée d'affichage d'une image
// lors du diaporama zoom
int DURATION_IMG = 10000;

// Nombre d'images à faire défiler
int nbImgs = 2;

// Dimensions des images qui défilent
// (Note : pour le prototype, toutes les images
// avaient la même dimension, d'où ces constantes)
int imgW = 2560;
int imgH = 1600;

// Pas de déplacement sur les deux axes
// lorsque l'utilisateur navigue dans une image
int seuil_x = 400;
int seuil_y = 400;

import processing.video.*;

Movie movie;
Timer timer;

// On stocke les images dans un tableau
ArrayList<PImage> imgs = new ArrayList<PImage>();

float easing = 0.05;

// On crée une variable `STATUS`
// qui saura quel mode le script affichera
int STATUS = 1;

// On définit des constantes pour les deux modes :
// > VIEWING : contemplation (vidéo)
// > DOING : contempl'action (diaporama photo)
int VIEWING = 1;
int DOING = 2;

// (Future) position de l'image
// lors des déplacements
float img_x = 0;
float img_y = 0;

float targetX, targetY;

// Par défaut, la première (0) est affichée
int curImg = 0;


void setup() {
  size(WIDTH, HEIGHT);

  // Sinon, vous pouvez aussi :
  // size(displayWidth, displayHeight);

  background(0);

  // On charge la video qui s'appelle video.mov
  // et qui se trouve dans data/
  movie = new Movie(this, "video.mov");
  movie.loop();

  // On charge les images qui sont nommées
  // sous la forme :
  // img0.jpg
  // img1.jpg
  // img2.jpg
  // etc.

  for (int i = 0; i < nbImgs; i++) {
    imgs.add(loadImage("img"+i+".jpg"));
  }
}



void draw() {
  background(0);

  // Si le mode courant est la vidéo :
  if (is(VIEWING)) {
    
    // On affiche la vidéo
    image(movie, 0, 0);

    // Si on veut adapter la largeur de la vidéo à l'écran 
    // (risque de déformation non homothétique) : 
    // image(movie, 0, 0, displayWidth, displayHeight);
  }

  // Si le mode courant est le diaporama photo :
  if (is(DOING)) {
    
    // On vérifie le timer d'affichage des images
    checkTimer();

    // Pour éviter un déplacement trop sec
    // avec le `crucistick`, on applique
    // un easing (déplacement doux, amorti)
    
    targetX = max(min(0, targetX), WIDTH-imgW);
    targetY = max(min(0, targetY), HEIGHT-imgH);

    float dx = targetX - img_x;
    if (abs(dx) > 1) {
      img_x += dx * easing;
    }

    float dy = targetY - img_y;
    if (abs(dy) > 1) {
      img_y += dy * easing;
    }

    // Enfin, on affiche l'image courante
    // définie par ma variable `curImg`
    image(imgs.get(curImg), img_x, img_y);
  }
}

void movieEvent(Movie m) {
  m.read();
}

// Puisque le Makey Makey simule un clavier,
// on exploite la fonction keyPressed()

void keyPressed() {
  
  // Si on est en mode diaporama photo :
  if (is(DOING)) {
    if (key == CODED) {
      
      // Pour les déplacements avec le `crucistick`,
      // il vous sera peut-être plus logique
      // d'inverser le sens haut/bas gauche/droite :
      // cela dépend de vous, si appuyer sur HAUT
      // fait monter l'image (pour voir plus bas)
      // ou fait descendre l'image (pour voir plus haut)
      
      // Si on souhaite monter l'image :
      if (keyCode == UP) {
        
        // Alors on soustrait le pas à la position Y de l'image
        targetY = img_y - seuil_y;
      }

      // Si on souhaite descendre l'image :
      if (keyCode == DOWN) {
        
        // Alors on ajoute le pas à la position Y de l'image
        targetY = img_y + seuil_y;
      }
      
      // Etc pour Gauche et Droite

      if (keyCode == LEFT) {
        targetX = img_x - seuil_x;
      }

      if (keyCode == RIGHT) {
        targetX = img_x + seuil_x;
      }
    }
  }

  // On est attentif à la touche Espace
  // qui permet de changer de mode :

  if (key == ' ') {
    // Si on était en mode vidéo
    
    if (STATUS == VIEWING) {
      // On passe en mode diaporama photo
      STATUS = DOING;

      // Et on relance le timer
      goTimer(DURATION_IMG);
    } 
    else {
      // Sinon, si on était en mode diaporama photo,
      // on passe en mode vidéo
      
      STATUS = VIEWING;
    }
  }
}


// Petite fonction pour initialiser le timer

void goTimer(int time) {
  timer = new Timer(time);
  timer.start();
}


// Cette fonction vérifie l'échéance du timer

void checkTimer() {
  // Si on est en mode diaporama photo :
  
  if (is(DOING)) {
    
    // Si le timer est terminé :
    if (timer.isFinished()) {
      
      // Alors on passe à l'image suivante
      curImg++;
      
      // On fait attention de ne pas dépasser la limite,
      // et on fait boucler les images
      if (curImg > nbImgs) {
        curImg = 0;
      }

      // Et on relance le timer
      goTimer(DURATION_IMG);
    }
  }
}

// Fonction booléenne pour comparer
// un mode avec le mode courant

Boolean is(int state) {
  return state == STATUS;
}

