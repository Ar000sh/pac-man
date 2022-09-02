part of pacmann;

class Player {

  int x;
  int y;
  int velx;
  int vely;
  int radius;
  int speed;
  Game game;
  // List<Boundary> boundaries;

  String lastkey = '';
  List<bool> keys = [false,false,false,false];
  String direction= '';

  int n = 0;
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



  void update() {
    this.x += this.velx;
    this.y += this.vely;

  }
  

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

 


  void movePlayer() {
    // for the movment to work we need to be able to predict whether will be a gab where we can go up
    // for that to work we need to loop throught the boundaries and maniplate the velocity of the player so
    // as if it has already taken anther step forward and then check if there is collison there if not than we have succesfuly predicted a path that we can use and we will set the vely to -%
    // otherwise we know that we wont be able to go up in the next move so to prevent the player from stoping because of the collison detection we just set the vely to 0
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
      //print("d key was pressed");
      // move to the right
      // playertemp = new Playertest(this.x + 2, this.y, this.velx, this.vely, this.radius, this.radians, this.openRate, this.rotation,this.boundaries);      
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