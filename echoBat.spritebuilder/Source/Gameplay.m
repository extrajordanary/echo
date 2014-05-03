//
//  Gameplay.m
//  echoBat
//
//  Created by Jordan on 5/2/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "Gameplay.h"

@implementation Gameplay {
    
    int counter;
    
    CCSprite *_rotateLayer;
    CCSprite *_bat;
    
    CCSprite *_pix1;
    CCSprite *_pix2;
    
    CCActionRotateBy *batRight;
    CCActionRotateBy *batLeft;
    CCActionRotateTo *worldLeft;
    CCActionRotateTo *worldRight;
    
    CGRect gameZone;

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
        
        counter = 0;
//        int h = [[UIScreen mainScreen] bounds].size.height;
//        int w = [[UIScreen mainScreen] bounds].size.width;
        gameZone = CGRectMake(0, 0, 300, 300);
 
        // initialize instance variables here
        speed = .1;  // speed of bat
        earFact = 60;    // factor divided by speed to get "ear size"
        size = 10; // bat and target size
        
        caught = 0; // timer to display extra text after each capture
        speedCh = 0; // timer to display change of bat speed txt
        pulseCh = 0; // timer to display change of pulse speed txt
        
//        timeElapsed; // milliseconds since start of program
        gameDur = 180;  // length of game in seconds
//        timerStart;  // for setting begining of timer
//        startPause;
        timerPaused = 0; // sum total of time in paused/lost mode
        timer = gameDur;  // current in-game timer
        
        pulseSpeed = 4; // speed of pulses (aka speed of sound in game)
        bounced = false; // has the current pulse generated an echo yet?
        heardR = false; // has right ear heard current echo?
        heardL = false; // has left ear heard current echo?
        
        score = 0;
        
        start = false;
        paused = false;
        gameOver = false;
        
        CCLOG(@"start values set");
        
        // CCActions
        batLeft = [CCActionRotateTo actionWithDuration:.5 angle:-10];
        batRight = [CCActionRotateTo actionWithDuration:.5 angle:10];

        
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
        player = [Bat withX:0 Y:0 size:size ears:earFact direction:45 speed:speed pred:true];
        CCLOG(@"made bat");
        heading = player->dir;
        target = [Bat withX:50 Y:50 size:size ears:0 direction:0 speed:0 pred:false];
//        [target newLoc];
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
- (void)update:(CCTime)delta {
//    CCLOG(@"update");
    if(!paused && start) {
//        CCLOG(@"u");

        // update position
        [player update];
        
        _pix1.position = CGPointMake(player->position->x, player->position->y);
        _pix2.position = CGPointMake(target->position->x, target->position->y);

        
        // check for soundwaves hitting player or obstacles
        [self checkPulse];
        [self checkEcho];
        
//        heading = player->dir;
        
        
        [pulse update];
        [echo update];
        
        // did the player catch the target?
        [self checkCatch];
        
    }
    
    // update scoreboard TODO
    
    if(gameOver) {
        CCLOG(@"game over");
        //        CCScene *gameOverScene = [CCBReader loadAsScene:@"GameOver"];
        //        [[CCDirector sharedDirector] replaceScene:gameOverScene];
    }
    
    // update timer TODO
}

- (void)checkCatch {
    // if player catches target, increase score and move target to new location
    float dist = [Vector2D distanceFrom:player->position to:target->position];
    if (dist < (player->size + target->size)) {
        score += 1;
        caught = 100;

        [audio playEffect:soundEffects[@"score"]];
        CCLOG(@"new echo");
        [target newLoc:gameZone];
        CCLOG(@"new target %f, %f", target->position->x, target->position->y);
    }

    
}

- (void)checkPulse {
    
    // if player's pulse hits the target start a new echo from target location
    float dist = [Vector2D distanceFrom:target->position to:pulse->position];
    if (pulse->radius > dist && !bounced) {
        echo = [SoundWave withX:target->position->x Y:target->position->y speed:pulseSpeed];
        bounced = true;
        heardR = false;
        heardL = false;
        CCLOG(@"new echo %f, %f", target->position->x, target->position->y);
    }
}

- (void)checkEcho {
    
    
//    Vector2D *ang = [Vector2D withX:(echo->position->x - player->position->x)
//                                  Y:(echo->position->y - player->position->y)];
    
    Vector2D *ang = [Vector2D withX:(target->position->x - player->position->x)
                                  Y:(target->position->y - player->position->y)];

    Vector2D *targ = [Vector2D withX:50 Y:50];
    float targAng = [Vector2D getAngle:targ];
    
    Vector2D *theplayer = [Vector2D withX:player->position->x Y:player->position->y];
    float tpAng = [Vector2D getAngle:theplayer];
    
    float tar2pAng = [Vector2D getAngle:ang];
    
    float temp2 = [Vector2D getAngle:player->velocity];

    
    int ab = [Vector2D angleBetween:player->velocity and:ang];
    float dot = [Vector2D dot:player->velocity with:ang];
    
    heading = player->dir;
    
    if (counter > 100) {
//        CCLOG(@"target angle %f", targAng);
        CCLOG(@"player angle %f", tpAng);
//        CCLOG(@"difference = %f", targAng - tpAng);
//        CCLOG(@"target to player angle - %f", tar2pAng);

        CCLOG(@"velocity - %f", temp2);
//        CCLOG(@"heading - %f", heading);
        CCLOG(@"player to target angle %i", ab);
        CCLOG(@"difference1 --- %f", temp2-ab);
        CCLOG(@"difference2 --- %f", ab-tpAng);
//        CCLOG(@"dot   %f", dot);
        
        counter =0;
    }
    counter += 1;

    // distance between echo origin and bat
    float dR = [Vector2D distanceFrom:player->rightEar to:echo->position];
    float dL = [Vector2D distanceFrom:player->leftEar to:echo->position];
            
    if (echo->radius > dR && !heardR) {   // right ear
        if (ab > 120) {
//            [audio playEffect:soundEffects[@"rightB"]];
            [audio playEffect:soundEffects[@"leftB"] volume:.7 pitch:1 pan:1 loop:false];
            CCLOG(@"behind right ear");
        } else {
//            [audio playEffect:soundEffects[@"right"]];
            [audio playEffect:soundEffects[@"left"] volume:1 pitch:1 pan:1 loop:false];
            CCLOG(@"right ear");
        }
        heardR = true;
    }
    if (echo->radius > dL && !heardL) { // left ear
        if (ab > 120) {
//            [audio playEffect:soundEffects[@"leftB"]];
            [audio playEffect:soundEffects[@"leftB"] volume:.7 pitch:1 pan:-1 loop:false];
            CCLOG(@"behind left ear");
        } else {
//            [audio playEffect:soundEffects[@"left"]];
            [audio playEffect:soundEffects[@"left"] volume:1 pitch:1 pan:-1 loop:false];
            CCLOG(@"left ear");
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
//    CCLOG(@"turn left");
    [player turn:5];

//    heading = player->dir;
    worldLeft = [CCActionRotateTo actionWithDuration:.5 angle:heading];
    [_rotateLayer runAction:
     [CCActionSequence actions:
      worldLeft,
      nil]];
    
//    CCLOG(@"heading %f", heading);
}

- (void)turnRight {
//    [_bat setRotation:10];
    
    [_bat runAction:
     [CCActionSequence actions:
      batRight,
      batLeft,
      nil]];
    
//    CCLOG(@"turn right");
    
    [player turn:-5];
    
//    heading = player->dir;
    worldRight = [CCActionRotateTo actionWithDuration:.5 angle:heading];

    [_rotateLayer runAction:
     [CCActionSequence actions:
      worldRight,
      nil]];
//    CCLOG(@"heading %f", player->dir);
}

- (void)sendPulse {
    [audio playEffect:soundEffects[@"pulse"]];
    // animate the echo button

    pulse = [SoundWave withX:player->position->x Y:player->position->y speed:pulseSpeed];
    bounced = false;
    CCLOG(@"new pulse %f, %f", player->position->x, player->position->y);

}

-(void) playRight {
    [audio playEffect:soundEffects[@"left"] volume:1 pitch:1 pan:1 loop:false];
    
//    [audio playEffect:soundEffects[@"right"]];
    CCLOG(@"R");
}

-(void) playRightB {
    [audio playEffect:soundEffects[@"leftB"] volume:.7 pitch:1 pan:1 loop:false];
    CCLOG(@"R B");
}

-(void) playLeft {
    [audio playEffect:soundEffects[@"left"] volume:1 pitch:1 pan:-1 loop:false];
    CCLOG(@"L");
}

-(void) playLeftB {
    [audio playEffect:soundEffects[@"leftB"] volume:.7 pitch:1 pan:-1 loop:false];
    CCLOG(@"L B");
}

@end
