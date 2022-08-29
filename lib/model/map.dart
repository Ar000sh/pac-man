part of pacmann;

class Map {
  static List<int> CLYDEPOS = [22,402];
 
  
  final List<List<String>> map = [
  ['<','-','-','-','-','-','-','-','-','5','-','-','-','-','-','-','-','-','>'],
  ['|','*','*','p','*','*','*','*','*','|','*','*','*','*','*','*','*','*','|'],
  ['|','*','<','>','*','<','-','>','*','|','*','<','-','>','*','<','>','*','|'],
  ['|','*','0','/','*','0','-','/','*','u','*','0','-','/','*','0','/','*','|'],
  ['|','*','*','*','*','*','*','*','*','*','*','*','*','*','*','*','*','*','|'],
  ['|','*','[',']','*','N','*','[','-','5','-',']','*','N','*','[',']','*','|'],
  ['|','*','*','*','*','|','*','*','*','|','*','*','*','|','*','*','*','p','|'],
  ['0','-','-','>','*','1','-',']',' ','u',' ','[','-','2','*','<','-','-','/'],
  [' ',' ',' ','|','*','|',' ',' ',' ',' ',' ',' ',' ','|','*','|',' ',' ',' '],
  ['-','-','-','/','*','u',' ','<','-','-','-','>',' ','u','*','0','-','-','-'],
  ['g',' ',' ','b','*',' ',' ','|',' ',' ',' ','|',' ',' ','*','b',' ',' ','g'],
  ['-','-','-','>','*','N',' ','0','-','-','-','/',' ','N','*','<','-','-','-'],
  [' ',' ',' ','|','*','|',' ',' ',' ',' ',' ',' ',' ','|','*','|',' ',' ',' '],
  ['<','-','-','/','*','u',' ','[','-','5','-',']',' ','u','*','0','-','-','>'],
  ['|','*','*','*','*','*','*','*','*','|','*','*','*','*','*','*','*','*','|'],
  ['|','*','[','>','*','[','-',']','*','u','*','[','-',']','*','<',']','*','|'],
  ['|','*','*','|','*','*','*','*','*','*','*','*','*','*','*','|','*','*','|'],
  ['1',']','*','u','*','N','*','[','-','5','-',']','*','N','*','u','*','[','2'],
  ['|','*','*','*','p','|','*','*','*','|','*','*','p','|','*','*','*','*','|'],
  ['|','*','[','-','-','w','-',']','*','u','*','[','-','w','-','-',']','*','|'],
  ['|','*','*','*','*','*','*','*','*','*','*','*','*','*','*','*','*','p','|'],
  ['0','-','-','-','-','-','-','-','-','-','-','-','-','-','-','-','-','-','/']
  ];
 
  List<Boundary> boundaries = [];
  List<Pellet> pellets = [];
  List<PowerUp> powerups = [];
  // double chasedistance = Boundary.WIDTH * 7;

  Map();
    
    


  void createMap() {
    
    
    int posx;
    int posy = 0;
    String item;
    List<String> row;
    for (int rowid = 0; rowid < map.length; rowid++) {
      row = map[rowid];
      if (rowid > 0) {
        posy += 20;
      }
      posx = 0;
      for (int itemid = 0; itemid < row.length; itemid++) {
        item = row[itemid];
        if (itemid > 0) {
          posx += 20;
        }
      
        if (item == '-') {
          //boundaries.add(new Boundary(c, posx, posy, 40, 40));
        }

        switch (item) {
          case '-':
            boundaries.add(new Boundary( posx, posy,'wall_h'));
            break;
          case '|':
            boundaries.add(new Boundary( posx, posy,'wall_v'));
            break;
          case ']':
            boundaries.add(new Boundary( posx, posy,'wall_r'));
            break;
          case '[':
            boundaries.add(new Boundary( posx, posy,'wall_l'));
            break;
          case 'u':
            boundaries.add(new Boundary( posx, posy,'wall_b'));
            break;
          case 'N':
            boundaries.add(new Boundary( posx, posy,'wall_t_20'));
            break;
          case 'w':
            boundaries.add(new Boundary( posx, posy,'wall_mb'));
            break;
          case '<':
            boundaries.add(new Boundary( posx, posy,'wall_tlc'));
            break;
          case '>':
            boundaries.add(new Boundary( posx, posy,'wall_trc'));
        
            break;
          case "0":
            boundaries.add(new Boundary( posx, posy,'wall_blc'));
            break;
          case '/':
            boundaries.add(new Boundary( posx, posy,'wall_brc'));
            break;
          case 'b':
            boundaries.add(new Boundary( posx, posy,'block'));
            break;
          case '1':
            boundaries.add(new Boundary( posx, posy,'wall_ml'));
            break;
          case '2':
            boundaries.add(new Boundary( posx, posy,'wall_mr'));
            break;

    //bbt == block open from the stop
    //bbb == block open from the bottom

          case '5':
            boundaries.add(new Boundary( posx, posy,'wall_mt'));
            break;
        case '*':
        
  // we need the boundary width and heigth to add half of each for it be in the center when optimizing dont forget to just use the static Boundary.width
            pellets.add(new Pellet(posx + ((Boundary.WIDTH / 2 - 4) as int)  ,posy + ((Boundary.HEIGHT / 2 - 4) as int)));
            break;
          case 'p':
            powerups.add(new PowerUp(posx + ((Boundary.WIDTH / 2 - 4) as int)  ,posy + ((Boundary.HEIGHT / 2 - 4) as int)));
            break;

          default:
        } 





      }
    }


  }

  void createPelletsandPowerUps() {
    int posx;
    int posy = 0;
    String item;
    List<String> row;
    for (int rowid = 0; rowid < map.length; rowid++) {
      row = map[rowid];
      if (rowid > 0) {
        posy += 20;
      }
      posx = 0;
      for (int itemid = 0; itemid < row.length; itemid++) {
        item = row[itemid];
        if (itemid > 0) {
          posx += 20;
        }
      
        

        switch (item) {
         
          case '*':
  // we need the boundary width and heigth to add half of each for it be in the center when optimizing dont forget to just use the static Boundary.width
            pellets.add(new Pellet(posx + ((Boundary.WIDTH / 2 - 4) as int)  ,posy + ((Boundary.HEIGHT / 2 - 4) as int)));
            break;
          case 'p':
            powerups.add(new PowerUp(posx + ((Boundary.WIDTH / 2 - 4) as int)  ,posy + ((Boundary.HEIGHT / 2 - 4) as int)));
            break;

          default:
        } 

      }
    } 
  }

 

}