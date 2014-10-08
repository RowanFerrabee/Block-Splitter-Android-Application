//Global Variables
float time = 0;
boolean game_started=false;
int gameMode = 2;        //2 rep. home screen, 1 rep. main game screen, 0 rep gameOver screen
PFont f;
Button easy;
Button medium;
Button hard;
float easyHigh=1000;
float medHigh=1000;
float hardHigh=1000;
boolean checkLit;

//In-Game Variables
int x_size = 2;
int y_size = 2;
int level = 0;           //0 rep easy, 1 rep med, 2 rep hard.
int temp1=0;
int temp2=0;
float final_time;
Button[] board = new Button [1];  //Board is array of buttons, will be initialized in the setup

void setup() {
  size(600, 600);     //Set 600x600 pixel screen

  f = createFont("Skia-Regular_Black",21); //Set up funkey font
  textFont(f);
  
  board[0] = new Button (0, 0, width, height, 0);   //Set the board (To start: one button to fill the entire screen)
  board[0].light();
  easy = new Button (10,10,100,100,0);              //Set up three buttons to stream into the -->
  easy.setText("Easy");    //Easy, Medium, and Hard levels of the game
  easy.light();
  medium = new Button (width/2, height/2, 100,100, 0);
  medium.setText("Medium");
  medium.light();
  hard = new Button (width-20, height-20, 100,100,0);
  hard.setText("Hard");
  hard.light();
  gameMode = 2;                                     //go to home screen
  
  background(0, 0, 0);          //black background
  textAlign(CENTER, CENTER);      //Align text to center
  textSize(30);
  text("Welcome to Block Splitter!", width/2, height/2);  //Write startup text
}


void draw() {

  if(!game_started){
    if(mousePressed){          //Only run the application one the screen has been pressed
      mousePressed = false;
      game_started = true;
    }
  }
  else{
  if (gameMode==2) {
    /* Title Screen */
    
    background(0,0,0);
    
    easy.setPos(width/4-50,(int)(-50+height/2+0.9*height*cos(millis()/900.0)/3.0));     //move the buttons up 
    medium.setPos(width/2-50,(int)(-50+height/2-0.9*height*sin(millis()/900.0)/3.0));   //and down across
    hard.setPos(3*width/4-50,(int)(-50+height/2-0.9*height*cos(millis()/900.0)/3.0));   //the starting screen
    
    pushStyle();
      textSize(20);
      fill(255,255,255);
      stroke(255,255,255);
      if(easyHigh!=1000){
      text(easyHigh,width/4,height*11/12);}
      if(medHigh!=1000){
      text(medHigh,width/2,height*11/12);}
      if(hardHigh!=1000){
      text(hardHigh,width*3/4,height*11/12);}
    popStyle();
    
    
    fill(0,255,0);    //Display easy as green
    easy.display();
    fill(255,255,0);  //Display medium as yellow 
    medium.display();
    fill(255,0,0);    //Display hard as red
    hard.display();
    
    if (easy.isPressed()) {  //stream to easy gameplay
      mousePressed=false;
      gameMode=1;
      level = 0;
      x_size=4;       //Set the max size of the board to 4x4
      y_size=4;
      time=millis();  //set starting time (like a checkpoint)
    }
    else if (medium.isPressed()) {  //stream to medium gameplay
      mousePressed=false;
      gameMode=1;
      level = 1;
      x_size=8;       //Set the max size of the board to 4x8
      y_size=4;
      time=millis();  //set starting time
    }
    else if (hard.isPressed()) {  //stream to hard gameplay
      mousePressed=false;
      gameMode=1;
      level = 2;
      x_size=8;       //Set the max size of the board to 8x8
      y_size=8;
      time=millis();  //set starting time
    }
    
  } 
    
   else if (gameMode==1) {
      /* Game Play */
      background(0, 0, 0);
      for (int x=0; x<board.length; x++) { //For each button
         if(board[x].lit)
           fill(229, 235, 65);
         else
           fill(50,50,50);
        board[x].display();  //Display each button
        if (board[x].isPressed()) { //If the user presses button is either of the yellow buttons
          if (board[x].w<=width/x_size&&board[x].h<=height/y_size) {  //If it is the smallest size
            //delete that button
            board = (Button[])concat((Button[])subset(board, 0, x), (Button[])subset(board, x+1));
          
         if(board.length>1){
          do{
            int p = (int)random(0,board.length);
            checkLit = board[p].lit;
            if(!checkLit)
            board[p].light();
          }while(checkLit);}

        }   
          //If it is not the smallest button, Split it (either veritcally or horizontally)
          else if (board[x].var==0) { //if the button is set to split vertically
            //set two more buttons side by side, each to split horizontally
            Button d = new Button(board[x].x, board[x].y, board[x].w/2, board[x].h, (board[x].var+1)%2);
            board = (Button[])append(board, d);
            board[x] = new Button(board[x].x+board[x].w/2, board[x].y, board[x].w/2, board[x].h, (board[x].var+1)%2);
            if(board.length<=2){board[0].light();board[1].light();}  
           else{
           do{
            int p = (int)random(0,board.length);
            checkLit = board[p].lit;
            if(!checkLit)
            board[p].light();
          }while(checkLit);}
      } 
          else if (board[x].var==1) {  //if the button is set to split horizontally      
            //set two more buttons on top of one another, each to split verticlly   
            Button d = new Button(board[x].x, board[x].y, board[x].w, board[x].h/2, (board[x].var+1)%2);
            board = (Button[])append(board, d);
            board[x] = new Button(board[x].x, board[x].y+board[x].h/2, board[x].w, board[x].h/2, (board[x].var+1)%2);
            if(board.length<=2){board[0].light();board[1].light();}
            else{
            do{
            int p = (int)random(0,board.length);
            checkLit = board[p].lit;
            if(!checkLit)
            board[p].light();
          }while(checkLit);}      
        }
          
          mousePressed=false;
        }
        textAlign(CENTER, CENTER);
        textSize(50);
        fill(196, 193, 199);
        text((int)(millis()-time)/1000, width/2, height/2);
      }
      if (board.length==0) {
        gameMode=0;
        mousePressed=false;
        final_time = (millis()-time)/1000;;
      }
    } 
    
    else if (gameMode==0) {
      /* Game Over Screen */
      background(0,0,0);
      if(level == 0 && final_time < easyHigh){
        easyHigh=final_time+0.00001;
        text("HIGH SCORE!",width/2,height/3);
      }
      else if(level == 1 && final_time < medHigh){
        medHigh=final_time+0.00001;
        text("HIGH SCORE!",width/2,height/3);
      }
      else if(level == 2 && final_time < hardHigh){
        hardHigh=final_time+0.00001;
        text("HIGH SCORE!",width/2,height/3);       
      }
      else {
        text("TRY AGAIN",width/2,height/3);}
      
      text((int)final_time, width/2, height/2);
      if (mousePressed) {
        board = (Button[])append(board, new Button (0, 0, width, height, 0));
        //setup();
        gameMode=2;
        mousePressed=false;
      }
    }
  }

}

String floatToString(float f){
    
    float f2 = 1000*f;
    int num = (int)f2;
    
    String s = "";
    
    while(num!=0){
        switch(num%10){
            case 0:
                s = "0" + s;
                break;
            case 1:
                s = "1" + s;
                break;
            case 2:
                s = "2" + s;
                break;
            case 3:
                s = "3" + s;
                break;
            case 4:
                s = "4" + s;
                break;
            case 5:
                s = "5" + s;
                break;
            case 6:
                s = "6" + s;
                break;
            case 7:
                s = "7" + s;
                break;
            case 8:
                s = "8" + s;
                break;
            case 9:
                s = "9" + s;
                break;
        }
        num/=10;
    }
    s = s.substring(0,s.length()-3)+"."+s.substring(s.length()-3,3);
    return s;

}

