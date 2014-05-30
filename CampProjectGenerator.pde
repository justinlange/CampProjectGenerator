import geomerative.*;
import org.apache.batik.svggen.font.table.*;
import org.apache.batik.svggen.font.*;
import processing.net.*; 
import http.requests.*;
import processing.serial.*; 


//////////////////////////////
boolean beginSequence = false;
//////////////////////////////
 
Serial myPort;    // The serial port

String inString;  // Input string from serial port
int lf = 10;      // ASCII linefeed

//PFont font;
String[] finalyText = {" "," " } ;

String header=" ";
String boddy= " ";

PImage border; 

  RFont headerFont;
  RFont bodyFont;



int fontSize = 350; 


void setup() { 
  
  size(1100,850);
  RG.init(this);
  //font = new RFont("OldLondon.ttf", fontSize, RFont.CENTER); 
  headerFont = new RFont("BigCaslon.ttf", fontSize, RFont.CENTER);
  bodyFont = new RFont("BigCaslon.ttf", fontSize, RFont.CENTER);

  //RCommand.setSegmentLength(1000);

  
  //String[] fontlist = PFont.list();
  //println(fontlist);
  //hint(ENABLE_NATIVE_FONTS);
  //font = createFont("BigCaslon-Medium", 28);
  //textFont(font);



  border = loadImage("cert.png");
  myPort = new Serial(this, Serial.list()[6], 9600); 
  myPort.bufferUntil(lf); 

} 


String headerFirstLine;
String headerSecondLine;


void draw() { 
  background(255);
  image(border,0,0,width,height);
  header = finalyText[0];
  boddy = finalyText[1];

  
  strokeWeight(1);
  
  int headerLength = header.length();
  int maxHeaderCount = 30;
  int lineSpacing = 40;
  
    translate(width/2,height/2);

  headerFont.setSize(35);
  fill(0);
  //stroke(0,0);
  
  if(headerLength > maxHeaderCount){
    
  
    //where we split the header into two lines
    int splitIndex = 0;
    
    boolean foundColon = false;
    for(int i=headerLength-1; i>0; i--){
       if(header.charAt(i) == ':'){
         foundColon = true;
         splitIndex = i+1;
         break;
       }
    }

    //find a nearby whitespace  
    if(!foundColon){
      for(int i=maxHeaderCount; i>0; i--){
        if(header.charAt(i) == ' '){
          splitIndex = i;
          break;
        }
      }
    }
      
    println("splitIndex: " + splitIndex); //debug only
    
    headerFirstLine = header.substring(0,splitIndex);
    headerSecondLine = header.substring(splitIndex, headerLength);
    headerFont.draw(headerFirstLine);
    translate(0,lineSpacing);
    headerFont.draw(headerSecondLine);

 
  }else{
  
  headerFont.draw(header);
  }
  
   // text(header, width/6, height/6, width-250, height-250);
   // text(boddy, width/6, (height/6) +150 , width-250, height-250);
    
////////////////////////////////////////////    
    if(beginSequence){
    boolean printNow = beginCountdown();
    if(printNow) printOutput();
  }
/////////////////////////////////////////////
} 




String[] getFuckingText(String[] finalText) {
  
  String heading;
  String body;
    
  GetRequest get = new GetRequest("http://itp-project-generator.herokuapp.com/");
  get.send();
  String butt = get.getContent();
  String[] sext = split(butt,"project");
  String[] sexty = split(sext[1],"/div");
  String[] sextyy = split(sexty[0],">");
  String[] sextyyy = split(sextyy[1],"<");
  
  String[] sexting = split(sexty[1],"pitch");
  String[] sextingg = split(sexting[1],">");
  String[] sextinggg = split(sextingg[1],"<");
  
  
  
  println(" ");
  println(sextyyy[0]);
  println(sextinggg[0]);
  //println("Reponse Content-Length Header: " + get.getHeader("Content-Length"));
  
  heading = sextyyy[0];
  body = sextinggg[0];
  
  finalText[0] = heading;
  finalText[1]= body;
  
  return finalText;

}


void serialEvent(Serial p) { 
  inString = p.readString(); 
 if(p != null){
 getFuckingText(finalyText);
 saveOutput();  // COMMENT OR UNCOMMENT THIS LINE TO TOGGLE PRINTING ON AND OFF
 }
}


void saveOutput(){
  //saveFrame(adjective + "-" + n + "-" + problem + "-" + audience + ".png");
      saveFrame("image.png");
      beginSequence = true;

}

void printOutput(){
       String[] cmd = {"lpr", "Desktop/Fucking ProjectGenerator/projectGenerator2/image.png"}; 
       //exec(cmd);
       beginSequence = false;
       firstRun = true;
}


boolean firstRun = true;
long currentTime;
int mDelay = 2000;

boolean beginCountdown(){
  if(firstRun){
     currentTime = millis(); 
     firstRun = false;
  }
  
  if(millis() - currentTime > mDelay){
    return true;
  }
  
  return false;
 
  
}

