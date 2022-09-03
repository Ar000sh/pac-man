part of pacmann;

class Pinky extends Ghost {
  // the varaible stores the start positions and velocities to be used when wanting to reset the player when needed
  final  List<int> start = [( Boundary.WIDTH * 9 +  2) as int,(Boundary.HEIGHT * 10 +  2) as int,0,0];
  // target x position 
  int posx = 0;
  // target y position
  int posy = 0;

  Pinky( int speed,  Game game) 
    : super( ( Boundary.WIDTH * 9 +  2) as int, (Boundary.HEIGHT * 10 +  2) as int, 0, 0,  speed, game);
  
 // this methode is used to find the target x and y positions for the ghost by using the player's x , y Position and velx and vely more about it in the dokumentation
  void findp() {
    List<String> l = [];

      // x:22 // y:22 x: 342 y: 402
    int tempx = 0;
    int tempy = 0;
    for (int i = 0; i < game.boundaries.length; i++ ) {
      Boundary boundary = game.boundaries[i];
      if(game.player.velx > 0) {
        tempx  = game.player.x + 5 * 4;
        tempy = game.player.y - 5 * 4;

        if (!rectangleCircleCollision(tempx,boundary.x,tempy,boundary.y,this.radius,this.velx,this.vely) && tempx >= 22 && tempx <= 342 && tempy >= 22 && tempy <= 402 && !l.contains('right') ) {
          l.add('right');
          posx = tempx;
          posy = tempy;
        }
        tempx  = game.player.x + 5 * 4;
        tempy = game.player.y + 5 * 4;
        if (!rectangleCircleCollision(tempx,boundary.x,tempy,boundary.y,this.radius,this.velx,this.vely) && tempx >= 22 && tempx <= 342 && tempy >= 22 && tempy <= 402  && !l.contains('right') ) {
          l.add('right');
          posx = tempx;
          posy = tempy;
        }
        tempx  = game.player.x + 5 * 4;
        tempy = game.player.y;

        if (!rectangleCircleCollision(tempx,boundary.x,tempy,boundary.y,this.radius,this.velx,this.vely) && tempx >= 22 && tempx <= 342 && tempy >= 22 && tempy <= 402  && !l.contains('right')) {
          l.add('right');
          posx = tempx;
          posy = tempy;
        }

      } else if (game.player.velx < 0) {
        tempx = game.player.x - 5 * 4;
        tempy = game.player.y + 5 * 4;


        if (!rectangleCircleCollision(tempx,boundary.x,tempy,boundary.y,this.radius,this.velx,this.vely) && tempx >= 22 && tempx <= 342 && tempy >= 22 && tempy <= 402  && !l.contains('left') ) {
          l.add('left');
          posx = tempx;
          posy = tempy;
        }
        tempx = game.player.x - 5 * 4;
        tempy = game.player.y - 5 * 4;
        if (!rectangleCircleCollision(tempx,boundary.x,tempy,boundary.y,this.radius,this.velx,this.vely) && tempx >= 22 && tempx <= 342 && tempy >= 22 && tempy <= 402  && !l.contains('left') ) {
          l.add('left');
          posx = tempx;
          posy = tempy;
        }

        tempx = game.player.x - 5 * 4;
        tempy = game.player.y;
        if (!rectangleCircleCollision(tempx,boundary.x,tempy,boundary.y,this.radius,this.velx,this.vely) && tempx >= 22 && tempx <= 342 && tempy >= 22 && tempy <= 402  && !l.contains('left') ) {
          l.add('left');
          posx = tempx;
          posy = tempy;
        }
      } else if (game.player.vely > 0) {
        tempx = game.player.x - 5 * 4;
        tempy = game.player.y + 5 * 4;

        if (!rectangleCircleCollision(tempx,boundary.x,tempy,boundary.y,this.radius,this.velx,this.vely) && tempx >= 22 && tempx <= 342 && tempy >= 22 && tempy <= 402  && !l.contains('bottom') ) {
          l.add('bottom');
          posx = tempx;
          posy = tempy;
        }
        tempx = game.player.x + 5 * 4;
        tempy = game.player.y + 5 * 4;
        if (!rectangleCircleCollision(tempx,boundary.x,tempy,boundary.y,this.radius,this.velx,this.vely) && tempx >= 22 && tempx <= 342 && tempy >= 22 && tempy <= 402  && !l.contains('bottom') ) {
          l.add('bottom');
          posx = tempx;
          posy = tempy;
        }
        tempx = game.player.x ;
        tempy = game.player.y + 5 * 4;

        if (!rectangleCircleCollision(tempx,boundary.x,tempy,boundary.y,this.radius,this.velx,this.vely) && tempx >= 22 && tempx <= 342 && tempy >= 22 && tempy <= 402  && !l.contains('bottom') ) {
          l.add('bottom');
          posx = tempx;
          posy = tempy;
        }
      } else if (game.player.vely < 0) {
        tempx = game.player.x + 5 * 4;
        tempy = game.player.y - 5 * 4;

        if (!rectangleCircleCollision(tempx,boundary.x,tempy,boundary.y,this.radius,this.velx,this.vely) && tempx >= 22 && tempx <= 342 && tempy >= 22 && tempy <= 402  && !l.contains('top') ) {
          l.add('top');
          posx = tempx;
          posy = tempy;
        }
        tempx = game.player.x - 5 * 4;
        tempy = game.player.y - 5 * 4;
        if (!rectangleCircleCollision(tempx,boundary.x,tempy,boundary.y,this.radius,this.velx,this.vely) && tempx >= 22 && tempx <= 342 && tempy >= 22 && tempy <= 402  && !l.contains('top') ) {
          l.add('top');
          posx = tempx;
          posy = tempy;
        }
        tempx = game.player.x;
        tempy = game.player.y - 5 * 4;
        if (!rectangleCircleCollision(tempx,boundary.x,tempy,boundary.y,this.radius,this.velx,this.vely) && tempx >= 22 && tempx <= 342 && tempy >= 22 && tempy <= 402  && !l.contains('top') ) {
          l.add('top');
          posx = tempx;
          posy = tempy;
        }
      }
    }
  
  }
  // // choices a direction from the pathways passed into the methode by checking the distance 
// between player and the calculated x and y positions than chooses the dircetion that brings the ghost
// the fastest to the target will be chooosen
  String chooseDirection(List<String> pathways) {
    Random random = new Random();
    String direction;
    List<double> distances = [];
    int playerx = 0;
    int playery = 0;
    int tempx;
    int tempy;

    findp();

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

// uses the moveghost methode of class ghost but only if the ghost is outside the ghost house after 500 miliseconds have passed since the 
// ghost has been in the ghost house it will be brought back to the game
  void moveGhost() {
    if (!inGhosthous && movenormally) {
      super.moveGhost();
    } else {
      this.direction = 'top';
      if (inGhosthous) {
        inGhosthous = false;
        Timer(Duration(milliseconds: 500), () {
          y = (Boundary.HEIGHT * 8 +  2) as int;
          velx = -speed;
          movenormally = true;       
        });

      }
      
      
      
    }
    
  }


}