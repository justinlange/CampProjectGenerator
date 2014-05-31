void bodyText(){
  String body = finalyText[1];
  int bodyLength = body.length();
  StringList bodyText;
  bodyText = new StringList();


  int splitIndex = 0;

  boolean breakBool = false;

  //only format body text if it's longer than one line
  if (bodyLength > maxBodyCount) {

    while (splitIndex < bodyLength) {
      //check to make sure we're not on the last line
      if (bodyLength-splitIndex > maxBodyCount) {
        //start at the end of the line and work backwords to the last break point
        for (int i = splitIndex+maxBodyCount; i>splitIndex; i--) {
          if (body.charAt(i) == ' ') {
            //println("splitindex: " + splitIndex + "  i: " + i);
            bodyText.append(body.substring(splitIndex, i));
            splitIndex = i;
            break;
          }
        }

        //we're on the last line, which will fit on the page without any further modification, so just append it
      } else {
        bodyText.append(body.substring(splitIndex, bodyLength));
        breakBool = true;
      }
      if (breakBool) break;
    }
  }else{
    bodyText.append(body.substring(0, bodyLength));
  }


  for (int i=0; i< bodyText.size (); i++) {
    bodyFont.draw(bodyText.get(i));
    translate(0, bodyLineSpacing);
  } 
  
}
