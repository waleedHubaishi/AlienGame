import ddf.minim.*; //<>// //<>//

AudioPlayer player;
Minim minim;
int element =0;
int margin = 90;
PImage bg;
int jumpCounter=0;
//Player
int currentY=150;
boolean gameStart =false;
int score = 0;
int currentScore;
int initCount;
long lastTime = 0;

//waleed
BufferedReader reader;
String line;
PrintWriter output;
/////////

Rect[] rectArray = new Rect[12];

// Sandro player flugi load

void setup() {
  
 
 //PShape flugi = loadShape("flugi.svg");
  
  //shape(flugi, 50,50,50,50);  // Draw at coordinate (110, 90) at size 100 x 100
  //waleed
   // Open the file from the createWriter() example
  reader = createReader("highScore.txt"); 
   try {
    line = reader.readLine();
  } catch (IOException e) {
    e.printStackTrace();
    line = null;
    print("catch");
  }
  if (line == null) {
    print("line == null");
    // Stop reading because of an error or file is empty
    //noLoop();
  } else {
    String[] pieces = split(line, TAB);
    if(!((pieces[0])== null)){
      print("it is not null");
    score = parseInt(pieces[0]);
    }
    println(score + " score");
  }
  
  //Game speed
  frameRate(30);
  lastTime = millis();
  size(1024, 200, P2D);
  bg = loadImage("bg.png");
  background(bg);
  reset();

}

void draw() {
  //Get aliens by sound
  int lowTot = 0;
  for (int i = 0; i < player.left.size()/3.0; i+=5) {
    lowTot+= (abs(player.left.get(i)) * 50 );
  }
  drawRect(element, lowTot);
  element++;
  if (element >=rectArray.length) {
    element =0;
  }
}

void stop() {
  try {
    player.close();
  }
  catch(Exception err) {
  }
}

void jump() {
  jumpLoop(20);
  rejumpLoop(20);
}
   
void jumpLoop(int eHeight) {
  for (int i=0; i<=eHeight; i++) {
   PShape flugi = loadShape("flugi.svg");
    shape(flugi,0, currentY+i, 20, 20);
    // Sandro shape bot 
   
     
  }
  currentY+=eHeight;
}
void rejumpLoop(int eHeight) {
  for (int i=eHeight; i<=0; i--) {
   // fill(#11aaff);
    PShape flugi = loadShape("flugi.svg");
    shape(flugi, 50, currentY-i, 20, 20);
    // Sandro shape bot 
  }
  currentY-=eHeight;
}

void reset() {

  if (currentScore > score) {
    score = currentScore;
    // Create a new file in the sketch directory
    output = createWriter("highScore.txt");
    output.print(score);
    output.flush();
    output.close();
  }
  bg = loadImage("bg.png");
  background(bg);
  stop();
  bg = loadImage("bg.png");
  for (int i=0; i<rectArray.length; i++) {
    rectArray[i] =null;
  }

  minim = new Minim(this);
  player = minim.loadFile("song.mp3", 256);
  player.play();
  player.loop();
  element =0;
  margin = 90;
  jumpCounter=0;
  //Player
  currentY=150;
  gameStart =false;
  currentScore=0;
  initCount =0;
  lastTime = millis();

}