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
    
    acc = ofVec3f(ofRandom(-2,2),ofRandom(-2,2),ofRandom(-0.5,-0.5));
    initialSize = ofRandom(2,20);
}

void PartiCircle::update(){
    commonUpdate();
    
    size = ofMap(life,0,maxLife,0,initialSize);
    
}

void PartiCircle::draw(){
    ofSetColor(color);
    ofCircle(loc, size);
    
}