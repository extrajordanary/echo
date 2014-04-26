//
//  Gameplay.m
//  EchoBat
//
//  Created by Jordan on 4/12/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#include <stdlib.h>
#import "Gameplay.h"
#import "Bat.h"
#import "Pulse.h"

@implementation Gameplay {
//    CCPhysicsNode *_physicsNode;
//    int rotDegrees;
    CCSprite *_uiGround;
    CCSprite *_uiBat;
//    CCPhysicsNode *_jointBase;
//    CCPhysicsJoint *_groundJoint;
//    CCPhysicsJoint *_batJoint;
}
    Bat *pred;
    Bat *prey;
    Pulse *pulse;
    Pulse *echo;

    int score; // number of targets caught



    float speed = 0.8f;  // speed of bat
    float earFact = 60;    // factor divided by speed to get "ear size"
    int size = 30; // bat and target size

    // text visibility counters
    int caught = 0; // timer to display extra text after each capture
    int speedCh = 0; // timer to display change of bat speed txt
    int pulseCh = 0; // timer to display change of pulse speed txt
    
    int timeElapsed; // milliseconds since start of program
    int gameDur = 180;  // length of game in seconds
    int timerStart;  // for setting begining of timer
    int startPause;
    int timerPaused = 0; // sum total of time in paused/lost mode
    //int timer = gameDur;  // current in-game timer
    
    int pulseSpeed = 10; // speed of pulses (aka speed of sound in game)
    bool bounced = false; // has the current pulse generated an echo yet?
    bool heardR = false; // has right ear heard current echo?
    bool heardL = false; // has left ear heard current echo?
    
    bool paused = false;
    bool started = false; // begin game?
    bool gameOver = false;  // end of game?


// update method
- (void)update {
    if(!paused && started) {
        [prey update];
        [pred update];
        [pulse update];
        [echo update];
        [pred caught:prey];
    }
    
    // update scoreboard?
    
    if(gameOver) {
        CCLOG(@"game over");
//        CCScene *gameOverScene = [CCBReader loadAsScene:@"GameOver"];
//        [[CCDirector sharedDirector] replaceScene:gameOverScene];
    }
    
    // update timer here?
}

// ** ROTATION CODE **
//CABasicAnimation *fullRotation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
//[fullRotation setFromValue:[NSNumber numberWithFloat:0]];
//[fullRotation setToValue:[NSNumber numberWithFloat:((360*M_PI)/180)]];
//[fullRotation setDuration:0.5f];
//
//[[element layer] addAnimation:fullRotation forKey:@"transform.rotation"];

////rotating
//CABasicAnimation *theAnimation;
//theAnimation=[CABasicAnimation animationWithKeyPath:@"transform.rotation"];
//theAnimation.duration=0.1;
//theAnimation.repeatCount=1;
//theAnimation.autoreverses=YES;
//theAnimation.fromValue=[NSNumber numberWithFloat:0];
//theAnimation.toValue=[NSNumber numberWithFloat:M_PI/3];
//[[targetView layer] addAnimation:theAnimation forKey:@"rotateLayer"];

// ** ROTATION CODE **
//CABasicAnimation *fullRotation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
//[fullRotation setFromValue:[NSNumber numberWithFloat:0]];
//[fullRotation setToValue:[NSNumber numberWithFloat:((360*M_PI)/180)]];
//[fullRotation setDuration:0.5f];
//
//[[element layer] addAnimation:fullRotation forKey:@"transform.rotation"];

////rotating
//CABasicAnimation *theAnimation;
//theAnimation=[CABasicAnimation animationWithKeyPath:@"transform.rotation"];
//theAnimation.duration=0.1;
//theAnimation.repeatCount=1;
//theAnimation.autoreverses=YES;
//theAnimation.fromValue=[NSNumber numberWithFloat:0];
//theAnimation.toValue=[NSNumber numberWithFloat:M_PI/3];
//[[targetView layer] addAnimation:theAnimation forKey:@"rotateLayer"];

- (void)turnLeft {
    _uiGround.rotation = -5;
    [pred turn:15];

}

- (void)turnRight {
    _uiGround.rotation = 5;
    [pred turn:-15];
}

- (void)sendPulse {
    // animate the echo button
    [pred pulse];
}

// is called when CCB file has completed loading
- (void)didLoadFromCCB {
    // create starter instances
    pred = [Bat withX:0 Y:0 size:size ears:earFact direction:270 speed:speed pred:true];
    prey = [Bat withX:0 Y:0 size:size ears:0 direction:0 speed:0 pred:false];
    [prey newLoc];
    pulse = [Pulse withX:0 Y:0 speed:0]; // empty initial pulse
    echo = [Pulse withX:0 Y:0 speed:0]; // empty initial echo
}


@end
