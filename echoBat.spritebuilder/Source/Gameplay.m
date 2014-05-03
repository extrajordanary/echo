//
//  Gameplay.m
//  echoBat
//
//  Created by Jordan on 5/2/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "Gameplay.h"

@implementation Gameplay {
    
    CCSprite *_rotateLayer;
    CCSprite *_bat;
    
    CCActionRotateBy *batRight;
    CCActionRotateBy *batLeft;
    CCActionRotateTo *worldLeft;
    CCActionRotateTo *worldRight;

    OALSimpleAudio *audio;
    NSArray *soundFiles;
    NSArray *soundNames;
    NSDictionary *soundEffects;
    
    Bat *player;
    Bat *target;
    
    SoundWave *pulse;
    SoundWave *echo;
    
    float speed; // speed of bat
    float earFact; // factor divided by speed to get "ear size"
    int size; // bat and target size
    
    int caught; // timer to display extra text after each capture
    int speedCh; // timer to display change of bat speed txt
    int pulseCh; // timer to display change of pulse speed txt
    
    int timeElapsed; // milliseconds since start of program
    int gameDur;  // length of game in seconds
    int timerStart;  // for setting begining of timer
    int startPause;
    int timerPaused; // sum total of time in paused/lost mode
    int timer;  // current in-game timer
    
    int pulseSpeed; // speed of pulses (aka speed of sound in game)
    bool bounced; // has the current pulse generated an echo yet?
    bool heardR; // has right ear heard current echo?
    bool heardL; // has left ear heard current echo?
    
    float heading;
    
    int score;
    
    BOOL start;
    BOOL paused;
    BOOL gameOver;

}

- (id)init {
    self = [super init];

    if (self) {
        // initialize instance variables here
        caught = 0; // timer to display extra text after each capture
        speedCh = 0; // timer to display change of bat speed txt
        pulseCh = 0; // timer to display change of pulse speed txt
        
//        timeElapsed; // milliseconds since start of program
        gameDur = 180;  // length of game in seconds
//        timerStart;  // for setting begining of timer
//        startPause;
        timerPaused = 0; // sum total of time in paused/lost mode
        timer = gameDur;  // current in-game timer
        
        pulseSpeed = 10; // speed of pulses (aka speed of sound in game)
        bounced = false; // has the current pulse generated an echo yet?
        heardR = false; // has right ear heard current echo?
        heardL = false; // has left ear heard current echo?
        
        score = 0;
        
        start = false;
        paused = false;
        gameOver = false;
        
        CCLOG(@"start values set");
        
        // CCActions
        batLeft = [CCActionRotateBy actionWithDuration:.5 angle:-10];
        batRight = [CCActionRotateBy actionWithDuration:.5 angle:10];

        
        //create audio player and preload sound effects
        audio = [OALSimpleAudio sharedInstance];
        
        soundFiles = @[@"Published-iOS/echo_sounds/chirpLeft.caf",
                        @"Published-iOS/echo_sounds/chirpLeftBehind.caf",
                        @"Published-iOS/echo_sounds/chirpRight.caf",
                        @"Published-iOS/echo_sounds/chirpRightBehind.caf",
                        @"Published-iOS/echo_sounds/gameOver.caf",
                        @"Published-iOS/echo_sounds/pulseOut.caf",
                        @"Published-iOS/echo_sounds/scored3.caf",
                        @"Published-iOS/echo_sounds/crickets.caf"];

        for (NSString *string in soundFiles) {
            [audio preloadEffect:string];
        }
        
        soundNames = @[@"left",
                       @"leftB",
                       @"right",
                       @"rightB",
                       @"gameOver",
                       @"pulse",
                       @"score",
                       @"crickets"];
        
        soundEffects = [NSDictionary dictionaryWithObjects:soundFiles forKeys:soundNames];
        
        CCLOG(@"sound effects ready");
        
        // load initial bats and soundwaves
        player = [Bat withX:0 Y:0 size:size ears:earFact direction:270 speed:speed pred:true];
        CCLOG(@"made bat");
        heading = player->dir;
        target = [Bat withX:0 Y:0 size:size ears:0 direction:0 speed:0 pred:false];
        [target newLoc];
        pulse = [SoundWave withX:0 Y:0 speed:0]; // empty initial pulse
        echo = [SoundWave withX:0 Y:0 speed:0]; // empty initial echo

        // begin the game
        start = true;
        
        // finished initializing
        CCLOG(@"init");
    }
    return self;
}

- (void)didLoadFromCCB {
    // play background sound
    audio.bgVolume = 0.05f;
    [audio playBg:soundEffects[@"crickets"] loop:TRUE];

    CCLOG(@"loaded FromCCB");
}

// update method
- (void)update {
    if(!paused && start) {
        // update position
        [player update];
        
        // check for soundwaves hitting player or obstacles
        [self checkPulse];
        [self checkEcho];
        
        heading = player->dir;
        [pulse update];
        [echo update];
        
        // did the player catch the target?
        
        
    }
    
    // update scoreboard?
    
    if(gameOver) {
        CCLOG(@"game over");
        //        CCScene *gameOverScene = [CCBReader loadAsScene:@"GameOver"];
        //        [[CCDirector sharedDirector] replaceScene:gameOverScene];
    }
    
    // update timer here?
}

- (void)checkPulse {
    
    // if player's pulse hits the target start a new echo from target location
    float dist = [Vector2D distanceFrom:target->position to:pulse->position];
    if (pulse->radius > dist && !bounced) {
        echo = [SoundWave withX:target->position->x Y:target->position->y speed:pulseSpeed];
        bounced = true;
        heardR = false;
        heardL = false;
    }
}

- (void)checkEcho {
    // distance between echo and bat
    Vector2D *ang = [Vector2D withX:(echo->position->x - player->position->x)
                                  Y:(echo->position->y - player->position->y)];
    int ab = [Vector2D angleBetween:ang and:player->velocity];
            
    float dR = [Vector2D distanceFrom:player->rightEar to:echo->position];
    float dL = [Vector2D distanceFrom:player->leftEar to:echo->position];
            
    if (pulse->radius > dR && !heardR) {   // right ear
        if (ab > 120) {
            [audio playEffect:soundEffects[@"rightB"]];
        } else {
            [audio playEffect:soundEffects[@"right"]];
        }
        heardR = true;
    }
    if (pulse->radius > dL && !heardL) { // left ear
        if (ab > 120) {
            [audio playEffect:soundEffects[@"leftB"]];
        } else {
            [audio playEffect:soundEffects[@"left"]];
        }
        heardL = true;
    }
    

}

- (void)pauseGame {
    CCLOG(@"pause");
}

- (void)turnLeft {
    [_bat runAction:
                      [CCActionSequence actions:
                       batLeft,
                       batRight,
                       nil]];
 
//    [_bat setRotation:-10];
    CCLOG(@"turn left");
    [player turn:5];

    heading = player->dir;
    worldLeft = [CCActionRotateTo actionWithDuration:.5 angle:heading];
    [_rotateLayer runAction:
     [CCActionSequence actions:
      worldLeft,
      nil]];
    
//    [_rotateLayer setRotation:heading];
    CCLOG(@"heading %f", heading);
}

- (void)turnRight {
//    [_bat setRotation:10];
    
    [_bat runAction:
     [CCActionSequence actions:
      batRight,
      batLeft,
      nil]];
    
    CCLOG(@"turn right");
    [player turn:-5];
    heading = player->dir;
    worldRight = [CCActionRotateTo actionWithDuration:.5 angle:heading];

    [_rotateLayer runAction:
     [CCActionSequence actions:
      worldRight,
      nil]];
//    [_rotateLayer setRotation:heading];
    CCLOG(@"heading %f", player->dir);
}

- (void)sendPulse {
    [audio playEffect:soundEffects[@"pulse"]];
    // animate the echo button

    pulse = [SoundWave withX:player->position->x Y:player->position->y speed:pulseSpeed];
    bounced = false;
    CCLOG(@"new pulse");

}

@end
