/**
 * Find Square-ish shape in webcam. 
 */
import gab.opencv.*;
import processing.video.*;
import java.awt.*;

Capture video;
OpenCV opencv;

int r = 2; //ratio 
void setup() {
  size(640, 480);
  video = new Capture(this, 640/r, 480/r);
  opencv = new OpenCV(this, 640/r, 480/r);
  opencv.loadCascade(OpenCV.CASCADE_FRONTALFACE);  
  
  video.start();
}

void draw() {
  scale(r);
  opencv.loadImage(video);
  
  pushMatrix();
  scale(-1, 1);
  translate(-width/r, 0);
  image(video,0 , 0);
  
  // opencv prepares stroke
  noFill();
  stroke(0, 255, 0);
  strokeWeight(3);
  
  // opecv returns found regions as a sequence of rectangles
  Rectangle[] faces = opencv.detect();
  println(faces.length);
  
  // draw rectangles
  for (int i = 0; i < faces.length; i++) {
    println(faces[i].x + "," + faces[i].y);
    rect(faces[i].x, faces[i].y, faces[i].width, faces[i].height);
  }
  
  popMatrix();
}

void captureEvent(Capture c) {
  c.read();
}



void startCamera(){
  String[] cameras = Capture.list();

  if (cameras == null) {
    println("Failed to retrieve the list of available cameras, will try the default...");
    video = new Capture(this, 640, 480);
  } else if (cameras.length == 0) {
    println("There are no cameras available for capture.");
    exit();
  } else {
    println("Available cameras:");
    printArray(cameras);    
    video = new Capture(this, cameras[0]);   
    video.start();
  }
}