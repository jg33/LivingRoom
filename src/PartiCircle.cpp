//
//  PartiCircle.cpp
//  LivingRoom
//
//  Created by Jesse Garrison on 9/10/14.
//
//

#include "PartiCircle.h"

PartiCircle::PartiCircle(){
    
}

PartiCircle::PartiCircle(ofVec3f l, ofColor c){
    loc = l;
    color = c;
    
    acc = ofVec3f(ofRandom(-1,1),ofRandom(-1,1));
    initialSize = ofRandom(2,MAX_SIZE);
    
    drag = 1 - (initialSize/MAX_SIZE);
    
    maxLife = ofRandom(10 ,150);
    
    randomSeed = ofRandom(8912341);

    noiseFreq = ofRandom(0,1);
    noiseAmtX = ofRandom(-3,3);
    noiseAmtY = ofRandom(-3,3);
}


void PartiCircle::update(){
    commonUpdate();
    
    //size = MAX_SIZE;
    size = ofMap(life,0,maxLife,initialSize,0);
    
}

void PartiCircle::draw(){
    ofSetCircleResolution(size*5);
    ofSetColor(color);
    ofCircle(loc, size);
    
}


///PULSE CIRCLE

PulseCircle::PulseCircle(){
    
    growth = 1;
    
}

PulseCircle::PulseCircle(float s, ofColor c){
    size =s;
    growth = 1;
    opac =255;
    color = c;
    
    loc = ofVec3f(ofGetWidth()/2,ofGetHeight()/2);
}

void PulseCircle::update(){
    commonUpdate();
    
    opac -= growth;
    
    size += growth;
}

void PulseCircle::draw(){
    ofSetColor(color,opac);
    ofCircle(loc,size);
    
}