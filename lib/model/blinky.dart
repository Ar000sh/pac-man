part of pacmann;

class Blinky extends Ghost {
  // the varaible stores the start positions and velocities to be used when wanting to reset the player when needed
  final  List<int> start = [( Boundary.WIDTH * 9 +  2) as int,(Boundary.HEIGHT * 8 +  2) as int,0,0];
  // used in chooseDirection methode to see if the distance between the ghost and the player is small enough to start chasing the player 
  double chasedistance;
 
  Blinky(int speed, Game game, double chasedistance) : super( ( Boundary.WIDTH * 9 +  2) as int, (Boundary.HEIGHT * 8 +  2) as int, 0, 0,  speed,game) {
    inGhosthous = false;
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
    if (sqrt((pow(this.x - game.player.x,2) + pow(this.y - game.player.y,2))) < chasedistance && !this.scared) {
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
        distances.add(sqrt((pow(tempx - game.player.x,2) + pow(tempy - game.player.y,2))));
      });
          
      direction = pathways[distances.indexOf(findmin(distances))];
    } else {
      direction = pathways[random.nextInt(pathways.length)];
    }
    return direction;
  }
  
  // uses the moveghost methode of class ghost but only if the ghost is outside the ghost house 

  void moveGhost() {
    if (!inGhosthous && movenormally) {
      super.moveGhost();
    } else {
      inGhosthous = true;
      if (inGhosthous) {
        this.direction = 'left';

        inGhosthous = false;
        velx = -speed;
        movenormally = true;    
      }
      
      
      
    }
  }

  
}