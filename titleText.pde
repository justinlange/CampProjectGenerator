int titleText(){
  int headerOffset = 0;

  header = toTitleCase(finalyText[0].toLowerCase());
  int headerLength = header.length();

  scale(.1, .1);
  if (headerLength > maxHeaderCount) {

    //marker for where split the header into two lines, if needed
    int splitIndex = 0;

    boolean foundColon = false;
    for (int i=int (headerLength*.7); i>int(headerLength*.3); i--) {
      if (header.charAt(i) == ':') {
        foundColon = true;
        splitIndex = i+1;
        break;
      }
    }

    //find a nearby whitespace  
    if (!foundColon) {
      for (int i=maxHeaderCount; i>0; i--) {
        if (header.charAt(i) == ' ') {
          splitIndex = i;
          break;
        }
      }
    }
    //println("splitIndex: " + splitIndex); //debug only
    headerFirstLine = header.substring(0, splitIndex);
    headerSecondLine = header.substring(splitIndex, headerLength);
    headerFont.draw(headerFirstLine);
    translate(0, headerLineSpacing);
    headerFont.draw(headerSecondLine);
    headerOffset = 1;
  } else {
    headerFont.draw(header);
    headerOffset = 0;
  }  
  
  return headerOffset;
}
