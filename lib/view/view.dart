part of pacmann;

// The View class is what interacts the the DOM Tree 
class View{
  // the Feld html element in HTML-Document 
  DivElement field = document.querySelector('#field') as DivElement;
  // pacman 
  DivElement pacmanwrapper = document.querySelector('#pacmanwrapper') as DivElement;
  // used in drawPlayer methode to choose which picture to use as background for the player
  int playerbackgroundindex = 0;
  // used for the boundaries div elements that will be created in the create function and that manipulited in other functions
  List<DivElement> boundaries = [];
  // used for the pellets div elements that will be created in the create function and that manipulited in other functions
  List<DivElement> pellets = [];
  // used for the powerUps div elements that will be created in the create function and that manipulited in other functions
  List<DivElement> powerUps = [];
  
  // used for the ghostbodys div elements that will be created in the create function and that manipulited in other functions
  List<DivElement> ghostbodys = [];
  // used for the ghosteyes div elements that will be created in the create function and that manipulited in other functions
  List<DivElement> ghosteyes = [];
  // used for the lives div elements that will be created in the create function and that manipulited in other functions
  List<DivElement> lives = [];
  // spanElement for the highscore the Html document
  SpanElement highscore = document.querySelector('#HighscoreEl') as SpanElement;
  // spanelment for the Level in the html document 
  SpanElement level = document.querySelector('#levelEl') as SpanElement;
  // startbuttom from the html-documnet 
  HtmlElement get startButton => querySelector('#start');

  // spanelment for the score in the html document 
  SpanElement scoreEL = document.querySelector('#scoreEl') as SpanElement;

  View();

// this methode is used to create div elements for the boundaries in the game add then adding them to the 
// boundaries list to be used in other methodes 
  void createBoundaries(Game game) {
    for (var boundary in game.boundaries) {
      DivElement newchild = DivElement();
      newchild.className = "boundary";
      newchild.style.background ="url(img/${boundary.img}.png)";
      newchild.style.left = "${boundary.x}px";
      newchild.style.top = "${boundary.y}px";
      field.append(newchild);
    }
  }

// this methode is used to create div elements for the pellets in the game add then adding them to the 
// pellets list to be used in other methodes 
  void createPellets(Game game) {
    for (var pellet in game.pellets) {
      DivElement newchild = DivElement();
      newchild.className = "collectibles";
  // newchild.style.background ="white";
      newchild.style.background = 'url(img/pellet.png)';
      newchild.style.left = "${pellet.x - 4}px";
      newchild.style.top = "${pellet.y - 4}px";
      pellets.add(newchild);
      field.append(newchild);
    }
  }

// this methode deletes an element at the index passed from the pellets List and delete the div element from the html document 
  void deletePellet(int index) {
    pellets[index].remove();
    

    pellets.removeAt(index);
  }

// this methode is used to create div elements for the powerups in the game add then adding them to the 
// powerups list to be used in other methodes 
  void createPowerups(Game game) {
    for (var powerups in game.powerups) {
      DivElement newchild = DivElement();
      newchild.className = "collectibles";
  // newchild.style.background ="white";
      newchild.style.background = 'url(img/powerup.png)';
      newchild.style.left = "${powerups.x - 4}px";
      newchild.style.top = "${powerups.y - 4}px";
      powerUps.add(newchild);
      field.append(newchild);
    }
  }


// this methode deletes an element at the index passed from the powerUps List and delete the div element from the html document 
  void deletePowerup(int index) {
    powerUps[index].remove();
    powerUps.removeAt(index);
  }


// this methode is used to determine which background the player gets and then changing it 
  void drawPlayer(Game game) {
    if (playerbackgroundindex == 1) {
      switch (game.player.direction) {
        case 'right':
          pacmanwrapper.style.background = "url(img/pacman/pacman_2r.png)";
          break;
        case 'left':
          pacmanwrapper.style.background = "url(img/pacman/pacman_2l.png)";
          break;
        case 'bottom':
          pacmanwrapper.style.background = "url(img/pacman/pacman_2d.png)";
          break;
        case 'top':
          pacmanwrapper.style.background = "url(img/pacman/pacman_2u.png)";
          break;
        default:
          pacmanwrapper.style.background = "url(img/pacman/pacman_2r.png)";

      }
      playerbackgroundindex = 2;
    } else {
      pacmanwrapper.style.background = "url(img/pacman/pacman_1.png)";
      playerbackgroundindex = 1;

    }

  }

// this methode updates the x and y positions of the div element for the player 
  void updatePlayer(Game game) {
    pacmanwrapper.style.left = '${game.player.x - 4}px';
    pacmanwrapper.style.top = '${game.player.y - 4}px';
  }

// this methode is used to create div elements for the createGhosts in the game add then adding them to the 
// ghostbody and ghosteyes lists to be used in other methodes 
  void createGhosts(Game game) {
    for (var ghost in game.ghosts) {
      DivElement ghostbody = DivElement();
      ghostbody.className = "ghostbody";
      ghostbodys.add(ghostbody);
      field.append(ghostbody);

      DivElement ghosteye = DivElement();
      ghosteye.className = "ghostbody";
      ghosteyes.add(ghosteye);
      field.append(ghosteye);
    }
  }

// this methode deletes an elements at the index passed from the ghostbodys and ghosteyes List and deletes the div elements from the html document 
  void deleteGhosts(Game game) {
    DivElement tempghostbody;
    DivElement tempghosteyes;
    print(game.ghosts.length);
    for (int i = 0; i < game.ghosts.length; i++) {
      tempghostbody = ghostbodys[0];
      ghostbodys.removeAt(0);
      tempghosteyes = ghosteyes[0];
      ghosteyes.removeAt(0);
      tempghostbody.remove();
      tempghosteyes.remove();
    }
  }

// this methode is used to set the background a ghost to blue when its vurnable 
  void drawBlueGhost(Ghost ghost,int index) {
    if (ghost.scared && !ghost.scared2) {
        ghosteyes[index].style.background = '';
      if(ghost.backgroundimg == 1) {
        ghostbodys[index].style.background = 'url(img/ghosts/scared/scared_1.png)';
        ghost.backgroundimg = 2;
      } else {
        ghostbodys[index].style.background = 'url(img/ghosts/scared/scared_2.png)';
        ghost.backgroundimg = 1;
      }   
    }

  }

// this methode is used to set the background a ghost to white when its vurnable
  void drawWhiteGhost(Ghost ghost,int index) {
    if (ghost.scared && ghost.scared2) {
      if(ghost.backgroundimg == 1) {
        ghostbodys[index].style.background = 'url(img/ghosts/scared/scared_3.png)';
        ghost.backgroundimg = 2;
      } else {
        ghostbodys[index].style.background = 'url(img/ghosts/scared/scared_4.png)';
        ghost.backgroundimg = 1;
      }
    
       
      }
    

  }

  // this methode is used to change the background for the ghost's eyes using the direction of the Ghost
    void drawGhostEyes(Ghost ghost,int index) {
    if (!ghost.scared) {
       switch (ghost.direction) {
        case 'right':
          ghosteyes[index].style.background = 'url(img/ghosts/eyes_r.png)';
          break;
        case 'left':
          ghosteyes[index].style.background = 'url(img/ghosts/eyes_l.png)';
          break;
        case 'top':
          ghosteyes[index].style.background = 'url(img/ghosts/eyes_u.png)';
          break;
        case 'bottom':
          ghosteyes[index].style.background = 'url(img/ghosts/eyes_d.png)';
          break;
        default:
        
      }
    }
     
  }

// this methode is used to set the background for the ghost
   void drawGhost(Ghost ghost, int index) {

    if (!ghost.scared && !ghost.scared2) {
      if (ghost.backgroundimg == 1) {
        if(ghost is Blinky) {
          ghostbodys[index].style.background = 'url(img/ghosts/blinky/blinky_1.png)';

        } else if(ghost is Pinky) {
          ghostbodys[index].style.background = 'url(img/ghosts/pinky/pinky_1.png)';

        } else if(ghost is Clyde) {
          ghostbodys[index].style.background = 'url(img/ghosts/clyde/clyde_1.png)';

        } else if(ghost is Inky) {
          ghostbodys[index].style.background = 'url(img/ghosts/inky/inky_1.png)';

        }
        ghost.backgroundimg = 2;
        
      } else {
        if(ghost is Blinky) {
          ghostbodys[index].style.background = 'url(img/ghosts/blinky/blinky_2.png)';

        } else if(ghost is Pinky) {
          ghostbodys[index].style.background = 'url(img/ghosts/pinky/pinky_2.png)';

        } else if(ghost is Clyde) {
          ghostbodys[index].style.background = 'url(img/ghosts/clyde/clyde_2.png)';

        } else if(ghost is Inky) {
          ghostbodys[index].style.background = 'url(img/ghosts/inky/inky_2.png)';

        }

        ghost.backgroundimg = 1;
        

      } 

      drawGhostEyes(ghost,index);
    }

    drawBlueGhost(ghost,index);
    drawWhiteGhost(ghost,index);
     
    
    
  }

// this methode is used to change ghostbody and ghosteyes x and y position based on the x and y positions of the passed ghost
  void updateGhost(Ghost ghost, int index) {

    ghostbodys[index].style.left = '${ghost.x -4}px';
    ghostbodys[index].style.top = '${ghost.y - 4}px';
        
    ghosteyes[index].style.left = '${ghost.x -4}px';
    ghosteyes[index].style.top = '${ghost.y - 4}px';
  }

// this methode is used to create div elements that act as the Lives for pacman and then adds them to the list Lives
  void createLives() {
    int x = 50;
    for (int i = 0; i < 2; i++) { 
      DivElement life = DivElement();
      life.className = 'pacmanlives';
      life.style.left = "${x}px";
      lives.add(life);
      field.append(life);
      x += 20;
    }
  }

  // this methode deletes an element  from the lives List and delete the div element from the html document 
  void deletelife() {
    lives[0].remove();
    lives.removeAt(0);
  }

// this methode used to create the animation of the player dying by going through 10 differebt backgrounds for player that change after 100 milliseconds
  void playerdies(Game game) {
    for (int i = 0; i < game.ghosts.length; i++) {
      ghostbodys[i].style.background = '';
      ghosteyes[i].style.background = '';

    }
    pacmanwrapper.style.background = "url(img/pacman/pacman_dies_1.png)";
    Timer(Duration(milliseconds: 100), () {
      pacmanwrapper.style.background = "url(img/pacman/pacman_dies_2.png)";
       Timer(Duration(milliseconds: 100), () {
        pacmanwrapper.style.background = "url(img/pacman/pacman_dies_3.png)";
        Timer(Duration(milliseconds: 100), () {
          pacmanwrapper.style.background = "url(img/pacman/pacman_dies_4.png)";
          Timer(Duration(milliseconds: 100), () {
            pacmanwrapper.style.background = "url(img/pacman/pacman_dies_5.png)";
            Timer(Duration(milliseconds: 100), () {
              pacmanwrapper.style.background = "url(img/pacman/pacman_dies_6.png)";
              Timer(Duration(milliseconds: 100), () {
                pacmanwrapper.style.background = "url(img/pacman/pacman_dies_7.png)";
                Timer(Duration(milliseconds: 100), () {
                  pacmanwrapper.style.background = "url(img/pacman/pacman_dies_8.png)";
                  Timer(Duration(milliseconds: 100), () {
                    pacmanwrapper.style.background = "url(img/pacman/pacman_dies_9.png)";
                    Timer(Duration(milliseconds: 100), () {
                      pacmanwrapper.style.background = "url(img/pacman/pacman_dies_10.png)";
            
                    });
                  });
                });
              });
            }); 
          });  
        });        
      });      
    });



  }

  // updates the highscore element by changing it with the passed score
  void setHighscore(String score) {
    highscore.setInnerHtml(score);


  }
  
  // updates the score element by changing it with the passed score
  void updateScore(int score) {
    scoreEL.setInnerHtml("$score");
  }

  // updates the level element by changing it with the passed level number
  void updateLevel(int levelnum) {
    level.setInnerHtml("$levelnum");
  }

}