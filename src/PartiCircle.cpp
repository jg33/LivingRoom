//
//  PartiCircle.cpp
//  LivingRoom
//
//  Created by Jesse Garrison on 9/10/14.
//
//

#include "PartiCircle.h"

PartiCircle::PartiCircle(ofVec3f l, ofColor c){
    loc = l;
    color = c;
    
    acc = ofVec3f(ofRandom(-1,1),ofRandom(-1,1));
    initialSize = ofRandom(2,MAX_SIZE);
    
    drag = 1 - (initialSize/MAX_SIZE);
    
    maxLife = 6000;
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