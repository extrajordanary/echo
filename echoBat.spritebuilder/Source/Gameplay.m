//
//  Gameplay.m
//  echoBat
//
//  Created by Jordan on 5/2/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "Gameplay.h"

@implementation Gameplay

OALSimpleAudio *audio1;
//int loadCount2 = 0;
//BOOL initialized1 = false;
//
//- (void)onEnter {
//    
//    if (!initialized1) {
//        loadCount2 += 1;
//        // access audio object
//        audio1 = [OALSimpleAudio sharedInstance];
//        // play background sound
//        [audio1 playBg:@"Published-iOS/echo_sounds/crickets.caf" loop:TRUE];
//        initialized1 = true;
//    }
//    CCLOG(@"%i",loadCount2);
//    
//}
//{
//    OALSimpleAudio *audio;
//
//}
//
BOOL loaded2 = false;

- (id)init {
    self = [super init];

    if (self) {
        // initialize instance variables here
        // access audio object
        // play background sound
//        [audio playBg:@"Published-iOS/echo_sounds/crickets.caf" loop:TRUE];

//        loaded2 = true;
        CCLOG(@"init");

    }

    return self;
}

- (void)didLoadFromCCB {
    audio1 = [OALSimpleAudio sharedInstance];

    if (loaded2) {
        // access audio object
//        OALSimpleAudio *audio = [OALSimpleAudio sharedInstance];
        // play background sound
        [audio1 playBg:@"Published-iOS/echo_sounds/crickets.caf" loop:TRUE];
        CCLOG(@"didLoadFromCCB true");

//        loaded = true;
    }
    else //[audio playEffect:@"echo_sounds/scored.wav"];
    [audio1 playBg:@"Published-iOS/echo_sounds/scored2.caf" loop:TRUE];

    CCLOG(@"loaded FromCCB");


}

@end
