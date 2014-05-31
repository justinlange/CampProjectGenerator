import geomerative.*;
import org.apache.batik.svggen.font.table.*;
import org.apache.batik.svggen.font.*;
import processing.net.*; 
import http.requests.*;
import processing.serial.*; 


boolean beginSequence = false;
boolean firstRun = true;
long currentTime;
int mDelay = 2000;

Serial myPort;    // The serial port

String inString;  // Input string from serial port
int lf = 10;      // ASCII linefeed

//PFont font;
String[] finalyText = { " ", " " } ;


PImage border; 

RFont headerFont;
RFont bodyFont;

String headerFirstLine;
String headerSecondLine;
String header=" ";
int headerFontSize = 700;
int headerLineSpacing = headerFontSize;
int maxHeaderCount = 30;

String body= "";
int bodyFontSize = 350; 
int bodyLineSpacing = bodyFontSize;
int maxBodyCount = int(maxHeaderCount*1.5);


void setup() { 
  size(1100, 850);
  smooth();
  strokeWeight(1);

  initFonts();
  
  border = loadImage("cert.png");
  
  myPort = new Serial(this, Serial.list()[0], 9600); 
  myPort.bufferUntil(lf);
} 

void draw() { 
  background(255);
  image(border, 0, 0, width, height);
  fill(0);

  pushMatrix();
  translate(width/2, height/4);
  int headerOffset = titleText();
  popMatrix();
  

  pushMatrix();
  translate(width/2, 2*height/5);
  translate(0,headerOffset * height/10);
  scale(.1, .1);
  bodyText();
  popMatrix();


  if (beginSequence) {
    boolean printNow = beginCountdown();
    if (printNow) printOutput();
  }
  
} 

String[] getFuckingText(String[] finalText) {

  String heading;
  String body;

  GetRequest get = new GetRequest("http://itp-project-generator.herokuapp.com/");
  get.send();
  String butt = get.getContent();
  String[] sext = split(butt, "project");
  String[] sexty = split(sext[1], "/div");
  String[] sextyy = split(sexty[0], ">");
  String[] sextyyy = split(sextyy[1], "<");

  String[] sexting = split(sexty[1], "pitch");
  String[] sextingg = split(sexting[1], ">");
  String[] sextinggg = split(sextingg[1], "<");

  println(" ");
  println(sextyyy[0]);
  println(sextinggg[0]);

  heading = sextyyy[0];
  body = sextinggg[0];

  finalText[0] = heading;
  finalText[1]= body;

  return finalText;
}



String[] getOfflineText(String[] _finalText) {

  String heading = "GEARING EXHIBIT";
  String body = " " ;
  String[] finalText = _finalText;

  int selector = 1;

  switch(selector)
  {
  case 1: 
    body = "Explore this mechanical geared circus full of fish and i am creating a shared drawing/communication space on a journey of encountering our own privacy as much as we respect other's privacy. What if you think you got what it takes to beat the bike juice challenge? Try peddling a power bulb, a fan and a ford bronco: how does it all turn out?";
    break;
  default: 
    body = "blah blah";
    break;
  }

  finalText[0] = heading;
  finalText[1]= body;
  return finalText;
}

void keyPressed() {
  getFuckingText(finalyText);
  // getOfflineText(finalyText);
  saveOutput();  // COMMENT OR UNCOMMENT THIS LINE TO TOGGLE PRINTING ON AND OFF
}


void serialEvent(Serial p) { 
  inString = p.readString(); 
  if (p != null) {
    getFuckingText(finalyText);
    saveOutput();  // COMMENT OR UNCOMMENT THIS LINE TO TOGGLE PRINTING ON AND OFF
  }
}


void saveOutput() {
  //saveFrame(adjective + "-" + n + "-" + problem + "-" + audience + ".png");
  saveFrame("image.png");
  beginSequence = true;
}

void printOutput() {
  String[] cmd = {
    "lpr", "Desktop/Fucking ProjectGenerator/projectGenerator2/image.png"
  }; 
  //exec(cmd);
  beginSequence = false;
  firstRun = true;
}



boolean beginCountdown() {
  if (firstRun) {
    currentTime = millis(); 
    firstRun = false;
  }

  if (millis() - currentTime > mDelay) {
    return true;
  }

  return false;
}

