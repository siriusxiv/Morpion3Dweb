int width_ = 300;
int height = 300;
//the greater the slower
int speed = 4;
//in percents
boolean rand = false;
int aliveProbability=92;

int length = width_*height;
boolean start = false;

void setup(){
   size(width_,height);
   noSmooth();
   initpixels_();
}

void draw(){
  if(mousePressed) start=true;
  background(255);
  noFill();
  stroke(0);
  rect(0,0,width_-1,height-1);
  for(int i = 0; i<length; i++){
    pixels_[i].draw();
  }
  if(start && frame%speed==0){
    update();
  }
  frame++;
}

int frame=0;
Pixel[] pixels_ = new Pixel[length];
Pixel[] newpixels_ = new Pixel[length];

void initpixels_(){
  for(int i = 0; i<width_;i++){
    for(int j = 0; j<height;j++){
      pixels_[i+width_*j]=new Pixel(i,j);
      newpixels_[i+width_*j]=new Pixel(i,j,0);
    }
  }
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
  if(rand){
    int n = int(random(100));
    if(n>aliveProbability)  return 1;
    else                    return 0;
  }else{
    if(x==width_/4 || y==height/4 || x==width_*3/4 || y==height*3/4)	return 1;
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
    return x==0 || y==0 || x==width_-1 || y==height-1;
  }
  
  void nextFrame(){
    if(!extremity()){
      switch(sum()){
        case 2:
          newpixels_[x+width_*y].alive=alive;
          break;
        case 3:
          newpixels_[x+width_*y].alive=1;
          break;
        default:
          newpixels_[x+width_*y].alive=0;
      }
    }
  }
  
  int up(){
    if(y==0)  return 0;
    else      return pixels_[x+width_*(y-1)].alive;
  }
  int down(){
    if(y==height-1)  return 0;
    else          return pixels_[x+width_*(y+1)].alive;
  }
  int left(){
    if(x==0)  return 0;
    else      return pixels_[x-1+width_*y].alive;
  }
  int right(){
    if(x==width_-1)  return 0;
    else          return pixels_[x+1+width_*y].alive;
  }
  int ur(){
    if(y==0 || x==width_-1)  return 0;
    else          return pixels_[x+1+width_*(y-1)].alive;
  }
  int ul(){
    if(y==0 || x==0)  return 0;
    else          return pixels_[x-1+width_*(y-1)].alive;
  }
  int dl(){
    if(y==height-1 || x==0)  return 0;
    else          return pixels_[x-1+width_*(y+1)].alive;
  }
  int dr(){
    if(y==height-1 || x==width_-1)  return 0;
    else          return pixels_[x+1+width_*(y+1)].alive;
  }
  int sum(){
    return up()+down()+left()+right()+ur()+ul()+dr()+dl();
  }
  
}

void update(){
  for(int i = 0; i<width_;i++){
    for(int j = 0; j<height;j++){
      pixels_[i+width_*j].alive=newpixels_[i+width_*j].alive;
    }
  }
}
