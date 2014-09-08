#pragma once

#include "ofMain.h"
#include "ofxiOS.h"
#include "ofxiOSExtras.h"
#include "Particle.h"
#include "VertBar.h"

#define DEFAULT_PARTICLES 100
#define TOUCH_HOLD_TIME 60

#define CAM_WIDTH 1280
#define CAM_HEIGHT 720

#define DEBUG true
#define IS_SIMULATING true

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
    
    
private:
    int drawMode;
    void drawBars();
    void drawPanels();
    ofColor primaryColor, secondaryColor, tertiaryColor;
    
    vector<VertBar> particles;
    
    
    bool bTouchHeld;
    bool bIsGrabbing;
    int touchHoldCount;
    
    void grabColor();
    //ofVideoGrabber cam;
    ofTexture camTex;
    ofPixels camPix;
    
    
    ofFbo canvasFbo;
    
    enum drawModes{
        DRAW_BARS, DRAW_PULSE, DRAW_CLOCK
    };
    

};


