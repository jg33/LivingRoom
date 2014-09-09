//
//  SlidingPanel.h
//  LivingRoom
//
//  Created by Jesse Garrison on 9/8/14.
//
//

#ifndef __LivingRoom__SlidingPanel__
#define __LivingRoom__SlidingPanel__

#include <iostream>
#include "Particle.h"
#include "ofMain.h"

class SlidingPanel: public Particle{
    
public:
    SlidingPanel();
    void update();
    void draw();
    
    
};


#endif /* defined(__LivingRoom__SlidingPanel__) */
