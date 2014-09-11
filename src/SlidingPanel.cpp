//
//  SlidingPanel.cpp
//  LivingRoom
//
//  Created by Jesse Garrison on 9/8/14.
//
//

#include "SlidingPanel.h"

SlidingPanel::SlidingPanel(){
    size = ofRandom(1,50);
    bIsImmortal = true;
    drag = 1;
}

void SlidingPanel::update(){
    commonUpdate();
    wrapToScreen();
    float speed = ofMap(size,1,50,0.1,0.01);
    acc = ofVec3f(0.1*ofSignedNoise(randomSeed+(ofGetFrameNum()*speed)),0,0) ;
}

void SlidingPanel::draw(){
    ofSetRectMode(OF_RECTMODE_CENTER);

    ofSetColor(color);
    ofRect(loc.x, ofGetHeight()/2, size, ofGetHeight());
}