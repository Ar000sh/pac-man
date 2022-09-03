part of pacmann;


class Controller {


   
  //the to be controlled model. 
  Game game;
  // the to be controlled view 
  View view;
  // this variable is for the highscore 
  int currentHighscore = 0;

  // this variable is for the score 
  int score = 0;
  // used to stop the gameloop 
  bool turnoff = false;
  // used to determine whether a game is over 
  bool gameOver = true;
  // used to decised whether code in the gameLoop can be runrun 
  bool startGame = false;
  

 
  Controller() {

    game = Game();
    game.levelnum = 1;
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

  // run the gameloop methode periodicly every 50 milliseconds 
  void start() {
    Timer.periodic(Duration(milliseconds: 50), gameloop,);
  }

// this methode is used to check if the player is colliding with one of the ghosts and react accordingly. depending on whether the ghost that the player 
//is colliding with is vundrable or not it can either be restted to its staring condition or kill the player 

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

// this methode is used to determine if the player is colliding with a Powerup and delete and triggerst the ghosts changeModes methode that makes ghost vundrable
  void playerPowerupCollision(PowerUp powerUp, Player player, int index) {
    if (hypot(powerUp.x - player.x,powerUp.y - player.y) < powerUp.radius + player.radius) {
      view.deletePowerup(index);
      game.powerups.removeAt(index);
      game.ghosts.forEach((ghost) { 
        ghost.changeModes(); 
      });

    }

  }

// get the highscore 
Future<void> getHighscore() async {
    var response = await http.get(Uri.parse('http://127.0.0.1:5000/highscore'));
    currentHighscore = int.parse(response.body);
    view.setHighscore(response.body);
}
// sets a new Highscore 

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



// in this methode is the code the control the game 
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

// this is the methode used get the parameters of a Level from its corresponding json file und the change the Level by calling the Game's changeLevel function
  void _loadLevel() async {
    var response = await http.get(Uri.http(window.location.host, "/levels/Level${game.levelnum}.json"));
    var parameters = jsonDecode(response.body);
    game.changeLevel(parameters["ghostspeed"] as int, parameters["blinky"] as double, parameters["clyde"] as double);
    
  }


  // the is the methode is called we the game is over and is used to set all the necessary parameters to be able to restart the game  
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