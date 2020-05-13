boolean playPressed = false;
int rectX, rectY;      // Position of square button
int rectSize = 90;     // Diameter of rect
color rectColor;
boolean rectOver = false;

public class Rect {
  int x;
  int y;
  PShape alien = loadShape("alien.svg");
  public Rect(int i, int y) {
    this.x = width+(i * margin);
    this.y = height - (y%200) - 20;
  }
}



void update(int x, int y) {
   if ( overRect((width/2), 100, 32, 32) ) {
    rectOver = true;
  } else {
    rectOver = false;
  }
}

void mousePressed() {

  if (rectOver) {
    playPressed = true;
  }
}

boolean overRect(int x, int y, int width, int height)  {
  if (mouseX >= x-width && mouseX <= x+width && 
      mouseY >= y-(height/2) && mouseY <= y+(height/2)) {

        return true;
  } else {
    return false;
    
  }
}



void drawRect(int i, int y) {

  //play game  
  noStroke();
  stroke(255);
  fill(#9b3611);
  if (i<rectArray.length) {
    if (rectArray[i] == null) {
      rectArray[i] = new Rect(i, y);
      rect(rectArray[i].x, (rectArray[i].y), 20, 20);
      
      //Show alien on rect
      shape(rectArray[i].alien, (rectArray[i].x)-10, (rectArray[i].y)-5, 30, 40); // Draw at coordinate (x, y) at size 30 x 40
      
      if (i == rectArray.length-1) {
        margin=0;
      }
    } else {
      if (rectArray[i].x<=0) {
        rectArray[i] = null;
      }
      clear();

      //BG
      background(bg);
      //init game
      if(!playPressed)
      {
     update(mouseX, mouseY);
    
    
    fill(255);
    rect((width/2)-35, 85, 70, 40);
    
    
    fill(#000000);
    textAlign(CENTER, CENTER);
    textSize(32);
    text("Play", width/2, 100);
    
    noStroke();
    lastTime = millis();
    
    textSize(32);
    text("High score: "+score, width/2, 150);
    
    
    
      }
      if(playPressed){
      if (initCount < 5) {
        textSize(32);
        fill(#000000);
        textAlign(CENTER, CENTER);
        text("Game starts in 10s", width/2, 100);
        if (millis() - lastTime > 10000) {
          initCount++;
        }
      } else {
        //Score
        textSize(15);
        fill(#000000);
        textAlign(RIGHT, CENTER);
        text("High Score:"+score, 950, 50);
        fill(#ffa100);
        
        //current score
         textSize(15);
         fill(#000000);
         textAlign(RIGHT, CENTER);
         text("Score:"+currentScore,950,20);
         fill(#ffa100);
          
        for (int j=0; j<rectArray.length; j++) {
          if (rectArray[j] != null) {
            rectArray[j].x --;
            rect(rectArray[j].x, (rectArray[j].y), 20, 20);
            
            //Show alien on rect
            shape(rectArray[j].alien, (rectArray[j].x)-10, (rectArray[j].y)-5, 30, 40);
            
          }

          if (keyPressed) {
            if (jumpCounter%40 ==0) {
              //fill(#ffa100);
              PShape flugi = loadShape("flugi.svg");
              shape(flugi,50, currentY-1, 20, 20);
              // Sandro shape bot 
              currentY-=1;
            } else {
              jumpCounter++;
            }
          } else {
            int rectelement =0;
            boolean elokay = false;
            for (int k=0; k<rectArray.length; k++) {
              if (rectArray[k] != null) {
                if (rectArray[k].x <= 60 && rectArray[k].x >= 30) {
                  rectelement = k;
                  elokay = true;
                }
              }
            }
            if (rectArray[rectelement] != null && elokay) {
              if (currentY+10 == rectArray[rectelement].y) {
                PShape flugi = loadShape("flugi.svg");
                shape(flugi,50, currentY, 20, 20);
                // Sandro shape bot 
                
                //on Touch, change svg of alien
                rectArray[rectelement].alien = loadShape("alienDead.svg");
                
                currentScore++;
               
                
              } else {
                if (!gameStart) {
                  if (rectArray[0].x ==50) {
                    gameStart =true;
                  }
                }
                if (gameStart) {
                  PShape flugi = loadShape("flugi.svg");
                  shape(flugi, 50, currentY+1, 20, 20);
                  // Sandro shape bot 
                  currentY+=1;
                }
              }
            } else {
              if (gameStart) {
                PShape flugi = loadShape("flugi.svg");
                shape(flugi,50, currentY+1, 20, 20);
                // Sandro shape bot 
                currentY+=1;
              }
            }
          }
        }
        PShape flugi = loadShape("flugi.svg");
        shape(flugi,50, currentY, 20, 20);
        // Sandro shape bot 
      }
    }
  }
  }
  if (currentY <0 || currentY>200) {
    playPressed = false;
    reset();
  }
}