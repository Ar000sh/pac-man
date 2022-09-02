part of pacmann;

// The View class is what interacts the the DOM Tree 
class View{
  // Game game;
  // Player player;
  // List<Ghost> ghosts;
  DivElement field = document.querySelector('#field') as DivElement;
  DivElement pacmanwrapper = document.querySelector('#pacmanwrapper') as DivElement;
  int playerbackgroundindex = 0;

  List<DivElement> boundaries = [];
  List<DivElement> pellets = [];
  List<DivElement> powerUps = [];
  List<DivElement> ghostbodys = [];
  List<DivElement> ghosteyes = [];
  List<DivElement> lives = [];
  SpanElement highscore = document.querySelector('#HighscoreEl') as SpanElement;
  SpanElement level = document.querySelector('#levelEl') as SpanElement;
  HtmlElement get startButton => querySelector('#start');

  

  SpanElement scoreEL = document.querySelector('#scoreEl') as SpanElement;

  View();

  void createBoundaries(Game game) {
    for (var boundary in game.boundaries) {
      DivElement newchild = DivElement();
      newchild.className = "boundary";
  // newchild.style.background ="white";
      newchild.style.background ="url(img/${boundary.img}.png)";
      newchild.style.left = "${boundary.x}px";
      newchild.style.top = "${boundary.y}px";
      field.append(newchild);
    }
  }


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

  void deletePellet(int index) {
    pellets[index].remove();
    

    pellets.removeAt(index);
  }
  // void deleteAllPellet() {
    
  //   pellets.forEach((pellet) {
  //     pellet.remove();
  //     pellets.removeAt(pellets.indexOf(pellet));
  //   });
    
  //   // pellets.removeAt(0);
  // }
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

  void deletePowerup(int index) {
    powerUps[index].remove();
    powerUps.removeAt(index);
  }

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

  void updatePlayer(Game game) {
    pacmanwrapper.style.left = '${game.player.x - 4}px';
    pacmanwrapper.style.top = '${game.player.y - 4}px';
  }

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

  void updateGhost(Ghost ghost, int index) {

    ghostbodys[index].style.left = '${ghost.x -4}px';
    ghostbodys[index].style.top = '${ghost.y - 4}px';
        
    ghosteyes[index].style.left = '${ghost.x -4}px';
    ghosteyes[index].style.top = '${ghost.y - 4}px';
  }


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
  void deletelife() {
    lives[0].remove();
    lives.removeAt(0);
  }

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
  void setHighscore(String score) {
    highscore.setInnerHtml(score);


  }
  void updateScore(int score) {
    scoreEL.setInnerHtml("$score");
  }
  void updateLevel(int levelnum) {
    level.setInnerHtml("$levelnum");
  }

}