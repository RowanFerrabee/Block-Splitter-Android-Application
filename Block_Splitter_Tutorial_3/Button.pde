class Button {
  int x, y;
  int w, h;
  int var;
  boolean lit = false;
  boolean textButton;
  String text;
  Button(int a, int b, int c, int d, int v) {
    x=a;
    y=b;
    w=c;
    h=d;
    var=v;
    textButton=false;
  }
  boolean isPressed() {
    if (lit&&mousePressed&&mouseX>x&&mouseX<x+w&&mouseY>y&&mouseY<y+h) {
      return true;
    } else return false;
  }
  void light(){
    lit = true;
  }
  void display() {
    pushStyle();
      strokeWeight(2);
      
      rect(x, y, w, h);
      fill(0,0,0);
      if(lit){
      fill(229, 235, 65);}
      textSize(21);
      fill(0,0,0);
      if(textButton)
        text(text,x+w/2,y+h/2);
    popStyle();
  }
  void move(int a, int b){
    x+=a;
    y+=b;
  }
  void setPos(int a, int b){
    x=a;
    y=b;
  }
  void setText(String s){
      text = s;
      textButton=true;
  }
};

