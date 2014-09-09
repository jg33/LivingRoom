//
//  VertBar.cpp
//  LivingRoom
//
//  Created by Jesse Garrison on 9/8/14.
//
//

#include "VertBar.h"
#include "ofMain.h"

VertBar::VertBar(){
    changeSpeed = ofRandom(0.00001,0.02);
    cout<<"made vert"<<endl;
}

void VertBar::update(){
    commonUpdate();
    color = ofColor(color,ofNoise(randomSeed+(ofGetFrameNum()*changeSpeed))*255);
    size = ofNoise(500+randomSeed+(ofGetFrameNum()*changeSpeed))*ofGetHeight();
}


void VertBar::draw(){
    ofSetRectMode(OF_RECTMODE_CENTER);
    ofSetColor(color);
    ofRect(loc.x, ofGetHeight()/2, 2, size);
}