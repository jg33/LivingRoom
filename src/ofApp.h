#pragma once

#include "ofMain.h"
#include "ofxiOS.h"
#include "ofxiOSExtras.h"
#include "ofxBeat.h"
#include "Particle.h"
#include "VertBar.h"
#include "SlidingPanel.h"
#include "BeatPulser.h"


#define DEFAULT_PARTICLES 100
#define TOUCH_HOLD_TIME 60

#define CAM_WIDTH 1280
#define CAM_HEIGHT 720

#define DEBUG true
#define ON_DEVICE false

enum drawModes{
    BARS, PULSE, PANELS, CLOCK,
};

class ofApp : public ofxiOSApp{
	
    public:
        void setup();
        void update();
        void draw();
        void exit();
	
        void touchDown(ofTouchEventArgs & touch);
        void touchMoved(ofTouchEventArgs & touch);
        void touchUp(ofTouchEventArgs & touch);
        void touchDoubleTap(ofTouchEventArgs & touch);
        void touchCancelled(ofTouchEventArgs & touch);

        void lostFocus();
        void gotFocus();
        void gotMemoryWarning();
        void deviceOrientationChanged(int newOrientation);
    
        void audioReceived(float*, int , int);
        
        
    private:
        void setupMode(drawModes);
        void drawBars();
        void drawPanels();
        ofColor primaryColor, secondaryColor, tertiaryColor, grabbingColor;
        void updateColors();
    
        
        vector<Particle*> particles;
    
        BeatPulser pulser;
    

        bool bTouchHeld;
        bool bIsGrabbing;
        int touchHoldCount;
        ofVec3f touchLoc;
    
        void grabColor();
        #if ON_DEVICE
            ofVideoGrabber cam;
        #endif
        ofTexture camTex;
        ofImage camPix;
        
        ofxBeat beat;
        
        ofFbo canvasFbo;
    
        drawModes drawMode, prevMode ;
    
    
        ///Mode-Specific Stuff
        

    

};


