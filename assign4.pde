
PImage fighter, backgroundOne, backgroundTwo, hpImg, treasure, enemy;
PImage startOne, startTwo, endOne, endTwo; 
int treasureX, treasureY, x, fighterX, fighterY, gamestate, speed=0, enemyMode, restartY;
float hp;
final int GAME_START = 1, GAME_RUN = 2, GAME_END = 3;
final int FIRST = 4, SECOND = 5, THIRD = 6;
boolean upPressed = false, downPressed = false, leftPressed = false, rightPressed = false;
int [] enemyX = new int[5];
int [] enemyY = new int[5];


void setup () {
  size(640,480) ; 
  
  fighter = loadImage("img/fighter.png");  //fighter
  
  hpImg = loadImage("img/hp.png"); 
  hp=196*0.2;  //hp
  
  treasure = loadImage("img/treasure.png");  
  treasureX=floor(random(20,520));  
  treasureY=floor(random(50,430));  //treasure random
  
  enemy = loadImage("img/enemy.png");
  enemyX[0]=10;
  enemyY[0]=floor(random(50,400));  
  restartY=floor(random(50,400));  //enemy random
  
  backgroundOne=loadImage("img/bg1.png");
  backgroundTwo=loadImage("img/bg2.png");
  startOne = loadImage("img/start2.png");
  startTwo = loadImage("img/start1.png");
  endOne = loadImage("img/end2.png");
  endTwo = loadImage("img/end1.png");
  
  fighterX=570;
  fighterY=240;  //fighter position
  
  gamestate = GAME_START;
  enemyMode = 4;
  x=0;
}


void draw() {
  background(0);
  
  switch(gamestate){
    case GAME_START:
      image(startOne,0,0);
      if(mouseX>210 && mouseX<450 && mouseY>370 && mouseY<420){
      image(startTwo,0,0);
        if(mousePressed){
        gamestate=2;}
    }
      break;
      
    case GAME_RUN:
    
      //background moving
      image(backgroundTwo,x,0);
      image(backgroundOne,x-640,0);
      image(backgroundTwo,x-1280,0);
      x++;
      x=x%1280;  
            
      // fighter moving
      image(fighter, fighterX, fighterY); 
      if(upPressed){
      fighterY -= 8;
      }
      if(downPressed){
      fighterY += 8;
      }
      if(leftPressed){
      fighterX -= 8;
      }
      if(rightPressed){
      fighterX += 8;
      }
      
      // fighter boundary ditection
      if(fighterX>width-fighter.width){
      fighterX=width-fighter.width;
      }
      if(fighterX<0){
      fighterX=0;
      }
      if(fighterY>height-fighter.height){
      fighterY=height-fighter.height;
      }
      if(fighterY<0){
      fighterY=0;
      }
      
      
      //eating treasure
      image(treasure,treasureX,treasureY);
      if(fighterY+fighter.height*4/5>treasureY && fighterY+fighter.height/5<treasureY+treasure.height && fighterX<treasureX+treasure.width && fighterX+fighter.width>treasureX){
      treasureX=floor(random(20,520));  
      treasureY=floor(random(50,430));
      hp += 196*0.1;
      if(hp>196){
      hp=196;
      }
      }
      
      //hp
      stroke(255,0,0,230);
      fill(255,0,0,230);
      rect(20,12,hp,18);  
      image(hpImg,10,10);
          
      //bump into enemy
      for(int i=0;i<5;i++){
      if(fighterY+fighter.height>enemyY[i] && fighterY+fighter.height<enemyY[i]+enemy.height && fighterX<enemyX[i]+enemy.width && fighterX+fighter.width>enemyX[i]){
            hp -= 196*0.2;
            enemyX[i]=-100;
            enemyY[i]=-100;
      }
      }
     
     
      //enemy moving      
      switch(enemyMode){
       case 4:
       int col=0, row=0;
         for(col=0;col<5;col++){
           for(row=0;row<5;row++){
             enemyY[row]=restartY;
             enemyX[col]=0-60*col+speed;
             image(enemy, enemyX[col], enemyY[row]);
           if(enemyX[col]>width+60*4){
            enemyMode=5; 
            speed=0;
            restartY=floor(random(50,290));
            }
      
          
      }
      speed++; 
           }
        


         
        break;
          
        case 5:
        for(int i=0;i<5;i++){
            enemyX[i]=0-60*i+speed;
            enemyY[i]=restartY+30*i;
            image(enemy, enemyX[i], enemyY[i]);
         if(enemyX[i]>width+60*4){
           enemyMode=6; 
           speed=0;
           restartY=floor(random(110,330));
            }
          speed++;
        }
     
        break;
       
        case 6:
        int restartY2=restartY;
        for(int i=0;i<3;i++){
            enemyX[i]=0-60*i+speed;
            enemyY[i]=restartY+30*i;
            image(enemy, enemyX[i], enemyY[i]);
            enemyY[i]=restartY2-30*i;
            image(enemy, enemyX[i], enemyY[i]);
            speed++;
          }
        for(int i=3;i<5;i++){
            enemyX[i]=0-60*i+speed;
            enemyY[i]=restartY-30*(i-4);
            image(enemy, enemyX[i], enemyY[i]);
            enemyY[i]=restartY2+30*(i-4);
            image(enemy, enemyX[i], enemyY[i]);
          if(enemyX[i]>width+60*4){
           enemyMode=4; 
           speed=0;
           restartY=floor(random(50,400));
            }
            speed++;
          }
        
         break;
    
  }



      
      break;
  
    case GAME_END:   
      image(endOne,0,0);
      if(mouseX>210 && mouseX<450 && mouseY>300 && mouseY<350){
      image(endTwo,0,0);
        if(mousePressed){
        gamestate=2;
        fighterX=570;
        fighterY=240;
        treasureX=floor(random(20,520));  
        treasureY=floor(random(50,430));
        hp=196*0.2;
        
        }
    }
   }
}
   


void keyPressed(){
  if(key == CODED){
    switch(keyCode){
      case UP:
        upPressed = true;
        break;
      case DOWN:
        downPressed = true;
        break;
      case LEFT:
        leftPressed = true;
        break;
      case RIGHT:
        rightPressed = true;
    }
  }
}

void keyReleased(){
 if(key == CODED){
    switch(keyCode){
      case UP:
        upPressed = false;
        break;
      case DOWN:
        downPressed = false;
        break;
      case LEFT:
        leftPressed = false;
        break;
      case RIGHT:
        rightPressed = false;
    }
  }
  }


    
