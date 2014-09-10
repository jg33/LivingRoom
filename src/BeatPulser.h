//
//  BeatPulser.h
//  LivingRoom
//
//  Created by Jesse Garrison on 9/10/14.
//
//

#ifndef __LivingRoom__BeatPulser__
#define __LivingRoom__BeatPulser__

#include <iostream>
#include "ofMain.h"
#include "PartiCircle.h"

class BeatPulser{
public:
    BeatPulser();
    void init();
    
    ofVec3f loc;

    void update();
    void draw();
    
    void beat(float kick, float snare, float hat);
    
    void inline setColors(ofColor c1, ofColor c2, ofColor c3){primaryColor = c1; secondaryColor = c2; tertiaryColor = c3;};
    
    
private:
    ofColor primaryColor, secondaryColor, tertiaryColor;

    float outerCircleSize, middleShapeSize, partyBirthRate;
    
    vector<PartiCircle> party;
    
};

#endif /* defined(__LivingRoom__BeatPulser__) */
