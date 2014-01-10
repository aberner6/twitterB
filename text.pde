//import processing.opengl.*;
//import codeanticode.glgraphics.*;
//import japplemenubar.*;
//TO PLAY WITH THE VIZ:
//void keyPressed() {
//  if (key=='h') show();
//  if (key=='j') bringin();
//  if (key=='k')bringback();
//  if (key == 's') scatter();
//  if (key=='a')highlight();
//  if (key=='b')backtoall();
//  if (key=='m') mind(); 
//  if (key=='r') brain();
//}


//import japplemenubar.JAppleMenuBar;
int numincsv = 297;

int masking;
PFont font;
PFont font2;
PFont font3;
int fontSize = 18;
int fontSize2 = 24;
int fontSize3 = 30;
int weightStroke = 3;
int numcsvs = 5;
int spacing = 11; 

String pieces;
String apes;

Tweet [] tweets;

String[] sectiond;

int maxW;

SimpleDateFormat sdf;
SimpleDateFormat format;
SimpleDateFormat hours_of_date;
SimpleDateFormat minutes_of_date;
SimpleDateFormat day_of_date;

int maxWords, minWords;
String headie;
int circleSize = 10;
float globalTime = 0; 
float timeSpeed = 0.01;

long startTime;
long endTime;

int liney = 10;
int transparency = 150;
int transp1 = 255;
int transp2 = 40;
int transp3 = 50;
int pad = 1;

//int deskWidth = width/deskOrder.length;

int cx, cy;
boolean highlighting = false;

boolean b,m,r,c,d,e,f,g,z,j,h,l,a,s = false; 
//import japplemenubar.JAppleMenuBar;

//______________
//public void init() {
//  frame.removeNotify();
//  frame.setUndecorated(true);
//  frame.addNotify();
//  super.init();
//}
int tick = 23;
float tickit;

///////////////////////////////////////////////////////////////////////
Date[]timeArray = new Date[numincsv];
long[]diffArray = new long[numincsv];
long[]diffinArray = new long[numincsv];
int numcircles = 35;
float circlespacing = 0;
ArrayList countingit;
int storeArray[]=new int[numincsv];
int[] tweetCount = new int [numcircles];

int radiv = 5;
int buffer = radiv*13; //FOR 0TH CIRCLE
int thiswidth= 1440;
int thisheight = 800;
float yspace=thisheight/5;
float xspace = thiswidth/6.45;

int radius;
float hoursRadius;
///////////////////////////////////////////////////////////////////////

void setup() {
  size(thiswidth, thisheight); //size(1500, 750); //100
  //size(6400, 720); //not 6400
  colorMode(HSB, 360, 100, 100);
  background(200,100); //100);
  //  if (PApplet.platform == PConstants.MACOSX)
  //    new JAppleMenuBar().setVisible( false );

  smooth();
  frameRate(120); //not 60
  font = loadFont("GeosansLight-14.vlw");
  font2 = loadFont("GeosansLight-48.vlw");

  //  textFont(font, fontSize);
  // textFont(font2, fontSize);
  //  header = new Header();

  sdf = new SimpleDateFormat("MM/dd/yyyy HH:mm");
  hours_of_date = new SimpleDateFormat("HH");
  minutes_of_date= new SimpleDateFormat("mm");
  day_of_date = new SimpleDateFormat ("dd");
  format = new SimpleDateFormat("MM/dd/yyyy");
  tweets = new Tweet[numincsv]; //have to declare length?DO I HAVE TOOOOOOOOOOOOOOOOOO
  String[] dates = loadStrings ("allresponses.csv");
  parse(dates);
  //  shmarse(sectiond);
}

void parse(String[]dates) {
  int maxWordsIndex=-1;
  int maxWords=0;
  int dayis = 0;
  int dayisIndex = -1;
  int offsetIndex = -1;
  //String dateString = 
  for (int i = 1; i<tweets.length; i++) {
    String[] pieces = splitLine(dates[i]);
    try {
      if (pieces.length >= 1) {
        Tweet tweet = new Tweet();
        tweet.section = pieces[0];
//        tweet.mind = pieces[1];
//        tweet.brain = pieces[2];
//        tweet.neuro = pieces[3];
        String sectiond = tweet.section;
        //get date, parse and send to tweet object
        //        String dateString = pieces[0];
        //        tweet.timeStamp = sdf.parse(dateString);
        //        tweet.datey = dateString;
        ////////////////////////////////////////////////////////////////////////////////////////////////
        //        timeArray[i] = format.parse(dateString);

        //        diffArray[i] = (timeArray[i].getTime()-timeArray[1].getTime())/(1000 * 60 * 60 * 24);
        //        diffinArray[i] = (timeArray[i].getTime())/(1000 * 60 * 60 * 24);
        //        tweetCount[(int) diffArray[i]]++;

        ////////////////////////////////////////////////////////////////////////////////////////////////

        //        tweet.hours = int (hours_of_date.format(tweet.timeStamp));
        //        tweet.minutes = int(minutes_of_date.format(tweet.timeStamp));

        //        tweet.dayis = int (day_of_date.format(tweet.timeStamp));
        // println (tweet.dayis);
        tweets[i]=tweet;
      }
    }
    catch(Exception e) {
      println("error parsing this: " + pieces[1]);
    }
  }
  ////////////////////////////////////////////////////////////////////////////////////////////////
  //  println (timeArray[500]+"thisis500");
  //  println (timeArray[1]+"thisis1");
  //  long diff = timeArray[500].getTime() - timeArray[1].getTime();
  //  println("Difference In Days: " + (diff / (1000 * 60 * 60 * 24)));
  ////////////////////////////////////////////////////////////////////////////////////////////////
  String thing = tweets[10].section;
  println (thing+" ---- ");
  //println (save1+"save1");
  println("number of tweets: " + tweets.length);
}

String[] splitLine(String line) {

  char[] c = line.toCharArray();
  ArrayList pieces = new ArrayList();
  ArrayList apes = new ArrayList();
  int prev = 0;
  boolean insideQuote = false;
  for (int i = 0; i<c.length; i++) {
    if (c[i]== ',') {
      if (!insideQuote) {
        String s = new String (c, prev, i-prev).trim();
        pieces.add(s);
        prev = i+1;
      }
    } 
    else if (c[i] == '\"') {
      insideQuote = !insideQuote;
    }
  }
  if (prev != c.length) {
    String s = new String(c, prev, c.length-prev).trim();
    pieces.add(s);
  }

  if (c.equals ("NULL")) {
    String s = new String(c, prev, c.length-prev).trim();
    apes.add(s);
  }


  String[] outgoing = new String[pieces.size()];
  String[] outgoing2 = new String[apes.size()];

  pieces.toArray(outgoing);
  apes.toArray(outgoing2);

  return outgoing;
}

void draw() {
  background(255,100); //, 100);
  if (frameCount == 1)
    frame.setLocation(0, 0); //only need to be called on first draw frame
  //background(255, 100);
  globalTime += timeSpeed;
  if (globalTime >1) globalTime = 0;

  for (int i = 1; i< tweets.length; i++) {
    if (tweets[i] != null) {
      if (!a) {
        //     tweets[i].font = ("GeosansLight-14.vlw");
        tweets[i].fontSize = 14;
        tweets[i].prep();
        tweets[i].update();
        tweets[i].render();
      }
      if (a) {
        //     tweets[i].font = ("GeosansLight-48.vlw"); //GeosansLight-14
        tweets[i].prep();
        tweets[i].update();
        tweets[i].render();
      }
    }
  }
}

void show () {  
  h = true;
  for (int i = 1; i< tweets.length; i++) {
    if (tweets[i] != null) {
      strokeWeight(weightStroke);

      float turnBy = map (i, 0, width/2, 0, TWO_PI)-HALF_PI; //hours+norm(tweets[i].minutes, 0, 60)
      tweets[i].hourly = turnBy;

      tweets[i].cx = 0; //width/(diffdays);//+radii[z]+spacing;    //(diffdays)+radii[z]+spacing; //circlespacing+
      tweets[i].cy = 0;

      tweets[i].tpos.x = 10;
      tweets[i].tpos.y = map (i, 0, tweets.length, 1, height*4);
    }
  }
}
void bringin () {  
  j = true;
  for (int i = 1; i< 100; i++) {
    if (tweets[i] != null) {
      tweets[i].hourly = 0; //rotation
      tweets[i].tpos.x = 10;
      tweets[i].tpos.y = map (i, 0, 100, 10, height*2) ;
    }
  }
}
void bringback() {
  j = false;
  for (int i = 0; i< 100; i++) {
    if (tweets[i] != null) {
      tweets[i].tpos.x = 1;
      //      tweets[i].tpos.y = 10;
      float turnBy = map (i, 0, width/2, 0, TWO_PI)-HALF_PI; //hours+norm(tweets[i].minutes, 0, 60)
      tweets[i].hourly = turnBy;
      tweets[i].tpos.y = map (i, 100, 200, 10, height*2) ;
    }
  }
  for (int i = 100; i< 200; i++) {
    if (tweets[i] != null) {
      tweets[i].hourly = 0; //rotation
      tweets[i].tpos.x = 10;
      tweets[i].tpos.y = map (i, 100, 200, 10, height*2) ;
    }
  }
}
void scatter() {
  j = false;
  for (int i = 1; i< tweets.length; i++) {
    if (tweets[i] != null) {
      tweets[i].hourly = i; //rotation
      tweets[i].tpos.x += i/.1;
    }
  }
}
void highlight() {
  a = true;
  for (int i = 1; i< tweets.length; i++) {
    if (tweets[i] != null) 
      if (tweets[i].section.contains("Fact")) {
        tweets[i].hourly = 0;
        String wordIs = tweets[i].section;
        println (wordIs);
        if (wordIs!=wordIs) {
          tweets[i].section = wordIs;
        }

        //      tweets[i].font = font2; //GeosansLight-14
        tweets[i].fontSize = 30;
        tweets[i].tpos.x = 10;
        tweets[i].tpos.y = map (i, 0, tweets.length, 10, height*4) ;
      }
      else {
        tweets[i].fontSize = 14;
      }
  }
}

void mind(){
 a=false;
 m=true;
}

void brain(){
  a=false;
  m=false;
  
}

void backtoall() {
  a=false;
}


void keyPressed() {
  if (key=='h') show();
  if (key=='j') bringin();
  if (key=='k')bringback();
  if (key == 's') scatter();
  if (key=='a')highlight();
  if (key=='b')backtoall();
  if (key=='m') mind(); 
  if (key=='r') brain();
}

