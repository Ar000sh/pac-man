part of pacmann;
//https://gameinternals.com/understanding-pac-man-ghost-behavior#:~:text=Ghost%20Movement%20Modes%20The%20ghosts%20are%20always%20in,that%20they%20spend%20most%20of%20their%20time%20in.
//https://dev.to/code2bits/pac-man-patterns--ghost-movement-strategy-pattern-1k1a#:~:text=Ghost%20%E2%80%94%20The%20Ghost%20class%20contains%20the%20different,during%20the%20chase%20mode%20of%20the%20Pac-Man%20game.
class Ghost {
  // used for the x position
  int x;
  // used for the y position
  int y;
  // can have a postive or negative value and determines if the ghost moves to right or left
  int velx;
  // can have a postive or negative value and determines if the ghost moves to top or bottom
  int vely;
  // used for the radius
  int radius;
  // used to save the pervious collisions of a ghost 
  List<String> prevCollisions;
  // used for the speed
  int speed;
  // used to determine if the ghost is vulnerable and used in view to make the ghosts background blue   
  bool scared;
  // used in view to make the ghosts background white  
  bool scared2;
  // the direction the ghost is moving in to be used in the view to decide which background to be used for the ghosts's eyes
  String direction;
  // refrence to the game instance
  Game game;

  // used in the View to determine which background should be used for the ghost 
  int backgroundimg = 0;
  // used to make sure the ghost doesnt move when he is ghost house 
  bool inGhosthous = true;
  // make the ghost to move normally 
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


// update the x and y positions by adding the velocties to them 
  void update() {
    this.x += this.velx;
    this.y += this.vely; 
  }

  // finds potential pathways for the ghost to move in by moving the ghost in every direction and then checking if it will be collide 
  // with a Boundary   
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

// choices a direction from the pathways passed into the methode 
  String chooseDirection(List<String> pathways) {
    return '';
  }

// sets all the needed parameters to make the ghost move in the choosen direction
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