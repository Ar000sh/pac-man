part of pacmann;

class Clyde extends Ghost {
  // used in chooseDirection methode to see if the distance between the ghost and the player is small enough to start chasing the player 
  double chasedistance;
  // the varaible stores the start positions and velocities to be used when wanting to reset the player when needed
  final  List<int> start = [( Boundary.WIDTH * 10 +  2) as int,(Boundary.HEIGHT * 10 +  2) as int,0,0];

  
  Clyde(int speed, Game game,double chasedistance) 
    : super( ( Boundary.WIDTH * 10 +  2) as int, (Boundary.HEIGHT * 10 +  2) as int, 0, 0, speed, game) {
      this.chasedistance = chasedistance;
    }
      
   
// // choices a direction from the pathways passed into the methode by checking the distance 
// between player and ghost and if it is smaller than chasedistance the dircetion that brings the ghost
// the fastest to the player will be chooosen
  String chooseDirection(List<String> pathways) {
    Random random = new Random();
    String direction;
    List<double> distances = [];
    int tempx;
    int tempy;
    int posx = 0;
    int posy = 0;
    
    if (!this.scared) {
      if (sqrt((pow(this.x - game.player.x,2) + pow(this.y - game.player.y,2))) < chasedistance) {
        posx = game.player.x;
        posy = game.player.y;
      } else {
        posx = 22;
        posy = 402;
      }
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
          
      direction = pathways[distances.indexOf(findmin(distances))];
    } else {
      direction = pathways[random.nextInt(pathways.length)];
    }
    return direction;
  }
// uses the moveghost methode of class ghost but only if the ghost is outside the ghost house after 3 seconds have passed since the 
// ghost has been in the ghost house it will be brought back to the game 
  void moveGhost() {
    if (!inGhosthous && movenormally) {
      super.moveGhost();
    } else {
      this.direction = 'top';
      if (inGhosthous) {
        inGhosthous = false;
        Timer(Duration(seconds: 3), () {
      
          x = ( Boundary.WIDTH * 9 +  2) as int;
          y = (Boundary.HEIGHT * 8 +  2) as int;
          velx = -speed;
          movenormally = true;   
   
        });
      }
      
    }
  }
  

}