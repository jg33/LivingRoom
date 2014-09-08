//
//  VertBar.h
//  LivingRoom
//
//  Created by Jesse Garrison on 9/8/14.
//
//

#ifndef __LivingRoom__VertBar__
#define __LivingRoom__VertBar__

#include <iostream>
#include "Particle.h"
#include "ofMain.h"

class VertBar: public Particle{

    public:
        VertBar();
    void update();
        void draw();
    
private:
    float changeSpeed;
    
};


#endif /* defined(__LivingRoom__VertBar__) */
