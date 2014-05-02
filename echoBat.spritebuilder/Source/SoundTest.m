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
BOOL loaded = false;


- (void)didLoadFromCCB {
    if (!loaded) {
        // access audio object
        OALSimpleAudio *audio = [OALSimpleAudio sharedInstance];
        // play background sound
        [audio playBg:@"Published-iOS/echo_sounds/crickets.caf" loop:TRUE];
        player = [SoundPlayer initNew];
        loaded = true;
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
    [player pulseOut];
    //    CCScene *gameScene = [CCBReader loadAsScene:@"MainScene"];
    //    [[CCDirector sharedDirector] replaceScene:mainScene];
}

@end
