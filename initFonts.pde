void initFonts(){
 
  RG.init(this);

  //  maxHeaderCount = 30;
  //  headerFontSize = 600;
  //  headerFont = new RFont("Shadowed Germanica.ttf", headerFontSize, RFont.CENTER);

  maxHeaderCount = 30;
  headerFontSize = 600;
  headerFont = new RFont("Seagram tfb 2.ttf", headerFontSize, RFont.CENTER);

  //headerFont = new RFont("AGothiqueTime.ttf", headerFontSize, RFont.CENTER); 
  //headerFont = new RFont("OldLondon.ttf", headerFontSize, RFont.CENTER);

  //bodyFont = new RFont("BigCaslon.ttf", bodyFontSize, RFont.CENTER);

  //   maxBodyCount = 50;
  //   bodyFontSize = 1200;
  //   bodyLineSpacing = 700;
  //   bodyFont = new RFont("Respective_2.0.ttf", bodyFontSize, RFont.CENTER);



  maxBodyCount = 50;
  //   bodyFontSize = 1200;
  //   bodyLineSpacing = 700;
  bodyFont = new RFont("Identica-Regular.ttf", bodyFontSize, RFont.CENTER);

  RCommand.setSegmentLength(0);
 }
