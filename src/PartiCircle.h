//
//  PartiCircle.h
//  LivingRoom
//
//  Created by Jesse Garrison on 9/10/14.
//
//

#ifndef __LivingRoom__PartiCircle__
#define __LivingRoom__PartiCircle__

#define MAX_SIZE 20

#include <iostream>
#include "ofMain.h"
#include "Particle.h"

class PartiCircle : public Particle{
public:
    PartiCircle();
    PartiCircle(ofVec3f startLocation, ofColor startColor);
    
    void update();
    void draw();
    
    
    
private:
    float initialSize;
    
};


class PulseCircle : public PartiCircle{
public:
    PulseCircle();
    PulseCircle(float size, ofColor startColor);
    
    void update();
    void draw();
    
private:
    float growth;
    float opac;
    
};
#endif /* defined(__LivingRoom__PartiCircle__) */
