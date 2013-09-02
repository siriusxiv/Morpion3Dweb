int width = 200;
int height = 200;
//the greater the slower
int speed = 1;
//in percents
boolean rand = true;
boolean cross = false;
boolean infiniteLineGenerator = false;
boolean gliderGun = true;
int aliveProbability=40;

int length = width*height;
boolean start = false;

void setup(){
   size(width,height);
   noSmooth();
   initpixels_();
   textAlign(RIGHT);
}

boolean keyJustPressed=false;

void draw(){
  if(keyPressed && !keyJustPressed){ start=!start; keyJustPressed=true;}
  if(!keyPressed)  keyJustPressed=false;
  if(mousePressed) giveLife();
  background(255);
  noFill();
  stroke(0);
  rect(0,0,width-1,height-1);
  for(int i = 0; i<length; i++){
    pixels_[i].draw();
  }
  if(start && frame%speed==0) update();
  if(start)  frame++;
  fill(100);
  text((int)(frame/speed),width-3,12);
}

int frame=0;
Pixel[] pixels_ = new Pixel[length];
Pixel[] newpixels_ = new Pixel[length];

void initpixels_(){
  for(int i = 0; i<width;i++){
    for(int j = 0; j<height;j++){
      pixels_[i+width*j]=new Pixel(i,j);
      newpixels_[i+width*j]=new Pixel(i,j,0);
    }
  }
}

void giveLife(){
  pixels_[mouseX+width*mouseY].alive=1;
}

class Pixel{
  int x;
  int y;
  
  int alive;
  
  Pixel(int x_, int y_){
    x=x_;
    y=y_;
    if(extremity())   alive=0;
    else              alive=destiny();
  }
  Pixel(int x_, int y_, int dead){
    x=x_;
    y=y_;
    alive=0;
  }

int destiny(){
  if(gliderGun){
    if(x==1 && y==6)  return 1;
    else if(x==2 && y==6)  return 1;
    else if(x==2 && y==7)  return 1;
    else if(x==1 && y==7)  return 1;
    else if(x==11 && y==6)  return 1;
    else if(x==11 && y==7)  return 1;
    else if(x==11 && y==8)  return 1;
    else if(x==12 && y==5)  return 1;
    else if(x==12 && y==9)  return 1;
    else if(x==13 && y==4)  return 1;
    else if(x==13 && y==10)  return 1;
    else if(x==14 && y==4)  return 1;
    else if(x==14 && y==10)  return 1;
    else if(x==15 && y==7)  return 1;
    else if(x==16 && y==5)  return 1;
    else if(x==16 && y==9)  return 1;
    else if(x==17 && y==6)  return 1;
    else if(x==17 && y==7)  return 1;
    else if(x==17 && y==8)  return 1;
    else if(x==18 && y==7)  return 1;
    else if(x==21 && y==6)  return 1;
    else if(x==21 && y==5)  return 1;
    else if(x==21 && y==4)  return 1;
    else if(x==22 && y==6)  return 1;
    else if(x==22 && y==5)  return 1;
    else if(x==22 && y==4)  return 1;
    else if(x==23 && y==3)  return 1;
    else if(x==23 && y==7)  return 1;
    else if(x==25 && y==7)  return 1;
    else if(x==25 && y==8)  return 1;
    else if(x==25 && y==3)  return 1;
    else if(x==25 && y==2)  return 1;
    else if(x==35 && y==5)  return 1;
    else if(x==35 && y==4)  return 1;
    else if(x==36 && y==5)  return 1;
    else if(x==36 && y==4)  return 1;
    else  return 0;
  } 
  if(infiniteLineGenerator){
    if(x==120 && y==height/2)  return 1;
    else if(x==121 && y==height/2) return 1;
    else if(x==122 && y==height/2) return 1;
    else if(x==123 && y==height/2) return 1;
    else if(x==124 && y==height/2) return 1;
    else if(x==125 && y==height/2) return 1;
    else if(x==126 && y==height/2) return 1;
    else if(x==127 && y==height/2) return 1;
    else if(x==129 && y==height/2) return 1;
    else if(x==130 && y==height/2) return 1;
    else if(x==131 && y==height/2) return 1;
    else if(x==132 && y==height/2) return 1;
    else if(x==133 && y==height/2) return 1;
    else if(x==137 && y==height/2) return 1;
    else if(x==138 && y==height/2) return 1;
    else if(x==139 && y==height/2) return 1;
    else if(x==146 && y==height/2) return 1;
    else if(x==147 && y==height/2) return 1;
    else if(x==148 && y==height/2) return 1;
    else if(x==149 && y==height/2) return 1;
    else if(x==150 && y==height/2) return 1;
    else if(x==151 && y==height/2) return 1;
    else if(x==152 && y==height/2) return 1;
    else if(x==154 && y==height/2) return 1;
    else if(x==155 && y==height/2) return 1;
    else if(x==156 && y==height/2) return 1;
    else if(x==157 && y==height/2) return 1;
    else if(x==158 && y==height/2) return 1;
    else  return 0;
  }
  if(cross){
    if(x==y || x==height-y-1)  return 1;
    else      return 0;
  }
  if(rand){
    int n = int(random(100));
    if(n>aliveProbability)  return 1;
    else                    return 0;
  }else{
    if(x==width/4 || y==height/4 || x==width*3/4 || y==height*3/4)	return 1;
    else							return 0;
  }
}
  void draw(){
    if(alive>0){
      stroke(255,0,0);
      point(x,y);
    }
    if(frame%speed==0){
      nextFrame();
    }
  }
  
  boolean extremity(){
    return x==0 || y==0 || x==width-1 || y==height-1;
  }
  
  void nextFrame(){
    if(!extremity()){
      switch(sum()){
        case 2:
          newpixels_[x+width*y].alive=alive;
          break;
        case 3:
          newpixels_[x+width*y].alive=1;
          break;
        default:
          newpixels_[x+width*y].alive=0;
      }
    }
  }
  
  int up(){
    if(y==0)  return 0;
    else      return pixels_[x+width*(y-1)].alive;
  }
  int down(){
    if(y==height-1)  return 0;
    else          return pixels_[x+width*(y+1)].alive;
  }
  int left(){
    if(x==0)  return 0;
    else      return pixels_[x-1+width*y].alive;
  }
  int right(){
    if(x==width-1)  return 0;
    else          return pixels_[x+1+width*y].alive;
  }
  int ur(){
    if(y==0 || x==width-1)  return 0;
    else          return pixels_[x+1+width*(y-1)].alive;
  }
  int ul(){
    if(y==0 || x==0)  return 0;
    else          return pixels_[x-1+width*(y-1)].alive;
  }
  int dl(){
    if(y==height-1 || x==0)  return 0;
    else          return pixels_[x-1+width*(y+1)].alive;
  }
  int dr(){
    if(y==height-1 || x==width-1)  return 0;
    else          return pixels_[x+1+width*(y+1)].alive;
  }
  int sum(){
    return up()+down()+left()+right()+ur()+ul()+dr()+dl();
  }
  
}

void update(){
  for(int i = 0; i<width;i++){
    for(int j = 0; j<height;j++){
      pixels_[i+width*j].alive=newpixels_[i+width*j].alive;
    }
  }
}