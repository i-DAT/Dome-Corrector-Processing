import java.awt.*;
float angle = PI/2.4;
float apex = 140;
float distanceFromApex = 410;
float pinch = 0.0;
float verticalScaling = 0.68;

// Select a folder containg 800x600 images
// Dome corrected versions are generated, each with DC- prepended to the filename

void setup()
{
  size(1280,1024);
  smooth();
  noStroke();
  System.setProperty("apple.awt.fileDialogForDirectories", "true");
  FileDialog dialog = new FileDialog(new Frame());
  dialog.show();
  if(dialog.getDirectory() != null) {
    String[] filenames = (new File(dialog.getDirectory() + dialog.getFile())).list();
    for(int i=0; i<filenames.length ;i++) {
      if(isImageFile(filenames[i])) {
        println("Processing: " + filenames[i]);
        correctImage(dialog.getDirectory()+dialog.getFile()+"/"+filenames[i]);
      }
    }
  }
  exit();
}

boolean isImageFile(String filename)
{
  return (filename.toLowerCase().indexOf(".png") != -1) || (filename.toLowerCase().indexOf(".jpg") != -1);
}

void correctImage(String filename)
{
  PImage img = loadImage(filename);
  background(0);  
  pinch = 0.0;
  for(int i=0; i<img.height ;i++) drawRow(img,i);
  int index = filename.lastIndexOf("/");
  String newFilename = filename.substring(0,index+1) + "DC-" + filename.substring(index+1,filename.length());
  save(newFilename);
}

void drawRow(PImage img,int rowNum)
{
  pushMatrix();
  pinch+=0.0006-(rowNum*0.0000009);
  translate(width/2, apex);
  // Slight tweak for asymetry of dome 
  translate(-8,0);
  rotate(-(pinch-angle)/2.0);
  for(int i=0; i<img.width ;i++) {
    rotate(-(angle-pinch)/img.width);
    fill(img.get(i,rowNum));
    rect(0,distanceFromApex+(rowNum*verticalScaling),2.0,2.0);
  }
  popMatrix();
}

