//
//  SoundTest.m
//  echoBat
//
//  Created by Jordan on 4/30/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "SoundTest.h"
#import "MainScene.h"
#import "SoundPlayer.h"
#include <AVFoundation/AVFoundation.h>

@implementation SoundTest {
    
}

SoundPlayer* player;
OALSimpleAudio *audio1;
BOOL loadedZ = false;


- (void)didLoadFromCCB {
    if (!loadedZ) {
        // access audio object
        audio1 = [OALSimpleAudio sharedInstance];
        // play background sound
        [audio1 playBg:@"Published-iOS/echo_sounds/scored2.caf" loop:TRUE];
        player = [SoundPlayer initNew];
        loadedZ = true;
    }
}

-(void) _home {
    CCLOG(@"go home");
    [player gameOver];
    CCScene *mainScene = [CCBReader loadAsScene:@"MainScene"];
    [[CCDirector sharedDirector] replaceScene:mainScene];
}

-(void) _cont {
    CCLOG(@"continue");
    [player scored];
    //    CCScene *gameScene = [CCBReader loadAsScene:@"MainScene"];
    //    [[CCDirector sharedDirector] replaceScene:mainScene];
}

-(void) _pulse {
    CCLOG(@"pulse out");
    [audio1 playEffect:@"Published-iOS/echo_sounds/pulseOut.caf"];
//    [player pulseOut];
    //    CCScene *gameScene = [CCBReader loadAsScene:@"MainScene"];
    //    [[CCDirector sharedDirector] replaceScene:mainScene];
}

@end
