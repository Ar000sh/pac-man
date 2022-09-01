library pacmann;


// import 'dart:async';
import 'dart:async';
import 'dart:html';
import 'dart:math';
import 'package:collection/collection.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;


part 'controller/controller.dart';
part 'model/boundary.dart';
part 'model/player.dart';
part 'model/pellet.dart';
part 'model/ghost.dart';
part 'model/powerUp.dart';
part 'model/map.dart';


part 'model/circle.dart';
part 'model/blinky.dart';
part 'model/clyde.dart';
part 'model/inky.dart';
part 'model/pinky.dart';
part 'view/view.dart';





double hypot(int num1, int num2) {
    return sqrt(pow(num1,2) + pow(num2,2));
}


Function eq = const ListEquality().equals;
double findmin(List<double> values) {
  double minimum = double.maxFinite;
  for(double value in values) {
    minimum = min(value, minimum);
  }
  return minimum;
}
double findmax(List<double> values) {
  double maximum = -double.maxFinite;
  for(double value in values) {
    maximum = max(value, maximum);
  }
  return maximum;
}

bool circleRectangleCollision2(Ghost ghost,Boundary rectangle) {
    int padding = ((Boundary.WIDTH / 2) as int) - ghost.radius - 1 ;
    return (ghost.y - ghost.radius + ghost.vely <= rectangle.y + Boundary.HEIGHT  + padding &&
        ghost.x + ghost.radius + ghost.velx >= rectangle.x - padding &&
        ghost.y + ghost.radius + ghost.vely >= rectangle.y - padding&&
        ghost.x - ghost.radius + ghost.velx <= rectangle.x + Boundary.WIDTH  + padding);
}

bool circleRectangleCollision(Player pacmann,Boundary rectangle) {
    int padding = ((Boundary.WIDTH / 2) as int) - pacmann.radius - 1 ;
    return (pacmann.y - pacmann.radius + pacmann.vely <= rectangle.y + Boundary.HEIGHT  + padding &&
        pacmann.x + pacmann.radius + pacmann.velx >= rectangle.x - padding &&
        pacmann.y + pacmann.radius + pacmann.vely >= rectangle.y - padding&&
        pacmann.x - pacmann.radius + pacmann.velx <= rectangle.x + Boundary.WIDTH  + padding);
}

bool circleCircleCollision(Pellet circle1, Player circle2) {
    return (hypot(circle1.x - circle2.x,circle1.y - circle2.y) < (circle1.radius + circle2.radius ));

}

// bool circleCircleCollisiontest(Pellettest circle1, Playertest circle2) {
//     // print("colliding with pellet");
//     return (hypot(circle1.x - circle2.x,circle1.y - circle2.y) < circle1.radius + circle2.radius);

// }
// bool circleRectangleCollisiontest(Playertest pacmann,Boundarytest rectangle) {
//     // print(((pacmann.y + 9) - (pacmann.radius )+ pacmann.vely <= rectangle.y + Boundary.HEIGHT  &&
//     //     (pacmann.x + 9) + (pacmann.radius ) + pacmann.velx >= rectangle.x  &&
//     //     (pacmann.y + 9) + (pacmann.radius ) + pacmann.vely >= rectangle.y&&
//     //     (pacmann.x + 9) - (pacmann.radius ) + pacmann.velx <= rectangle.x + Boundary.WIDTH));
//     return ((pacmann.y + 8) - (pacmann.radius )+ pacmann.vely <= rectangle.y + Boundary.HEIGHT  &&
//         (pacmann.x + 8) + (pacmann.radius ) + pacmann.velx >= rectangle.x  &&
//         (pacmann.y + 8) + (pacmann.radius ) + pacmann.vely >= rectangle.y&&
//         (pacmann.x + 8) - (pacmann.radius ) + pacmann.velx <= rectangle.x + Boundary.WIDTH);
// }

// bool circleRectangleCollisiontest(Playertest pacmann,Boundarytest rectangle) {
    
//     int padding = ((Boundary.WIDTH / 2) as int) - pacmann.radius - 1 ;
//     return ((pacmann.y + 8) - pacmann.radius + pacmann.vely <= rectangle.y + Boundary.HEIGHT  + padding &&
//         (pacmann.x + 8) + pacmann.radius + pacmann.velx >= rectangle.x - padding &&
//         (pacmann.y + 8) + pacmann.radius + pacmann.vely >= rectangle.y - padding&&
//         (pacmann.x + 8) - pacmann.radius + pacmann.velx <= rectangle.x + Boundary.WIDTH  + padding);
// }
// bool circleRectangleCollision2test(Ghosttest ghost,Boundarytest rectangle) {
//     int padding = ((Boundary.WIDTH / 2) as int) - ghost.radius - 1 ;
//     return ((ghost.y + 8) - ghost.radius + ghost.vely <= rectangle.y + Boundary.HEIGHT  + padding &&
//         (ghost.x + 8) + ghost.radius + ghost.velx >= rectangle.x - padding &&
//         (ghost.y + 8) + ghost.radius + ghost.vely >= rectangle.y - padding&&
//         (ghost.x + 8) - ghost.radius + ghost.velx <= rectangle.x + Boundary.WIDTH  + padding);
// }



bool rectangleCircleCollision(int x1, int x2, int y1, int y2, int radius, int velx, int vely) {
    int padding = ((Boundary.WIDTH / 2) as int) - radius - 1 ;
    return ((y1 + 8) - radius + vely <= y2 + Boundary.HEIGHT  + padding &&
        (x1 + 8) + radius + velx >= x2 - padding &&
        (y1 + 8) + radius + vely >= y2 - padding&&
        (x1 + 8) - radius + velx <= x2 + Boundary.WIDTH  + padding);
}

bool rectangleCircleCollision2(int x1, int x2, int y1, int y2, int radius, int velx, int vely) {
    int padding = ((Boundary.WIDTH / 2) as int) - radius - 1 ;
    return ((x1 + 8) + radius + velx >= x2 - padding && (x1 + 8) - radius + velx <= x2 + Boundary.WIDTH  + padding);
}
