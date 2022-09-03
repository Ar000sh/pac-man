part of pacmann;

class Boundary {
  // the width 
  static int WIDTH = 20;
  // the height 
  static int HEIGHT = 20;
  // is used for the x position
  int x;
  // is used for the y position
  int y;
  // this used in view to determine which background image the Boundary will have
  String img;

  
  

  Boundary(int x, int y,String img) {

    this.x = x;
    this.y = y;
    this.img = img;
  }




}