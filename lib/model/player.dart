part of pacmann;

class Player {
  // used for the x position
  int x;
  // used for the y position
  int y;
  // can have a postive or negative value and determines if the player moves to right or left
  int velx;
  // can have a postive or negative value and determines if the player moves to top or bottom
  int vely;
  // used for the radius 
  int radius;
  // used for the speed
  int speed;
  // refrence to the game instance
  Game game;
  
  // in these varabile the lasted pressed key is saved
  String lastkey = '';
  // is used for the keys w a s d the one thats pressed will be set to true 
  List<bool> keys = [false,false,false,false];
  // is used in the view to determine in which direction the player is moving to set the background accordingly
  String direction= '';
  // the varaible stores the start positions and velocities to be used when wanting to reset the player when needed
  List<int> start = [( Boundary.WIDTH * 9 +  2) as int,(Boundary.HEIGHT * 16 +  2) as int,-5,0];

  Player(Game game,int speed) {
    this.x = ( Boundary.WIDTH * 9 +  2) as int;
    this.y = (Boundary.HEIGHT * 16 +  2) as int;
    this.velx = -5;
    this.vely = 0;
    this.radius = 8;
    this.speed = speed;
    this.game = game;

  }


  // update the x and y positions by adding the velocties to them 
  void update() {
    this.x += this.velx;
    this.y += this.vely;

  }
  

  // triggering the listen for the keys w a s d and making sure the update the keys and lastkey varaiables to be used in the movePlayer methode 
  void handleKeyboard() {

    document.onKeyDown.listen((event) {
    
      switch (event.keyCode) {
        case 87: // key w
          keys[0] = true;
          lastkey = 'w';
          break;
        case 65: // key a
          keys[1] = true;
          lastkey = 'a';
          break;
        case 83: // key s
          keys[2] = true;
          lastkey = 's';
          break;
        case 68: // key d
          keys[3] = true;
          lastkey = 'd';
          break;
        default:
      }
    });

  
    document.onKeyUp.listen((event) {
    
      switch (event.keyCode) {
        case 87: // key w
          keys[0] = false;
          break;
        case 65: // key a
          keys[1] = false;
          break;
        case 83: // key s
          keys[2] = false;
          break;
        case 68: // key d
          keys[3] = false;
          break;
        default:
      }
    });

  }

 

  // this methode is used to move the player based on the keys and lastskey varaibles and wethere the player will collide with a boundary if
  // he took a specific direction if the player wont collide with boundary when going to that direction the the vely and velx will be set accordingly
  // so that the player can actually move in that direction otherwise the player will be stoped  by setting the velocities to 0 
  void movePlayer() {
    
    Boundary boundary;
    Player playertemp;

    if(this.keys[0] && this.lastkey == 'w') {
      //move up

      for(int i = 0; i < game.boundaries.length; i++) {
        boundary = game.boundaries[i];
        if(rectangleCircleCollision(this.x,boundary.x,this.y,boundary.y,this.radius,this.velx,-speed)) {
          this.vely = 0;

          break;
        } else {
          this.vely = -speed;
        }

      }

    } else if(this.keys[1] && this.lastkey == 'a') {

      
      for(int i = 0; i < game.boundaries.length; i++) {
        boundary = game.boundaries[i];
        if(rectangleCircleCollision(this.x,boundary.x,this.y,boundary.y,this.radius,-speed,this.vely)) {
          this.velx = 0;
          break;
        } else {
          this.velx = -speed;
         
        }

      }
    } else if(this.keys[2] && this.lastkey == 's') {
          
      
      for(int i = 0; i < game.boundaries.length; i++) {
        boundary = game.boundaries[i];
        if(rectangleCircleCollision(this.x,boundary.x,this.y,boundary.y,this.radius,this.velx,speed)) {
          this.vely = 0;
          break;
        } else {
          this.vely = speed;
        }
      }
    } else if(this.keys[3] && this.lastkey == 'd') {
     
      for(int i = 0; i < game.boundaries.length; i++) {
        boundary = game.boundaries[i];
        if(rectangleCircleCollision(this.x ,boundary.x,this.y,boundary.y,this.radius,speed,this.vely)) {
          this.velx = 0;
          break;
        } else {
          this.velx = speed;
        }

      }
    }
    if(this.velx > 0) {

      direction = 'right';
    } else if (this.velx < 0) {

      direction = 'left';
    } else if (this.vely > 0) {

      direction = 'bottom';
    } else if (this.vely < 0) {

      direction = 'top';
    } 
    
  }
  
}