part of pacmann;

class Game {

  // this is the map 
  final List<List<String>> map = [
  ['<','-','-','-','-','-','-','-','-','5','-','-','-','-','-','-','-','-','>'],
  ['|','*','*','p','*','*','*','*','*','|','*','*','*','*','*','*','*','*','|'],
  ['|','*','<','>','*','<','-','>','*','|','*','<','-','>','*','<','>','*','|'],
  ['|','*','0','/','*','0','-','/','*','u','*','0','-','/','*','0','/','*','|'],
  ['|','*','*','*','*','*','*','*','*','*','*','*','*','*','*','*','*','*','|'],
  ['|','*','[',']','*','N','*','[','-','5','-',']','*','N','*','[',']','*','|'],
  ['|','*','*','*','*','|','*','*','*','|','*','*','*','|','*','*','*','p','|'],
  ['0','-','-','>','*','1','-',']',' ','u',' ','[','-','2','*','<','-','-','/'],
  [' ',' ',' ','|','*','|',' ',' ',' ',' ',' ',' ',' ','|','*','|',' ',' ',' '],
  [' ',' ',' ','|','*','u',' ','<','-','-','-','>',' ','u','*','|',' ',' ',' '],
  [' ',' ',' ','|','*',' ',' ','|',' ',' ',' ','|',' ',' ','*','|',' ',' ',' '],
  [' ',' ',' ','|','*','N',' ','0','-','-','-','/',' ','N','*','|',' ',' ',' '],
  [' ',' ',' ','|','*','|',' ',' ',' ',' ',' ',' ',' ','|','*','|',' ',' ',' '],
  ['<','-','-','/','*','u',' ','[','-','5','-',']',' ','u','*','0','-','-','>'],
  ['|','*','*','*','*','*','*','*','*','|','*','*','*','*','*','*','*','*','|'],
  ['|','*','[','>','*','[','-',']','*','u','*','[','-',']','*','<',']','*','|'],
  ['|','*','*','|','*','*','*','*','*','*','*','*','*','*','*','|','*','*','|'],
  ['1',']','*','u','*','N','*','[','-','5','-',']','*','N','*','u','*','[','2'],
  ['|','*','*','*','p','|','*','*','*','|','*','*','p','|','*','*','*','*','|'],
  ['|','*','[','-','-','w','-',']','*','u','*','[','-','w','-','-',']','*','|'],
  ['|','*','*','*','*','*','*','*','*','*','*','*','*','*','*','*','*','p','|'],
  ['0','-','-','-','-','-','-','-','-','-','-','-','-','-','-','-','-','-','/']
  ];

  // this is where the level number is saved
  int levelnum = 0;

  // the to be created player
  Player player;
  // the to be created ghosts 
  List<Ghost> ghosts;
  // the to be created boundaries
  List<Boundary> boundaries = [];
  // the to be created pellets
  List<Pellet> pellets = [];
  // the to be created powerups 
  List<PowerUp> powerups = [];

  Game() {
    createMap();
    levelnum = 1;
    this.player = new Player(this,5);
    this.ghosts = [
        new Blinky(2, this,(Boundary.WIDTH * 4).toDouble()),
        new Pinky( 2, this),
        new Clyde( 2, this,(Boundary.WIDTH * 3).toDouble())
      ];
    this.ghosts.add(new Inky( 2, this,ghosts[0]));
    player.handleKeyboard();

  }



// this is the methode used to change the Level by setting the ghostspeed and the chancedistance for both Blinky and Clyde
  void changeLevel(int ghostspeed, double blinkydis, double clydedis) {
    ghosts.forEach((ghost) {
      ghost.speed = ghostspeed;
      if (ghost is Blinky) {
        ghost.chasedistance = blinkydis;
      }
      if (ghost is Clyde) {
        ghost.chasedistance = clydedis;
      }
    }); 

    

  }
// this methode is used to reset the player and ghosts to thier start poistions 
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

// this methode is used to reset the ghost passed to the methode to its startposition and make sure that the ghost isnt vundrable 
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


  // this is the Methode used to create all of the boundaries, pellets and powerups with right positions 
  void createMap() {
    
    
    int posx;
    int posy = 0;
    String item;
    List<String> row;
    for (int rowid = 0; rowid < map.length; rowid++) {
      row = map[rowid];
      if (rowid > 0) {
        posy += 20;
      }
      posx = 0;
      for (int itemid = 0; itemid < row.length; itemid++) {
        item = row[itemid];
        if (itemid > 0) {
          posx += 20;
        }
      
        if (item == '-') {
          //boundaries.add(new Boundary(c, posx, posy, 40, 40));
        }

        switch (item) {
          case '-':
            boundaries.add(new Boundary( posx, posy,'wall_h'));
            break;
          case '|':
            boundaries.add(new Boundary( posx, posy,'wall_v'));
            break;
          case ']':
            boundaries.add(new Boundary( posx, posy,'wall_r'));
            break;
          case '[':
            boundaries.add(new Boundary( posx, posy,'wall_l'));
            break;
          case 'u':
            boundaries.add(new Boundary( posx, posy,'wall_b'));
            break;
          case 'N':
            boundaries.add(new Boundary( posx, posy,'wall_t_20'));
            break;
          case 'w':
            boundaries.add(new Boundary( posx, posy,'wall_mb'));
            break;
          case '<':
            boundaries.add(new Boundary( posx, posy,'wall_tlc'));
            break;
          case '>':
            boundaries.add(new Boundary( posx, posy,'wall_trc'));
        
            break;
          case "0":
            boundaries.add(new Boundary( posx, posy,'wall_blc'));
            break;
          case '/':
            boundaries.add(new Boundary( posx, posy,'wall_brc'));
            break;
          case 'b':
            boundaries.add(new Boundary( posx, posy,'block'));
            break;
          case '1':
            boundaries.add(new Boundary( posx, posy,'wall_ml'));
            break;
          case '2':
            boundaries.add(new Boundary( posx, posy,'wall_mr'));
            break;

          case '5':
            boundaries.add(new Boundary( posx, posy,'wall_mt'));
            break;
        case '*':
        
            pellets.add(new Pellet(posx + ((Boundary.WIDTH / 2 - 4) as int)  ,posy + ((Boundary.HEIGHT / 2 - 4) as int),8));
            break;
          case 'p':
            powerups.add(new PowerUp(posx + ((Boundary.WIDTH / 2 - 4) as int)  ,posy + ((Boundary.HEIGHT / 2 - 4) as int),8));
            break;

          default:
        } 





      }
    }


  }

// this methode is used by the controller to recreate pellets and powerups
  void createPelletsandPowerUps() {
    int posx;
    int posy = 0;
    String item;
    List<String> row;
    for (int rowid = 0; rowid < map.length; rowid++) {
      row = map[rowid];
      if (rowid > 0) {
        posy += 20;
      }
      posx = 0;
      for (int itemid = 0; itemid < row.length; itemid++) {
        item = row[itemid];
        if (itemid > 0) {
          posx += 20;
        }
      
        

        switch (item) {
         
          case '*':
            pellets.add(new Pellet(posx + ((Boundary.WIDTH / 2 - 4) as int)  ,posy + ((Boundary.HEIGHT / 2 - 4) as int),8));
            break;
          case 'p':
            powerups.add(new PowerUp(posx + ((Boundary.WIDTH / 2 - 4) as int)  ,posy + ((Boundary.HEIGHT / 2 - 4) as int),8));
            break;

          default:
        } 

      }
    } 
  }
}