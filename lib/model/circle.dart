part of pacmann;

class Circle{
  
  int x;
  int y;
  int radius;
  DivElement elment;
  DivElement field = document.querySelector("#field") as DivElement;

  Circle(int x, int y, int radius) {
    this.x = x;
    this.y = y;
    this.radius = radius;
    elment = DivElement();
    elment.className = 'collectibles';
    field.append(elment);
   
  }

}