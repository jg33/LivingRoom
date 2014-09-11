//
//  Particle.h
//  LivingRoom
//
//  Created by Jesse Garrison on 9/7/14.
//
//

#ifndef __LivingRoom__Particle__
#define __LivingRoom__Particle__

#include <iostream>
#include "ofMain.h"

#define DEFAULT_MAX_LIFE 600

class Particle{
    
public:
    Particle();
    void reset();
    void commonUpdate();

    virtual inline void update(){};
    virtual inline void draw(){};

    inline ofVec3f getLoc(){return loc;};
    inline void setLoc(ofVec3f l){loc = l;};
    inline ofColor getColor(){return color;};
    inline void setColor(ofColor c){color = c;};

    bool bReadyToDie;
    
    
protected:
    int randomSeed;
    ofVec3f loc,vel,acc;
    ofColor color;
    float size, life, maxLife, drag;
    
    void keepOnScreen();
    void wrapToScreen();
    
    bool bIsImmortal;
    
};

#endif /* defined(__LivingRoom__Particle__) */
