#include "ofApp.h"

bool deathTest(Particle* p){
    return p->bReadyToDie;
}

//--------------------------------------------------------------
void ofApp::setup(){
    ofSetOrientation(OF_ORIENTATION_90_LEFT);
    ofSetFrameRate(60);
    ofEnableSmoothing();
    ofEnableAlphaBlending();
    
    
    primaryColor = primaryColor.royalBlue;
    updateColors();

    #if ON_DEVICE
        cam.initGrabber(CAM_WIDTH, CAM_HEIGHT, OF_IMAGE_COLOR);
    #endif
    camPix.allocate(CAM_WIDTH , CAM_HEIGHT, OF_IMAGE_COLOR);
    camTex.allocate(CAM_WIDTH , CAM_HEIGHT, GL_RGB);
    camTex.clear();
    //canvasFbo.allocate(ofGetWidth(), ofGetHeight());
    
    
    ofSoundStreamSetup(0, 1, this, 44100, beat.getBufferSize(), 4);
    
    drawMode = PULSE;
    setupMode(drawMode);

}

//--------------------------------------------------------------
void ofApp::update(){
    #if ON_DEVICE
        cam.update();

        if(cam.isFrameNew()&&bIsGrabbing){
            //camPix.set( *cam.getPixels());
            camPix.setFromPixels(cam.getPixelsRef());
            camTex = cam.getTextureReference();
            grabColor();

            
        }
    #endif
    
    if(drawMode != prevMode){
        setupMode(drawMode);
        prevMode = drawMode;
    }
    
    if (drawMode == PULSE){
        pulser.update();
        pulser.beat(beat.kick(),beat.snare(),beat.hihat());
    }
    
    for( int i = 0 ; i<particles.size();i++){ //always update everything
        particles[i]->update();
        
    }
    ofRemove(particles, deathTest);
    
    
    
    if(bTouchHeld){
        if(touchHoldCount>TOUCH_HOLD_TIME){
            bIsGrabbing = true;
        } else {
            touchHoldCount++;
        }
        
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
        case PULSE:
            ofBackground(0);
            pulser.draw();
            break;
        case CLOCK:
            ofBackground(255);
            break;
            default:
            break;
            
    }
    //canvasFbo.end();
    //canvasFbo.draw(0,0,ofGetWidth() ,ofGetHeight());
    
    if (bIsGrabbing){ //display Camera
        ofSetRectMode(OF_RECTMODE_CORNER);
        ofFill();
        ofSetColor(255,150);
        camTex.draw(0,0,ofGetWidth(),ofGetHeight());
        ofNoFill();
        ofSetColor(grabbingColor);
        ofSetLineWidth(10);
        ofSetCircleResolution(500);
        ofCircle(touchLoc, 50);
    }
    
    if(DEBUG){
        ofSetColor(255);
        ofDrawBitmapString("mode:" + ofToString(drawMode)+" fps:" + ofToString(ofGetFrameRate()), 10,10);
    }
}

void ofApp::setupMode(drawModes newMode){
    particles.clear();
    if(newMode==BARS){
        for( int i = 0 ; i<DEFAULT_PARTICLES;i++){
            VertBar *newBar = new VertBar();
            particles.push_back( newBar );
            particles[i]->setLoc(ofVec3f(ofRandom(ofGetWidth()),0,0));
            particles[i]->setColor(secondaryColor);
            
        }
    } else if(newMode==PANELS){
        for( int i = 0 ; i<DEFAULT_PARTICLES;i++){
            SlidingPanel * newPanel = new SlidingPanel();
            particles.push_back( newPanel );
            particles[i]->setLoc(ofVec3f(ofRandom(ofGetWidth()),0,0));
            switch (i%2) {
                case 0:
                    particles[i]->setColor(primaryColor);
                    break;
                    
                case 1:
                    particles[i]->setColor(secondaryColor);
                    break;
                default:
                    break;
            }
            
            
        }
        
    } else if( newMode == PULSE){
        pulser = BeatPulser();
        pulser.init();
        pulser.loc = ofVec3f(ofGetWidth()/2, ofGetHeight()/2);
        pulser.setColors(primaryColor, secondaryColor, tertiaryColor);
    }
}

void ofApp::drawBars(){
    ofFill();
    ofSetRectMode(OF_RECTMODE_CORNER);
    ofSetColor(primaryColor);
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
    //int numPix = camPix.getHeight()*camPix.getWidth();
    int step = 5;
    int counter =0;
    float totalR,totalG, totalB;
    
    for (int x =0; x< camPix.getWidth() ; x+=step){ //get avg color
        for (int y=0; y<camPix.getHeight(); y+=step){
            ofColor pixelColor = camPix.getColor(x, y);
            totalR+= pixelColor.r;
            totalG+= pixelColor.g;
            totalB+= pixelColor.b;
            
            

            counter++;
        }
        
        
    }
    
    totalR /= counter;
    totalG /= counter;
    totalB /= counter;
    cout<<totalR<<" "<<totalG<<" "<<totalB<<endl;
    
    grabbingColor = ofColor(totalR,totalG,totalB);

    
}

void ofApp::audioReceived(float * f, int buff  , int chan){
    
    if(beat.kick()>0.5){
        kickTimer = 0;
    } else {
        kickTimer++;
    }
    if (beat.snare() > 0.5){
        snareTimer =0;
    } else {
        snareTimer++;
    }
    if (beat.hihat() > 0.5){
        hatTimer = 0;
    } else {
        hatTimer++;
    }
    
    int timerTotal = kickTimer+snareTimer+hatTimer;
    tempo = BASE_TEMPO - timerTotal;
    
    
}

void ofApp::checkTempo(){
    
    
}


//--------------------------------------------------------------
void ofApp::exit(){

}

//--------------------------------------------------------------
void ofApp::touchDown(ofTouchEventArgs & touch){
    bTouchHeld = true;
    touchLoc = touch;
    
    if (!ON_DEVICE){
        grabbingColor = ofColor(ofRandom(255),ofRandom(255), ofRandom(255));
    }
}

//--------------------------------------------------------------
void ofApp::touchMoved(ofTouchEventArgs & touch){
    touchLoc = touch;

}

//--------------------------------------------------------------
void ofApp::touchUp(ofTouchEventArgs & touch){
    bTouchHeld = false;
    touchHoldCount = 0;
    
    if(bIsGrabbing){
        
        primaryColor = grabbingColor;
        updateColors();
        
        switch(drawMode){
            case PANELS:
                for(int i=0;i<particles.size();i++){
                    switch (i%2) {
                        case 0:
                            particles[i]->setColor(primaryColor);
                            break;
                            
                        case 1:
                            particles[i]->setColor(secondaryColor);
                            break;
                        default:
                            break;
                    }
                }
                break;
                
            case PULSE:
                pulser.setColors(primaryColor, secondaryColor, tertiaryColor);
                break;
            default:
                for( int i = 0 ; i<particles.size();i++){
                    particles[i]->setColor(secondaryColor);
                    
                }
                break;
        }
        

        
        bIsGrabbing = false;
        
    } else { //tap to change modes
        if(drawMode == CLOCK){
            drawMode = BARS;
        } else  {
            int i = (int) drawMode; //cycle through modes
            i++;
            drawMode = (drawModes) i;
        }
        
        
    }
    
    
}

void ofApp::updateColors(){
    secondaryColor = primaryColor;
    secondaryColor.setHueAngle(secondaryColor.getHueAngle()+150);
    tertiaryColor = secondaryColor;
    tertiaryColor.setHueAngle(tertiaryColor.getHueAngle()+60);
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

