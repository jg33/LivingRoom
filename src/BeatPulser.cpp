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
    outerCircleSize = 10;
    middleShapeSize = 7;
    partyBirthRate = 3;
    
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
    
    outerCircleSize = ofMap(k, 0, 1, 10, 60);
    middleShapeSize = ofMap(s,0,1, 7, 50);
    partyBirthRate = ofMap(h, 0, 1, 0, 10);
    
}