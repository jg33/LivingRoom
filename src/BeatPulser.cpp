//
//  BeatPulser.cpp
//  LivingRoom
//
//  Created by Jesse Garrison on 9/10/14.
//
//

#include "BeatPulser.h"

BeatPulser::BeatPulser(){
    
}

void BeatPulser::init(){

    
}

void BeatPulser::update(){
    
    for (int i=0; i<partyBirthRate; i++) {
        party.push_back(PartiCircle(loc, tertiaryColor));
        
    }
    

    for (int i=0;i<party.size();i++){
        party[i].update();
    }
    
}

void BeatPulser::draw(){
    ofFill();
    
    ofSetCircleResolution(100);
    ofSetColor(primaryColor);
    ofCircle(loc, outerCircleSize);
    
    ofSetColor(secondaryColor);
    ofCircle(loc, middleShapeSize);
    
    ofSetColor(primaryColor);
    for (int i=0;i<party.size();i++){
        party[i].draw();
        
    }
    
}

void BeatPulser::beat(float k, float s, float h){
    
    outerCircleSize = ofMap(k, 0, 1, 70, 200);
    middleShapeSize = ofMap(s,0,1, 50, 150);
    partyBirthRate = ofMap(h, 0, 1, 0, 5);
    
    if (DEBUG){
        outerCircleSize = 70;
        middleShapeSize = 50;
        partyBirthRate = 1;
    }
    
}