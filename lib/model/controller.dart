part of pacmann;


class Controller {


  Map map;
  Player player;
  List<Ghost> ghosts;
  View view;
  int levelnum = 0;
  int currentHighscore = 0;

  bool debug = false;
  int score = 0;
  bool turnoff = false;
  bool gameOver = true;
  bool changelevel = true;
  bool startGame = false;
  

 
  Controller() {
    
    
    this.map = new Map();
    this.map.createMap();
    
    
    levelnum = 1;
    this.player = new Player(this.map.boundaries,5);
    this.ghosts = [
        new Blinky(2, this.player,this.map.boundaries,(Boundary.WIDTH * 4).toDouble()),
        new Pinky( 2, this.player,this.map.boundaries),
        new Clyde( 2, this.player,this.map.boundaries,(Boundary.WIDTH * 3).toDouble())
      ];
    this.ghosts.add(new Inky( 2, this.player,this.map.boundaries,ghosts[0]));
    
    this.view = new View(this.map,player,ghosts);
     view.startButton.onClick.listen((_) {
      if (gameOver) {
        startGame = true;
        gameOver = false;
        start();
      }
      
      print(startGame);
    });
    
    getHighscore();
    view.updateLevel(levelnum);
    player.handleKeyboard();

    view.createBoundaries();

    view.createPellets();

    view.createPowerups();

    view.createGhosts();
    view.createLives();
    



    
  }
  void reset() {
    player.x = player.start[0];
    player.y = player.start[1];
    player.velx = player.start[2];
    player.vely = player.start[3];
    ghosts.forEach((ghost) { 
      ghost.x = ghost.start[0];
      ghost.y = ghost.start[1];
      ghost.velx = ghost.start[2];
      ghost.vely = ghost.start[3];
      ghost.inGhosthous = true;
      ghost.movenormally = false;

    });
  }
  void changeLevel() {
    
    levelnum++;
    view.updateLevel(levelnum);
    if (levelnum == 1) {
      
      ghosts.forEach((ghost) {
        ghost.speed = 2;
        if (ghost is Blinky) {
          ghost.chasedistance = 4;
        }
        if (ghost is Clyde) {
          ghost.chasedistance = 3;
        }
      }); 

    }
    if (levelnum == 2) {
      ghosts.forEach((ghost) {
        if (ghost is Blinky) {
          ghost.chasedistance = 6;
        }
        if (ghost is Clyde) {
          ghost.chasedistance = 5;
        }
      }); 

    }
    if (levelnum == 3) {
      ghosts.forEach((ghost) {
        ghost.speed = 4;
        if (ghost is Blinky) {
          ghost.chasedistance = 4;
        }
        if (ghost is Clyde) {
          ghost.chasedistance = 3;
        }
      });
    }
    if (levelnum == 4) {
      ghosts.forEach((ghost) {
        ghost.speed = 4;
        if (ghost is Blinky) {
          ghost.chasedistance = 6;
        }
        if (ghost is Clyde) {
          ghost.chasedistance = 5;
        }
      }); 

      
    }
    if (levelnum == 5) {
      ghosts.forEach((ghost) {
        ghost.speed = 5;
        if (ghost is Blinky) {
          ghost.chasedistance = 4;
        }
        if (ghost is Clyde) {
          ghost.chasedistance = 3;
        }
      });
    }
    if (levelnum == 6) {
      ghosts.forEach((ghost) {
        ghost.speed = 5;
        if (ghost is Blinky) {
          ghost.chasedistance = 6;
        }
        if (ghost is Clyde) {
          ghost.chasedistance = 5;
        }
      });
    }

  }
  void start() {
    Timer.periodic(Duration(milliseconds: 50), gameloop,);
  }

  void ghostPlayerCollision() {
    Ghost ghost;
    for(int i = this.ghosts.length - 1; i >= 0; i--) {
      ghost = this.ghosts[i];
      if (hypot(ghost.x - player.x,ghost.y - player.y) < ghost.radius + player.radius) {
        if (ghost.scared) {
          ghosteaten(ghost);
        } else {
          turnoff = true;
        }

     }
    }
  }


  void playerPowerupCollision(PowerUp powerUp, Player player, int index) {
    if (hypot(powerUp.x - player.x,powerUp.y - player.y) < powerUp.radius + player.radius) {
      view.deletePowerup(index);
      map.powerups.removeAt(index);
      this.ghosts.forEach((ghost) { 
        ghost.changeModes(); 
      });

    }

  }


Future<void> getHighscore() async {
    var response = await http.get(Uri.parse('http://127.0.0.1:5000/highscore'));
    currentHighscore = int.parse(response.body);
    view.setHighscore(response.body);
}
Future<void> setaNewHighscore(int highscore) async {
  if (highscore > currentHighscore) {
    var response1 = await http.post(
    Uri.parse('http://127.0.0.1:5000/highscore'),
    headers: {
        'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode({
        'highscore': highscore
    }),
  );
  }
    
  await getHighscore();
}

  void ghosteaten(Ghost ghost) {
    ghost.x = ghost.start[0];
    ghost.y = ghost.start[1];
    ghost.velx = ghost.start[2];
    ghost.vely = ghost.start[3];
    ghost.inGhosthous = true;
    ghost.movenormally = false;
    ghost.scared = false;
    ghost.scared2 = false;
  }


  void gameloop(Timer timer) {
    if (startGame) {
      map.boundaries.forEach((boundary) {
        if (rectangleCircleCollision(player.x,boundary.x,player.y,boundary.y,player.radius,player.velx,player.vely)){
            player.velx = 0;
            player.vely = 0;
        }
      });
      
      for (int i = map.pellets.length - 1; i >= 0; i--) {
        Pellet currentpellet = map.pellets[i];
        if (circleCircleCollision(currentpellet,player)) {
          view.deletePellet(i);
          map.pellets.removeAt(i);
          score = score + 10;
          view.updateScore(score);

        }
      }


      for (int index = 0; index < ghosts.length; index++) {
        Ghost ghost = ghosts[index];
        view.drawGhost(ghost, index);
        ghost.update();
        view.updateGhost(ghost, index);
        ghost.moveGhost();     

          
      }

      ghostPlayerCollision();
      

      for(int i = map.powerups.length - 1; i >= 0; i--) {
        PowerUp powerup = map.powerups[i];
        playerPowerupCollision(powerup,player,i);

      }


    
      player.movePlayer();
      view.drawPlayer();
      player.update();
      view.updatePlayer();
      if (turnoff) {
        timer.cancel();
        view.playerdies();
        Timer(Duration(milliseconds: 1000), () {
          if (view.lives.isNotEmpty) {
            view.deletelife();
            turnoff = false;
            reset();
            Timer.periodic(Duration(milliseconds: 50), gameloop,);

          }else {
            setaNewHighscore(score);
            createNewGame();
          }        
                
        });
      
      }

        if(map.pellets.isEmpty) {
          view.deleteGhosts();
          map.createPelletsandPowerUps();
          view.createPellets();
          view.createPowerups();
          view.createGhosts();
          changeLevel();
          reset();
          print(map.pellets.length);
          print(view.pellets.length);
          
        }
    }
  }

  void createNewGame() {
    gameOver = true;
    startGame = false;
    turnoff = false;
    levelnum = 0;
    score = 0;
    view.createLives();
    if (view.pellets.isNotEmpty) {
      int pelletslen = view.pellets.length;
      for (int i = 0; i < pelletslen; i++) {
        view.deletePellet(0);
        map.pellets.removeAt(0);
       }
 
                
     }
    if (view.powerUps.isNotEmpty) {
      int powerUpslen = view.powerUps.length;
      for (int i = 0; i < powerUpslen; i++) {
        view.deletePowerup(0);
        map.powerups.removeAt(0);
      }

    }
    view.deleteGhosts();
    map.createPelletsandPowerUps();
    view.createPellets();
    view.createPowerups();
    view.createGhosts();
    changeLevel();
    reset();
    

  }
  

}