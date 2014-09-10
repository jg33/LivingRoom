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
}


void Particle::commonUpdate(){
    vel += acc;
    loc += vel;
    
}

void Particle::keepOnScreen(){
    
    
}