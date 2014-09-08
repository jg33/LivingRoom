#include "ofApp.h"

//--------------------------------------------------------------
void ofApp::setup(){
    ofSetOrientation(OF_ORIENTATION_90_LEFT);
    ofSetFrameRate(60);
    ofEnableSmoothing();
    ofEnableAlphaBlending();
    
    
    primaryColor = primaryColor.royalBlue;
    secondaryColor = primaryColor;
    secondaryColor.setHueAngle(secondaryColor.getHueAngle()+120);
    tertiaryColor = secondaryColor;
    tertiaryColor.setHueAngle(tertiaryColor.getHueAngle()+120);

    
    //cam.initGrabber(CAM_WIDTH, CAM_HEIGHT);
    camPix.allocate(CAM_WIDTH , CAM_HEIGHT, OF_PIXELS_RGB);
    camTex.allocate(CAM_WIDTH , CAM_HEIGHT, OF_PIXELS_RGB);
    //canvasFbo.allocate(ofGetWidth(), ofGetHeight());
    
    
    for( int i = 0 ; i<DEFAULT_PARTICLES;i++){
        particles.push_back(VertBar());
        particles[i].setLoc(ofVec3f(ofRandom(ofGetWidth()),ofRandom(ofGetHeight()),0));
        particles[i].setColor(primaryColor);
        
    }

}

//--------------------------------------------------------------
void ofApp::update(){
    //if(cam.isFrameNew()){
        //cam.update();
    //}
    
    for( int i = 0 ; i<particles.size();i++){
        particles[i].update();
        
    }
    
    if(bTouchHeld){
        if(touchHoldCount>TOUCH_HOLD_TIME){
            bIsGrabbing = true;
        } else {
            touchHoldCount++;
        }
        
    }
    


}

//--------------------------------------------------------------
void ofApp::draw(){
    //canvasFbo.begin();

	switch (drawMode){
        case DRAW_BARS:
            drawBars();
            break;
    
            default:
            break;
            
    }
    //canvasFbo.end();
    //canvasFbo.draw(0,0,ofGetWidth() ,ofGetHeight());
    
    
    if(DEBUG){
        ofSetColor(255);
        ofDrawBitmapString(ofGetFrameRate(), 10,10);
    }
}

void ofApp::drawBars(){
    ofSetRectMode(OF_RECTMODE_CORNER);
    ofSetColor(secondaryColor);
    ofRect(0,0,ofGetWidth(),ofGetHeight());
    
    for( int i = 0 ; i<particles.size();i++){
        particles[i].draw();
        
    }
    
}

void ofApp::grabColor(){
    int numPix = camPix.getHeight()*camPix.getWidth();
    int totalR,totalG, totalB;
    for (int i =0; i< numPix;i++){ //get avg color
        int x = i%camPix.getWidth();
        int y = floor(i/camPix.getWidth());
        ofColor pixelColor = camPix.getColor(x, y);
        totalR+= pixelColor.r;
        totalG+= pixelColor.g;
        totalB+= pixelColor.b;
        
        
    }
    totalR/= numPix;
    totalG/= numPix;
    totalB/= numPix;
    
    primaryColor = ofColor(totalR,totalG,totalB);

    
}

//--------------------------------------------------------------
void ofApp::exit(){

}

//--------------------------------------------------------------
void ofApp::touchDown(ofTouchEventArgs & touch){
    bTouchHeld = true;
}

//--------------------------------------------------------------
void ofApp::touchMoved(ofTouchEventArgs & touch){

}

//--------------------------------------------------------------
void ofApp::touchUp(ofTouchEventArgs & touch){
    bTouchHeld = false;
    touchHoldCount = 0;
    
    if(bIsGrabbing){
        if(DEBUG){
            primaryColor = ofColor(ofRandom(255),ofRandom(255), ofRandom(255));
            secondaryColor = primaryColor;
            secondaryColor.setHueAngle(secondaryColor.getHueAngle()+120);
            tertiaryColor = secondaryColor;
            tertiaryColor.setHueAngle(tertiaryColor.getHueAngle()+120);
            
            
        } else{
            grabColor();
        }
        
        for( int i = 0 ; i<particles.size();i++){
            particles[i].setColor(primaryColor);
            
        }
        
    } else { //tap to change modes
        //drawMode++;
        //drawMode = drawMode%sizeof(drawModes);
        
        
    }
}

//--------------------------------------------------------------
void ofApp::touchDoubleTap(ofTouchEventArgs & touch){

}

//--------------------------------------------------------------
void ofApp::touchCancelled(ofTouchEventArgs & touch){
    bTouchHeld = false;
    touchHoldCount = 0;
}

//--------------------------------------------------------------
void ofApp::lostFocus(){
    touchHoldCount = 0;
    bIsGrabbing = false;
    bTouchHeld = false;
}

//--------------------------------------------------------------
void ofApp::gotFocus(){

}

//--------------------------------------------------------------
void ofApp::gotMemoryWarning(){

}

//--------------------------------------------------------------
void ofApp::deviceOrientationChanged(int newOrientation){

}

