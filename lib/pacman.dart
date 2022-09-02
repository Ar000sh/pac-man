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
part 'model/game.dart';
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


bool circleCircleCollision(Pellet circle1, Player circle2) {
    return (hypot(circle1.x - circle2.x,circle1.y - circle2.y) < (circle1.radius + circle2.radius ));

}





bool rectangleCircleCollision(int x1, int x2, int y1, int y2, int radius, int velx, int vely) {
    int padding = ((Boundary.WIDTH / 2) as int) - radius - 1 ;
    return ((y1 + 8) - radius + vely <= y2 + Boundary.HEIGHT  + padding &&
        (x1 + 8) + radius + velx >= x2 - padding &&
        (y1 + 8) + radius + vely >= y2 - padding&&
        (x1 + 8) - radius + velx <= x2 + Boundary.WIDTH  + padding);
}

