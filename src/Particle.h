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

class Particle{
    
public:
    Particle();
    void reset();
    void update();
    void draw();
    inline ofVec3f getLoc(){return loc;};
    
    
private:
    ofVec3f loc,vel,acc;
    
    
};

#endif /* defined(__LivingRoom__Particle__) */
