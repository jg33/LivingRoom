//
//  BeatPulser.cpp
//  LivingRoom
//
//  Created by Jesse Garrison on 9/10/14.
//
//

#include "BeatPulser.h"

bool deathTest(Particle p){
    return p.bReadyToDie;
}

BeatPulser::BeatPulser(){
}

void BeatPulser::init(){

    
}

void BeatPulser::update(){
    
    for (int i=0; i<partyBirthRate; i++) {
        party.push_back(PartiCircle(loc, tertiaryColor));
        
    }
    
    ofRemove(party, deathTest);
    ofRemove(pulses, deathTest);

    for (int i=0;i<party.size();i++){
        party[i].update();
    }
    
    for (int i=0;i<pulses.size();i++){
        pulses[i].update();
    }
    
}

void BeatPulser::draw(){
    ofFill();
    
    ofSetCircleResolution(100);
    
    for (int i=0;i<pulses.size();i++){
        pulses[i].draw();
        
    }
    
    //ofSetColor(0,150);
    //ofCircle(loc, outerCircleSize+5);
    
    ofSetColor(primaryColor);
    ofCircle(loc, outerCircleSize);
    
    //ofSetColor(0,150);
    //ofCircle(loc, middleShapeSize+5);
    
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
    
    if (k >0){
        //pulses.push_back(PulseCircle(outerCircleSize, primaryColor));
    }
    
    if (DEBUG){
        outerCircleSize = 70;
        middleShapeSize = 50;
        partyBirthRate = 1;
    }
    
}