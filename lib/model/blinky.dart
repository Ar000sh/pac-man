part of pacmann;

class Blinky extends Ghost {
  final  List<int> start = [( Boundary.WIDTH * 9 +  2) as int,(Boundary.HEIGHT * 8 +  2) as int,0,0];
  double chasedistance;
 
  Blinky(int speed,  Player player,List<Boundary> boundaries,double chasedistance) : super( ( Boundary.WIDTH * 9 +  2) as int, (Boundary.HEIGHT * 8 +  2) as int, 0, 0,  speed,player,boundaries) {
    inGhosthous = false;
    this.chasedistance = chasedistance;
  }


  
  


  
  String chooseDirection(List<String> pathways) {
    Random random = new Random();
    String direction;
    List<double> distances = [];
    int tempx;
    int tempy;
    if (sqrt((pow(this.x - player.x,2) + pow(this.y - player.y,2))) < chasedistance && !this.scared) {
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
        distances.add(sqrt((pow(tempx - player.x,2) + pow(tempy - player.y,2))));
      });
          
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