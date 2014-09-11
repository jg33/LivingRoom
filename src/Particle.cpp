//
//  Particle.cpp
//  LivingRoom
//
//  Created by Jesse Garrison on 9/7/14.
//
//

#include "Particle.h"


Particle::Particle(){
    size = ofRandom(ofGetHeight()-20);
    randomSeed = ofRandom(66666);
    maxLife = DEFAULT_MAX_LIFE;
    drag = 1;
}


void Particle::commonUpdate(){
    vel += acc;
    vel *= drag;
    loc += vel;
    
    if(life>maxLife && !bIsImmortal){
        bReadyToDie = true;
    } else {
        life++;
    }
}

void Particle::keepOnScreen(){
    if(loc.x<-50 || loc.x> ofGetWidth()+50){
        vel.x = -vel.x;
    }
    if(loc.y<-50 || loc.y> ofGetHeight()+50){
        vel.y = -vel.y;
    }
    
}

void Particle::wrapToScreen(){
    if(loc.x<-50){
        loc.x= ofGetWidth()+50;
    } else if(loc.x> ofGetWidth()+50){
        loc.x = -50;
    } else if (loc.y<-50 ){
        loc.y = ofGetHeight()+50;
    } else if(loc.y> ofGetHeight()+50){
        loc.y = -50;
    }
    
}

