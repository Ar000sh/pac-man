part of pacmann;

class Inky extends Ghost {
  
  final List<int> start = [( Boundary.WIDTH * 8 +  2) as int,(Boundary.HEIGHT * 10 +  2) as int,0,0];
  Ghost blinky;
  int posx = 0;
  int posy = 0;

  
  Inky(int speed, Game game,Ghost blinky) 
    : super( ( Boundary.WIDTH * 8 +  2) as int, (Boundary.HEIGHT * 10 +  2) as int, 0, 0,  speed, game) {
      this.blinky = blinky;
    }

  // void drawBlueGhost() {
  //   super.drawBlueGhost();
  // }
  // void drawWhiteGhost() {
  //   super.drawWhiteGhost();
  // }
  // void drawEyes() {
  //   super.drawEyes();
     
  // }

  void findnextMove() {
    int playerx = 0;
    int playery = 0;
    int vecx = 0;
    int vecy = 0;
    if(this.velx > 0) {
      playerx = game.player.x + 10;
      playery = game.player.y;

    } else if (this.velx < 0) {
      playerx = game.player.x - 10;
      playery = game.player.y;

    } else if (this.vely > 0) {
      playerx = game.player.x ;
      playery = game.player.y + 10;

    } else if (this.vely < 0) {
      playerx = game.player.x;
      playery = game.player.y - 10;

    }

    vecx = (playerx - blinky.x) * 2;
    vecy = (playery - blinky.y) * 2;

    posx = blinky.x + vecx;
    posy = blinky.y + vecy;

  }



  // void update() {
  //   super.update();
  // }

  // List<String> findPathways() {
  //   return super.findPathways();
  // }

  

  String chooseDirection(List<String> pathways) {
    Random random = new Random();
    String direction;
    List<double> distances = [];
    int tempx;
    int tempy;

    findnextMove();


    if (!this.scared && posx != 0 && posy != 0) {

      pathways.forEach((path) {  
        switch (path) {
          case 'right':
            tempx = this.x + this.speed;
            tempy = this.y; 
            break;
          case 'left':
            tempx = this.x - this.speed;
            tempy = this.y; 
            break;
          case 'top':
            tempx = this.x;
            tempy = this.y - this.speed;
            break;
          case 'bottom':
            tempx = this.x;
            tempy = this.y + this.speed;
            break;
          default:
            tempx = this.x;
            tempy = this.y;
        }
        distances.add(sqrt((pow(tempx - posx,2) + pow(tempy - posy,2))));
       

      });
      posx = 0;
      posy = 0;
 
      direction = pathways[distances.indexOf(findmin(distances))];
    } else {

      direction = pathways[random.nextInt(pathways.length)];
    }
    return direction;
  }


  void moveGhost() {
      if (!inGhosthous && movenormally) {
      super.moveGhost();
    } else {
      this.direction = 'top';
      if (inGhosthous) {
        inGhosthous = false;
        Timer(Duration(seconds: 2), () {
          x = ( Boundary.WIDTH * 9 +  2) as int;
          y = (Boundary.HEIGHT * 8 +  2) as int;
          velx = speed;
          movenormally = true;      
        });
      } 
      
    }
  }
  

}