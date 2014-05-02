//
//  Gameplay.m
//  echoBat
//
//  Created by Jordan on 5/2/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "Gameplay.h"

@implementation Gameplay {

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
//        [prey update];
//        [pred update];
//        [pulse update];
//        [echo update];
//        [pred caught:prey];
    }
    
    // update scoreboard?
    
    if(gameOver) {
        CCLOG(@"game over");
        //        CCScene *gameOverScene = [CCBReader loadAsScene:@"GameOver"];
        //        [[CCDirector sharedDirector] replaceScene:gameOverScene];
    }
    
    // update timer here?
}



- (void)turnLeft {
    //    _uiGround.rotation = -5;
    //    [pred turn:15];
    
}

- (void)turnRight {
    //    _uiGround.rotation = 5;
    //    [pred turn:-15];
}

- (void)sendPulse {
    // animate the echo button
    //    [pulseOut play];
    //    [pred pulse];
}

@end
