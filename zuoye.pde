
import processing.pdf.*;
String[] imgNames={"花.png","星空.png","树.png","门.png"};
int imgIndex=0;


boolean savePDF;
PImage img ;
boolean SaveImage;
void setup(){
 
  size(800,600);
  initiate();
  frameRate(100);
}
void initiate(){
  img=loadImage(imgNames[imgIndex]);
   imgIndex += 1;
  if (imgIndex >= imgNames.length) {
    imgIndex = 0;
   
  }
}






void nextImage() {
  background(0);
  loop();
  frameCount = 0;
  
  img = loadImage(imgNames[imgIndex]);
 // img.loadPixels();
  
  imgIndex += 1;
  if (imgIndex >= imgNames.length) {
    imgIndex = 0;
  }
}



void draw(){
  
  if(mousePressed&&mouseY>20){
  
  
  mouseReleased();
}
 // fill(255,10);
  //rect(0,0,width,height);
     
 // background(255);
 
 else{
   background(255);
  img.loadPixels();
  if(savePDF==true){
    beginRecord(PDF,"vector画.png");
    
  }
  
  for(int i=0;i<200000;i++){
  int xx=floor(random(width));
  int yy=ceil(random(height));
  color c=img.get(xx,yy);
  float b=brightness(c);
  float esize=map(b,0,255,5,50);
  
  noStroke();
  //stroke(255);
  //tint(255,105);
  fill(c,105);
  ellipse(xx,yy,esize/5,esize/5);
  //if (mousePressed){
  //  noLoop();
  
  
  // fill(0);
  //rect(0,0,width,40);
  }
   
 
//drawrect();



  

  }
 
  if (savePDF==true){
    endRecord();
    savePDF=false;
  }
  if (SaveImage){
    save("outPut/花"+year()+month()+day()+hour()+minute()+second()+"jpg");
    SaveImage=false;
  }
  
  }
  
  void keyPressed(){
  if(key=='s'){
    SaveImage=true;
  }
   if(key=='c'){
        nextImage();
      }
   
    if(key=='r'){
      initiate();
    }
    if (key=='p'){
      if (savePDF==true){
        savePDF=false;
      }
      else{
        savePDF=true;
      }
      if(key=='e'){
      noLoop();
    }
    if(key=='b'){
      loop();
    }  
    
      
  }
}

  
  


//void drawrect(){
//   noStroke();
//  fill(124,203,255);
//  rect(0,0,20,20);
  
//  fill(255,124,124);
//  rect(20,0,20,20);
  
//  fill(124,255,133);
//  rect(40,0,20,20);
  
//  fill(255,255,124);
//  rect(60,0,20,20);
  
//  fill(255);
//  stroke(0);
//  rect(80,0,20,20);
//  noStroke();
//}


void paintStroke(float strokeLength, color strokeColor, int strokeThickness) {
  float stepLength = strokeLength/4.0;
  
  // Determines if the stroke is curved. A straight line is 0.
  float tangent1 = 0;
  float tangent2 = 0;
  
  float odds = random(1.0);
  
  if (odds < 0.7) {
    tangent1 = random(-strokeLength, strokeLength);
    tangent2 = random(-strokeLength, strokeLength);
  } 
  
  // Draw a big stroke
  noFill();
  stroke(strokeColor);
  strokeWeight(strokeThickness);
  curve(tangent1, -stepLength*2, 0, -stepLength, 0, stepLength, tangent2, stepLength*2);
  
  int z = 1;
  
  // Draw stroke's details
  for (int num = strokeThickness; num > 0; num --) {
    float offset = random(-50, 25);
    color newColor = color(red(strokeColor)+offset, green(strokeColor)+offset, blue(strokeColor)+offset, random(100, 255));
    
    stroke(newColor);
    strokeWeight((int)random(0, 3));
    curve(tangent1, -stepLength*2, z-strokeThickness/2, -stepLength*random(0.9, 1.1), z-strokeThickness/2, stepLength*random(0.9, 1.1), tangent2, stepLength*2);
    
    z += 1;
  }
}



void mouseReleased(){
  translate(width/2, height/2);
  
  int index = 0;
  
  for (int y = 0; y < img.height; y+=1) {
    for (int x = 0; x < img.width; x+=1) {
      int odds = (int)random(20000);
      
      if (odds < 1) {
        color pixelColor = img.pixels[index];
        pixelColor = color(red(pixelColor), green(pixelColor), blue(pixelColor), 100);
        
        pushMatrix();
        translate(x-img.width/2, y-img.height/2);
        rotate(radians(random(-90, 90)));
        
        // Paint by layers from rough strokes to finer details
        if (frameCount < 20) {
          // Big rough strokes
          paintStroke(random(150, 250), pixelColor, (int)random(20, 40));
        } else if (frameCount < 50) {
          // Thick strokes
          paintStroke(random(75, 125), pixelColor, (int)random(8, 12));
        } else if (frameCount < 300) {
          // Small strokes
          paintStroke(random(30, 60), pixelColor, (int)random(1, 4));
        } else if (frameCount < 350) {
          // Big dots
          paintStroke(random(5, 20), pixelColor, (int)random(5, 15));
        } else if (frameCount < 600) {
          // Small dots
          paintStroke(random(1, 10), pixelColor, (int)random(1, 7));
        }
        
        popMatrix();
      }
      
      index += 1;
    }
  
   }
  
  //if (frameCount > 600000) {
  //  initiate();
  //  loop();
  //  mouseReleased();

//  }
}
