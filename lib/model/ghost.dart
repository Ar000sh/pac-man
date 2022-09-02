part of pacmann;
//https://gameinternals.com/understanding-pac-man-ghost-behavior#:~:text=Ghost%20Movement%20Modes%20The%20ghosts%20are%20always%20in,that%20they%20spend%20most%20of%20their%20time%20in.
//https://dev.to/code2bits/pac-man-patterns--ghost-movement-strategy-pattern-1k1a#:~:text=Ghost%20%E2%80%94%20The%20Ghost%20class%20contains%20the%20different,during%20the%20chase%20mode%20of%20the%20Pac-Man%20game.
class Ghost {

  int x;
  int y;
  int velx;
  int vely;
  int radius;
  List<String> prevCollisions;
  int speed;
  bool scared;
  bool scared2;
  String direction;
  Game game;

  // Player player;
  // List<Boundary> boundaries;
  // List<int> startpos = [];
  
  // int change = 0;
  int backgroundimg = 0;
  bool inGhosthous = true;
  bool movenormally = false;


  final List<int> start = [];


  Ghost( int x, int y, int velx, int vely, int speed, Game game) {

    this.x = x;
    this.y = y;
    this.velx = velx;
    this.vely = vely;
    this.radius = 8;
    prevCollisions = [];
    this.speed = speed;
    this.scared = false;
    this.direction = '';
    this.game = game;
    this.scared2 = false;

  }

  // void draw() {
  //   // c.beginPath();
  //   // c.arc(this.x,this.y,this.radius,0,pi*2);
  //   // c.fillStyle = this.scared ? 'blue' : this.color;
  //   // c.fill();
  //   // c.closePath();
  // }

  void update() {
 
    // this.draw();
    this.x += this.velx;
    this.y += this.vely; 

    // ghostbody.style.left = '${x -4}px';
    // ghostbody.style.top = '${y - 4}px';
        
    // ghosteyes.style.left = '${x - 4 }px';
    // ghosteyes.style.top = '${y - 4}px';

  }

  List<String> findPathways() {
    List<String> collisions = [];
    List<String> pathways = [];
                                

   


    for (var boundary in game.boundaries) {
      
      if (rectangleCircleCollision(this.x,boundary.x,this.y,boundary.y,this.radius,this.speed,0) && !collisions.contains('right')) {
        collisions.add('right');
      }
      if (rectangleCircleCollision(this.x,boundary.x,this.y,boundary.y,this.radius,-this.speed,0) && !collisions.contains('left')) {
        collisions.add('left');
      }
      if (rectangleCircleCollision(this.x,boundary.x,this.y,boundary.y,this.radius,0,-this.speed) && !collisions.contains('top')) {
        collisions.add('top');
      }
      if (rectangleCircleCollision(this.x,boundary.x,this.y,boundary.y,this.radius,0,this.speed) && !collisions.contains('bottom')) {
        collisions.add('bottom');
      }
    }


    if(collisions.length > this.prevCollisions.length) {
        this.prevCollisions = collisions;
    }

    if(!eq(collisions,this.prevCollisions)) {

      if (this.velx > 0) {
        this.prevCollisions.add('right');
      } else if (this.velx < 0) {
        this.prevCollisions.add('left');
      }else if (this.vely < 0) {
        this.prevCollisions.add('top');
      }else if (this.vely > 0) {
        this.prevCollisions.add('bottom');
      }

      pathways = [];
      this.prevCollisions.forEach((collison) {
        if (!collisions.contains(collison)) {
          pathways.add(collison);
        }
      });

        
      return pathways;
    }
    return pathways;
  }

  String chooseDirection(List<String> pathways) {
    return '';
  }

  void moveGhost() {
    List<String> pathways = findPathways();
    if (pathways.length > 0) {
      
      direction = chooseDirection(pathways);
       
      switch (direction) {
        case 'bottom':
          this.vely = this.speed;
          this.velx = 0;
          this.direction = 'bottom';
          break;
        case 'top':
          this.vely = -this.speed;
          this.velx = 0;
          this.direction = 'top';
          break;
        case 'right':
          this.vely = 0;
          this.velx = this.speed;
          this.direction = 'right';
          break;
        case 'left':
          this.vely = 0;
          this.velx = -this.speed;
          this.direction = 'left';
          break;
        default:
      }
      this.prevCollisions = [];
    }
    
    
  }
  // void drawBlueGhost() {
  //   // if (scared && !scared2) {
      
      
    
  //   //   if(n == 1) {
  //   //     ghostbody.style.background = 'url(img/ghosts/scared/scared_1.png)';
  //   //     this.n = 2;
  //   //   } else {
  //   //     ghostbody.style.background = 'url(img/ghosts/scared/scared_2.png)';
  //   //     this.n = 1;
  //   //   }
    
        
  //   // }

  // }


  // void drawWhiteGhost() {
  //   // if (scared && scared2) {
  //   //   if(n == 1) {
  //   //     ghostbody.style.background = 'url(img/ghosts/scared/scared_3.png)';
  //   //     this.n = 2;
  //   //   } else {
  //   //     ghostbody.style.background = 'url(img/ghosts/scared/scared_4.png)';
  //   //     this.n = 1;
  //   //   }
    
       
  //   //   }
    

  // }

  // void drawEyes() {
  //   // if (!this.scared) {
  //   //    switch (this.direction) {
  //   //     case 'right':
  //   //       ghosteyes.style.background = 'url(img/ghosts/eyes_r.png)';
  //   //       break;
  //   //     case 'left':
  //   //       ghosteyes.style.background = 'url(img/ghosts/eyes_l.png)';
  //   //       break;
  //   //     case 'top':
  //   //       ghosteyes.style.background = 'url(img/ghosts/eyes_u.png)';
  //   //       break;
  //   //     case 'bottom':
  //   //       ghosteyes.style.background = 'url(img/ghosts/eyes_d.png)';
  //   //       break;
  //   //     default:
        
  //   //   }
  //   // }
     
  // }

  void changeModes() {
    this.scared = true;
    Timer(Duration(seconds: 3), () {
      this.scared2 = true;
      // print("scared: ${this.scared}");
      // print("scared2: ${this.scared2}");
      Timer(Duration(milliseconds: 500), () {
        this.scared2 = false;
        Timer(Duration(milliseconds: 500), () {
          this.scared2 = true;
          Timer(Duration(milliseconds: 500), () {
            this.scared2 = false;
            Timer(Duration(milliseconds: 500), () {
              this.scared2 = true;
              Timer(Duration(milliseconds: 500), () {
                this.scared2 = false;
                this.scared = false;
            
              });
            });
          });
        });
      });    
    });
  }
 

}