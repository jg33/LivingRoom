//
//  PartiCircle.h
//  LivingRoom
//
//  Created by Jesse Garrison on 9/10/14.
//
//

#ifndef __LivingRoom__PartiCircle__
#define __LivingRoom__PartiCircle__

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

#endif /* defined(__LivingRoom__PartiCircle__) */
