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

    #if ON_DEVICE
        cam.initGrabber(CAM_WIDTH, CAM_HEIGHT);
    #endif
    camPix.allocate(CAM_WIDTH , CAM_HEIGHT, OF_PIXELS_RGB);
    camTex.allocate(CAM_WIDTH , CAM_HEIGHT, OF_PIXELS_RGB);
    //canvasFbo.allocate(ofGetWidth(), ofGetHeight());
    
    
    ofSoundStreamSetup(0, 1, this, 44100, beat.getBufferSize(), 4);
    
    drawMode = PANELS;
    setupMode(drawMode);

}

//--------------------------------------------------------------
void ofApp::update(){
    #if ON_DEVICE
        if(cam.isFrameNew()){
            cam.update();
        }
    #endif
    
    if(drawMode != prevMode){
        setupMode(drawMode);
        prevMode = drawMode;
    }
    
    
    for( int i = 0 ; i<particles.size();i++){ //always update everything
        particles[i]->update();
        
    }
    
    if(bTouchHeld){
        if(touchHoldCount>TOUCH_HOLD_TIME){
            bIsGrabbing = true;
        } else {
            touchHoldCount++;
        }
        
    }
    
    if(bIsGrabbing){
        grabColor();
    }
    
    beat.update(ofGetElapsedTimeMillis());


}

//--------------------------------------------------------------
void ofApp::draw(){
    //canvasFbo.begin();

	switch (drawMode){
        case BARS:
            drawBars();
            break;
        case PANELS:
            drawPanels();
            break;
            
            default:
            break;
            
    }
    //canvasFbo.end();
    //canvasFbo.draw(0,0,ofGetWidth() ,ofGetHeight());
    
    if (bIsGrabbing){ //display Camera
        ofSetRectMode(OF_RECTMODE_CORNER);
        camTex.draw(0,0,ofGetWidth(),ofGetHeight());
        ofNoFill();
        ofSetColor(grabbingColor);
        ofSetLineWidth(10);
        ofSetCircleResolution(500);
        ofCircle(ofGetWidth()/2, ofGetHeight()/2, 50);
    }
    
    if(DEBUG){
        ofSetColor(255);
        ofDrawBitmapString("mode:" + ofToString(drawMode)+" fps:" + ofToString(ofGetFrameRate()), 10,10);
    }
}

void ofApp::setupMode(drawModes newMode){
    if(newMode==BARS){
        particles.clear();
        for( int i = 0 ; i<DEFAULT_PARTICLES;i++){
            VertBar *newBar = new VertBar();
            particles.push_back( newBar );
            particles[i]->setLoc(ofVec3f(ofRandom(ofGetWidth()),ofRandom(ofGetHeight()),0));
            particles[i]->setColor(primaryColor);
            
        }
    } else if(newMode==PANELS){
        particles.clear();
        for( int i = 0 ; i<DEFAULT_PARTICLES;i++){
            SlidingPanel * newPanel = new SlidingPanel();
            particles.push_back( newPanel );
            particles[i]->setLoc(ofVec3f(ofRandom(ofGetWidth()),ofRandom(ofGetHeight()),0));
            particles[i]->setColor(primaryColor);
            
        }
        
    }
}

void ofApp::drawBars(){
    ofFill();
    ofSetRectMode(OF_RECTMODE_CORNER);
    ofSetColor(secondaryColor);
    ofRect(0,0,ofGetWidth(),ofGetHeight());
    
    for( int i = 0 ; i<particles.size();i++){
        particles[i]->draw();
        
    }
    
}

void ofApp::drawPanels(){
    ofFill();
    ofSetRectMode(OF_RECTMODE_CORNER);
    ofSetColor(tertiaryColor);
    ofRect(0,0,ofGetWidth(),ofGetHeight());//background
    
    for( int i = 0 ; i<particles.size();i++){
        particles[i]->draw();
        
    }
}

void ofApp::grabColor(){
    int numPix = camPix.getHeight()*camPix.getWidth();
    int step =10;
    int totalR,totalG, totalB;
    for (int i =0; i< numPix ; i+=step){ //get avg color
        int x = i%camPix.getWidth();
        int y = floor(i/camPix.getWidth());
        ofColor pixelColor = camPix.getColor(x, y);
        totalR+= pixelColor.r;
        totalG+= pixelColor.g;
        totalB+= pixelColor.b;
        
        
    }
    totalR/= numPix/step;
    totalG/= numPix/step;
    totalB/= numPix/step;
    
    grabbingColor = ofColor(totalR,totalG,totalB);

    
}

void ofApp::audioReceived(float * f, int buff  , int chan){
    
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
            
            primaryColor = grabbingColor;
        }
        
        for( int i = 0 ; i<particles.size();i++){
            particles[i]->setColor(primaryColor);
            
        }
        
        bIsGrabbing = false;
        
    } else { //tap to change modes
        if(drawMode == CLOCK){
            drawMode = BARS;
        } else  {
            int i = (int) drawMode; //cycle through modes
            i++;
            drawMode = (drawModes) i;
            cout<<drawMode<<endl;
        }
        
        
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
    switch(newOrientation){
        case OF_ORIENTATION_90_LEFT:
            ofSetOrientation(OF_ORIENTATION_90_LEFT);
            break;
        case OF_ORIENTATION_90_RIGHT:
            ofSetOrientation(OF_ORIENTATION_90_RIGHT);
            break;
        default:
            break;
    }
}

