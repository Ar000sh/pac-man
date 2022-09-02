part of pacmann;


class Controller {


  // Map map;
  // Player player;
  // List<Ghost> ghosts;
  Game game;
  View view;
  // int levelnum = 0;
  int currentHighscore = 0;


  int score = 0;
  bool turnoff = false;
  bool gameOver = true;
  bool startGame = false;
  

 
  Controller() {

    game = Game();
    
    
    // this.map = new Map();
    // this.map.createMap();
    
    
    game.levelnum = 1;
    // this.player = new Player(this.map.boundaries,5);
    // this.ghosts = [
    //     new Blinky(2, this.player,this.map.boundaries,(Boundary.WIDTH * 4).toDouble()),
    //     new Pinky( 2, this.player,this.map.boundaries),
    //     new Clyde( 2, this.player,this.map.boundaries,(Boundary.WIDTH * 3).toDouble())
    //   ];
    // this.ghosts.add(new Inky( 2, this.player,this.map.boundaries,ghosts[0]));
    
    this.view = new View();
     view.startButton.onClick.listen((_) {
      if (gameOver) {
        startGame = true;
        gameOver = false;
        start();
      }
      
      print(startGame);
    });
    
    getHighscore();
    view.updateLevel(game.levelnum);
    // player.handleKeyboard();

    view.createBoundaries(game);

    view.createPellets(game);

    view.createPowerups(game);

    view.createGhosts(game);
    view.createLives();
    



    
  }
  // void reset() {
  //   player.x = player.start[0];
  //   player.y = player.start[1];
  //   player.velx = player.start[2];
  //   player.vely = player.start[3];
  //   ghosts.forEach((ghost) { 
  //     ghost.x = ghost.start[0];
  //     ghost.y = ghost.start[1];
  //     ghost.velx = ghost.start[2];
  //     ghost.vely = ghost.start[3];
  //     ghost.inGhosthous = true;
  //     ghost.movenormally = false;

  //   });
  // }
  // void changeLevel() {
    
  //   levelnum++;
  //   view.updateLevel(levelnum);
  //   if (levelnum == 1) {
      
  //     ghosts.forEach((ghost) {
  //       ghost.speed = 2;
  //       if (ghost is Blinky) {
  //         ghost.chasedistance = 4;
  //       }
  //       if (ghost is Clyde) {
  //         ghost.chasedistance = 3;
  //       }
  //     }); 

  //   }
  //   if (levelnum == 2) {
  //     ghosts.forEach((ghost) {
  //       if (ghost is Blinky) {
  //         ghost.chasedistance = 6;
  //       }
  //       if (ghost is Clyde) {
  //         ghost.chasedistance = 5;
  //       }
  //     }); 

  //   }
  //   if (levelnum == 3) {
  //     ghosts.forEach((ghost) {
  //       ghost.speed = 4;
  //       if (ghost is Blinky) {
  //         ghost.chasedistance = 4;
  //       }
  //       if (ghost is Clyde) {
  //         ghost.chasedistance = 3;
  //       }
  //     });
  //   }
  //   if (levelnum == 4) {
  //     ghosts.forEach((ghost) {
  //       ghost.speed = 4;
  //       if (ghost is Blinky) {
  //         ghost.chasedistance = 6;
  //       }
  //       if (ghost is Clyde) {
  //         ghost.chasedistance = 5;
  //       }
  //     }); 

      
  //   }
  //   if (levelnum == 5) {
  //     ghosts.forEach((ghost) {
  //       ghost.speed = 5;
  //       if (ghost is Blinky) {
  //         ghost.chasedistance = 4;
  //       }
  //       if (ghost is Clyde) {
  //         ghost.chasedistance = 3;
  //       }
  //     });
  //   }
  //   if (levelnum == 6) {
  //     ghosts.forEach((ghost) {
  //       ghost.speed = 5;
  //       if (ghost is Blinky) {
  //         ghost.chasedistance = 6;
  //       }
  //       if (ghost is Clyde) {
  //         ghost.chasedistance = 5;
  //       }
  //     });
  //   }

  // }
  void start() {
    Timer.periodic(Duration(milliseconds: 50), gameloop,);
  }

  void ghostPlayerCollision() {
    Ghost ghost;
    for(int i = game.ghosts.length - 1; i >= 0; i--) {
      ghost = game.ghosts[i];
      if (hypot(ghost.x - game.player.x,ghost.y - game.player.y) < ghost.radius + game.player.radius) {
        if (ghost.scared) {
          game.ghosteaten(ghost);
        } else {
          turnoff = true;
        }

     }
    }
  }


  void playerPowerupCollision(PowerUp powerUp, Player player, int index) {
    if (hypot(powerUp.x - player.x,powerUp.y - player.y) < powerUp.radius + player.radius) {
      view.deletePowerup(index);
      game.powerups.removeAt(index);
      game.ghosts.forEach((ghost) { 
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

  // void ghosteaten(Ghost ghost) {
  //   ghost.x = ghost.start[0];
  //   ghost.y = ghost.start[1];
  //   ghost.velx = ghost.start[2];
  //   ghost.vely = ghost.start[3];
  //   ghost.inGhosthous = true;
  //   ghost.movenormally = false;
  //   ghost.scared = false;
  //   ghost.scared2 = false;
  // }


  void gameloop(Timer timer) {
    if (startGame) {
      game.boundaries.forEach((boundary) {
        if (rectangleCircleCollision(game.player.x,boundary.x,game.player.y,boundary.y,game.player.radius,game.player.velx,game.player.vely)){
            game.player.velx = 0;
            game.player.vely = 0;
        }
      });
      
      for (int i = game.pellets.length - 1; i >= 0; i--) {
        Pellet currentpellet = game.pellets[i];
        if (circleCircleCollision(currentpellet,game.player)) {
          view.deletePellet(i);
          game.pellets.removeAt(i);
          score = score + 10;
          view.updateScore(score);

        }
      }


      for (int index = 0; index < game.ghosts.length; index++) {
        Ghost ghost = game.ghosts[index];
        view.drawGhost(ghost, index);
        ghost.update();
        view.updateGhost(ghost, index);
        ghost.moveGhost();     

          
      }

      ghostPlayerCollision();
      

      for(int i = game.powerups.length - 1; i >= 0; i--) {
        PowerUp powerup = game.powerups[i];
        playerPowerupCollision(powerup,game.player,i);

      }


    
      game.player.movePlayer();
      view.drawPlayer(game);
      game.player.update();
      view.updatePlayer(game);
      if (turnoff) {
        timer.cancel();
        view.playerdies(game);
        Timer(Duration(milliseconds: 1000), () {
          if (view.lives.isNotEmpty) {
            view.deletelife();
            turnoff = false;
            game.reset();
            Timer.periodic(Duration(milliseconds: 50), gameloop,);

          }else {
            setaNewHighscore(score);
            
            createNewGame();//ggggggggggggggggggggggggggggggggggggggg
          }        
                
        });
      
      }

        if(game.pellets.isEmpty) {
          view.deleteGhosts(game);
          game.createPelletsandPowerUps();
          view.createPellets(game);
          view.createPowerups(game);
          view.createGhosts(game);
          game.reset();
          game.levelnum++;
          if (game.levelnum < 7) {
            _loadLevel();
            view.updateLevel(game.levelnum);
          } else {
            timer.cancel();
          }
          
          //game.setnewLevel();
          
          
          print(game.pellets.length);
          print(game.pellets.length);
          
        }
    }
  }

    void _loadLevel() async {
    var response = await http.get(Uri.http(window.location.host, "/levels/Level${game.levelnum}.json"));
    var parameters = jsonDecode(response.body);
    game.changeLevel(parameters["ghostspeed"] as int, parameters["blinky"] as double, parameters["clyde"] as double);
    
  }

  void createNewGame() {
    gameOver = true;
    startGame = false;
    turnoff = false;
    game.levelnum = 1; // resetten in Game 
    score = 0;
    view.updateScore(score);
    view.createLives();
    if (view.pellets.isNotEmpty) {
      int pelletslen = view.pellets.length;
      for (int i = 0; i < pelletslen; i++) {
        view.deletePellet(0);
        game.pellets.removeAt(0);
       }
 
                
     }
    if (view.powerUps.isNotEmpty) {
      int powerUpslen = view.powerUps.length;
      for (int i = 0; i < powerUpslen; i++) {
        view.deletePowerup(0);
        game.powerups.removeAt(0);
      }

    }
    view.deleteGhosts(game);
    game.createPelletsandPowerUps();
    view.createPellets(game);
    view.createPowerups(game);
    view.createGhosts(game);
    _loadLevel();
    // game.setnewLevel();
    view.updateLevel(game.levelnum);
    game.reset();
    

  }
  

}