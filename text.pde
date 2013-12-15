//import processing.opengl.*;
//import codeanticode.glgraphics.*;
//import japplemenubar.*;
//TO PLAY WITH THE VIZ:
//"h" gives the radial
//"l" will unfurl the radial into a line up, flattened comparison view
//"d" gives sectioned out view
//make sure to update the "if" equals... sparse or shmarse etc...


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

Article [] articles;

int[] wordCount = new int [numincsv];

String desks;
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
float hourly1;
int save1count;
boolean highlighting = false;

boolean b = false; 
boolean c = false;
boolean d = false;
boolean e = false;
boolean f = false;
boolean g = false;
boolean z = false;
boolean j = false;

boolean r = false; //for unmasking
boolean m = false; //for masking
boolean h = false; //for titles
boolean l = false; //switch titles to line up view

int maxSects;
int maxSectsIndex;
String kingsect;
String ckingsect;
int sect1num;

boolean a = false;
boolean s = false;
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
float[] radii = new float[numincsv];
float circlespacing = 0;
ArrayList countingit;
int storeArray[]=new int[numincsv];
int[] articleCount = new int [numcircles];
int[] offset = new int[numcircles];
int thingis;

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
  background(0); //100);
  //  if (PApplet.platform == PConstants.MACOSX)
  //    new JAppleMenuBar().setVisible( false );

  smooth();
  frameRate(120); //not 60
  font= loadFont("WhitneyHTF-Book-18.vlw");
  font2 = loadFont("WhitneyHTF-Book-24.vlw");
  font3 = loadFont("WhitneyHTF-Book-30.vlw");

  textFont(font, fontSize);
  // textFont(font2, fontSize);
  //  header = new Header();

  sdf = new SimpleDateFormat("MM/dd/yyyy HH:mm");
  hours_of_date = new SimpleDateFormat("HH");
  minutes_of_date= new SimpleDateFormat("mm");
  day_of_date = new SimpleDateFormat ("dd");
  format = new SimpleDateFormat("MM/dd/yyyy");
  articles = new Article[numincsv]; //have to declare length?DO I HAVE TOOOOOOOOOOOOOOOOOO
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
  for (int i = 1; i<articles.length; i++) {
    String[] pieces = splitLine(dates[i]);
    try {
      if (pieces.length >= 1) {
        Article article = new Article();
        article.section = pieces[0];
        String sectiond = article.section;
        //get date, parse and send to article object
        //        String dateString = pieces[0];
        //        article.timeStamp = sdf.parse(dateString);
        //        article.datey = dateString;
        ////////////////////////////////////////////////////////////////////////////////////////////////
        //        timeArray[i] = format.parse(dateString);

        //        diffArray[i] = (timeArray[i].getTime()-timeArray[1].getTime())/(1000 * 60 * 60 * 24);
        //        diffinArray[i] = (timeArray[i].getTime())/(1000 * 60 * 60 * 24);
        //        articleCount[(int) diffArray[i]]++;

        ////////////////////////////////////////////////////////////////////////////////////////////////

        //        article.hours = int (hours_of_date.format(article.timeStamp));
        //        article.minutes = int(minutes_of_date.format(article.timeStamp));

        //        article.dayis = int (day_of_date.format(article.timeStamp));
        // println (article.dayis);
        articles[i]=article;
      }
    }
    catch(Exception e) {
      println("error parsing this: " + pieces[2]);
    }
  }
  ////////////////////////////////////////////////////////////////////////////////////////////////
  //  println (timeArray[500]+"thisis500");
  //  println (timeArray[1]+"thisis1");
  //  long diff = timeArray[500].getTime() - timeArray[1].getTime();
  //  println("Difference In Days: " + (diff / (1000 * 60 * 60 * 24)));
  ////////////////////////////////////////////////////////////////////////////////////////////////
  String thing = articles[100].section;
  println (thing+" ---- ");
  //println (save1+"save1");
  println("number of articles: " + articles.length);
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
  background(0); //, 100);
  if (frameCount == 1)
    frame.setLocation(0, 0); //only need to be called on first draw frame
  //background(255, 100);
  globalTime += timeSpeed;
  if (globalTime >1) globalTime = 0;

  for (int i = 1; i< articles.length; i++) {
    if (articles[i] != null) {
      articles[i].prep();
      articles[i].update();
      articles[i].render();
    }
  }
  println (frameCount);
}

void show () {  
  h = true;
  for (int i = 1; i< articles.length; i++) {
    if (articles[i] != null) {

      strokeWeight(weightStroke);

      float turnBy = map (random(width), 0, width, 0, TWO_PI)-HALF_PI; //hours+norm(articles[i].minutes, 0, 60)
      articles[i].hourly = turnBy;

      articles[i].cx = 0; //width/(diffdays);//+radii[z]+spacing;    //(diffdays)+radii[z]+spacing; //circlespacing+
      articles[i].cy = 0;

      articles[i].tpos.x = (i%10)*80;
      articles[i].tpos.y = floor(i/10)*80;
    }
  }
}
void bringin () {  
  j = true;
  for (int i = 1; i< 100; i++) {
    if (articles[i] != null) {
      articles[i].hourly = 0; //rotation
      articles[i].tpos.x = 10;
      articles[i].tpos.y = map (i, 0, 100, 10, height*2) ;
    }
  }
}
void bringback() {
  j = false;
  for (int i = 0; i< 100; i++) {
    if (articles[i] != null) {
  articles[i].tpos.x = 10;
  articles[i].tpos.y = 10;
    }
  }
  for (int i = 100; i< 200; i++) {
    if (articles[i] != null) {
      articles[i].hourly = 0; //rotation
      articles[i].tpos.x = 10;
      articles[i].tpos.y = map (i, 100, 200, 10, height*2) ;
    }
  }
}
void scatter() {
  j = false;
  for (int i = 1; i< articles.length; i++) {
    if (articles[i] != null) {
      articles[i].hourly = i; //rotation
      articles[i].tpos.x += i/.1;
    }
  }
}
void highlight() {
  a = true;
}

void backtoall() {
  a=false;
}

//void bringin() {
//  j = true;
//}


void keyPressed() {
  if (key=='h') show();
  if (key=='j') bringin();
  if (key=='t')highlight();
  if (key=='k')bringback();
  if (key == 's') scatter();
  //  if (key=='l') lineUp2();
  //  if (key=='b')backtoall();
  //  if (key=='m')maskout();
  //  if (key=='o') amoeba();
  //if (key=='r') unmask();
}

//void maskout() {
//  m=true;
//}
//void unmask() {
//  r=true;
//}
//void amoeba() {
//  r=true;
//}

