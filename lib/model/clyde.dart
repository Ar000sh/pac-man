part of pacmann;

class Clyde extends Ghost {
  double chasedistance;
  final  List<int> start = [( Boundary.WIDTH * 10 +  2) as int,(Boundary.HEIGHT * 10 +  2) as int,0,0];

  
  Clyde(int speed, Game game,double chasedistance) 
    : super( ( Boundary.WIDTH * 10 +  2) as int, (Boundary.HEIGHT * 10 +  2) as int, 0, 0, speed, game) {
      this.chasedistance = chasedistance;
    }
      
   

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