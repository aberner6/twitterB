class Article {
  Date timeStamp;
  String section;
  String datey;
  //String timeStamp;
//  String headline;
  int wordCount;
  int dayis;
 float maxW;
// int[] wordCount = new int [1017];
  int hours;
  int minutes;
  //COLORS HERE
  float wordColor;

  float space;
  float lineLength;
  float lineHeight;
  float px;
  float py;

  PVector pos = new PVector();
  PVector tpos = new PVector();
  PVector postrans = new PVector();

  PVector posi = new PVector();
  PVector tposi = new PVector();
  PVector tpostrans = new PVector();

  PVector postext = new PVector();
  PVector tpostext = new PVector();

  float birthTime = 0;
  float cx;
  float cy;
  // int hourly1, hourly2, hourly3, hourly4, hourly5, hourly6, hourly7;

  float somethingX;
  float somethingY;

  int radius;
  float hoursRadius;
  float hourly;

  boolean hover = false;

  Article() {
//    headline = "";
    wordCount = 0;  
    timeStamp = new Date();
  }

  void prep() {
    for (int i = 0; i<articles.length; i++) {
      if (articles[i]!=null) {
         for (int z=0; z<articleCount.length; z++) {
        if (diffArray[i]==z) {
        //  println (diffArray[i]+"how far from first day"+z);
          //= radius; //*2 not articles.length/radiv
         radius = articleCount[z];
         hoursRadius = radius/radiv;
        }
      }
        //CHANGED NORM FUNCTION HERE from 0-60 to 0-180
        // hourly = map (articles[i].hours+norm(articles[i].minutes, 0, 60), 0, 24, 0, TWO_PI)-HALF_PI; //hours+norm(articles[i].minutes, 0, 60)
        px = cx+cos(hourly)*hoursRadius;
        py = cy + sin(hourly)*hoursRadius;
      // maxW = max(wordCount);
      }
    }
  }

  void update() {
    pos.x = lerp(pos.x, tpos.x, .1);//0.1);
    pos.y = lerp(pos.y, tpos.y, .1);//0.1);
    float hourly;
    float somethingX;
    float somethingY;
  }

  void render() {
    pushMatrix();
   
    //    translate(postrans.x, postrans.y);
    translate(cx, cy);
    //        point(0, 0);
     //Draw a faint black rectangle over what is currently on the stage so it fades over time.
  fill(255,90);
  rect(pos.x, pos.y, 3,3);
  
  
    rotate(hourly);
    text(section, pos.x, pos.y);
    popMatrix();
  }
}

