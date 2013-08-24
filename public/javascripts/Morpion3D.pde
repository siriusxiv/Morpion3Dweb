void drawCircle(int x, int y){
  ellipseMode(CORNER);
  ellipse(x+10,y+10,30,30);
}

void drawCross(int x, int y){
  line(x+10,y+10,x+40,y+40);
  line(x+10,y+40,x+40,y+10);
}

int finished(){
  for(int i = 0; i<27; i++){
    int check = checkAlign(i);
    if(check!=0){
        return check;
    }
  }
  return 0;
}

int checkAlign(int i){
  int l = left(i);
  int r = right(i);
  int f = front(i);
  int b = back(i);
  int t = top(i);
  int B = bottom(i);
  int lf = leftfront(i);
  int rf = rightfront(i);
  int lb = leftback(i);
  int rb = rightback(i);
  int tf = topfront(i);
  int tb = topback(i);
  int bf = bottomfront(i);
  int bb = bottomback(i);
  int ltf = left(top(front(i)));
  int ltb = left(top(back(i)));
  int lbf = left(bottom(front(i)));
  int lbb = left(bottom(back(i)));
  int rtf = right(top(front(i)));
  int rtb = right(top(back(i)));
  int rbf = right(bottom(front(i)));
  int rbb = right(bottom(back(i)));
  
  if(l!=-1 && r!=-1){
    int test = isAligned(i,l,r);
    if(test!=0){
      return test;
    }
  }
  if(f!=-1 && b!=-1){
    int test = isAligned(i,f,b);
    if(test!=0){
      return test;
    }
  }
  if(t!=-1 && B!=-1){
    int test = isAligned(i,t,B);
    if(test!=0){
      return test;
    }
  }
  if(lf!=-1 && rb!=-1){
    int test = isAligned(i,lf,rb);
    if(test!=0){
      return test;
    }
  }
  if(rf!=-1 && lb!=-1){
    int test = isAligned(i,rf,lb);
    if(test!=0){
      return test;
    }
  }
  if(tf!=-1 && bb!=-1){
    int test = isAligned(i,tf,bb);
    if(test!=0){
      return test;
    }
  }
  if(tb!=-1 && bf!=-1){
    int test = isAligned(i,tb,bf);
    if(test!=0){
      return test;
    }
  }
  if(ltf!=-1 && rbb!=-1){
    int test = isAligned(i,ltf,rbb);
    if(test!=0){
      return test;
    }
  }
  if(ltb!=-1 && rbf!=-1){
    int test = isAligned(i,ltb,rbf);
    if(test!=0){
      return test;
    }
  }
  if(lbf!=-1 && rtb!=-1){
    int test = isAligned(i,lbf,rtb);
    if(test!=0){
      return test;
    }
  }
  if(lbb!=-1 && rtf!=-1){
    int test = isAligned(i,lbb,rtf);
    if(test!=0){
      return test;
    }
  }
  return 0;
}

int sum(int i, int a, int b){
  return squares.get(i).val+squares.get(a).val+squares.get(b).val;
}

int isAligned(int i, int a, int b){
  switch(sum(i,a,b)){
   case 3:
    changeColor(i,a,b);
    return 1;
   case -3:
    changeColor(i,a,b);
    return 2;
   default:
    return 0;
  }
}

void changeColor(int i,int a,int b){
  squares.get(i).c=color(0,255,0);
  squares.get(a).c=color(0,255,0);
  squares.get(b).c=color(0,255,0);
}

int left(int a){
  if(a==-1){
    return -1;
  }
  if(a%3!=0){
    return a-1;
  }else{
    return -1;
  }
}

int right(int a){
  if(a==-1){
    return -1;
  }
  if(a%3!=2){
    return a+1;
  }else{
    return -1;
  }
}

int front(int a){
  if(a==-1){
    return -1;
  }
  if(a%9>=3){
    return a-3;
  }else{
    return -1;
  }
}

int back(int a){
  if(a==-1){
    return -1;
  }
  if(a%9<6){
    return a+3;
  }else{
    return -1;
  }
}

int top(int a){
  if(a==-1){
    return -1;
  }
  if(a>=9){
    return a-9;
  }else{
    return -1;
  }
}

int bottom(int a){
  if(a==-1){
    return -1;
  }
  if(a<18){
    return a+9;
  }else{
    return -1;
  }
}

int leftfront(int a){
  return left(front(a));
}

int rightfront(int a){
  return right(front(a));
}

int leftback(int a){
  return left(back(a));
}

int rightback(int a){
  return right(back(a));
}

int topfront(int a){
  return top(front(a));
}

int topback(int a){
  return top(back(a));
}

int bottomfront(int a){
  return bottom(front(a));
}

int bottomback(int a){
  return bottom(back(a));
}

void setup(){
  size(151,504);
  setVariables();
}

void draw(){
  background(255);
  for(Square s : squares){
    s.draw();
    int fin;
    if((fin=finished())==0){
      s.isSelected();
    }else{
      fill(0,0,255);
      textAlign(CENTER,CENTER);
      text("Player "+fin+" wins!",width/2,height/2);
    }
  }
  mousePrevioulyPressed=mousePressed;
}

boolean mousePrevioulyPressed=false;
boolean click() {
  return (mousePressed && !mousePrevioulyPressed);
}

class Square {
  int x;
  int y;
  int l=50;
  int h=50;

  int i;

  int val=0;
  
  color c = color(255,0,0);

  Square(int x_, int y_, int i_) {
    x=x_;
    y=y_;
    i=i_;
  }

  void draw() {
    fill(c);
    stroke(0);
    rect(x, y, l, h);
    if (val==1) {
      drawCross(x, y);
    } else if (val==-1) {
      drawCircle(x, y);
    }
  }

  boolean hover() {
    return mouseX>x && mouseX<x+l && mouseY>y && mouseY<y+h;
  }

  void isSelected() {
    if (val==0) {
      if (hover() && click()) {
        if (currentPlayer==1) {
          val=1;
        }
        else {
          val=-1;
        }
        changePlayer();
      }
    }
  }
}

ArrayList<Square> squares;

int currentPlayer=1;

void setVariables(){
  squares = new ArrayList<Square>();
  int offset=0;
  for(int i = 0; i<27 ; i++){
    if(i==9){
      offset=10;
    }
    if(i==18){
      offset=20;
    }
    Square square = new Square(50*(i%3),50*(i/3)+offset,i);
    squares.add(square);
  }
}

void changePlayer(){
  if(currentPlayer==1){
    currentPlayer=2;
  }else{
    currentPlayer=1;
  }
}
