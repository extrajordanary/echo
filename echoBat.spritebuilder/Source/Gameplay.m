//
//  Gameplay.m
//  echoBat
//
//  Created by Jordan on 5/2/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "Gameplay.h"

@implementation Gameplay {

OALSimpleAudio *player;

}

- (id)init {
    self = [super init];

    if (self) {
        // initialize instance variables here
        
        //create audio player
        player = [OALSimpleAudio sharedInstance];

        // finished initializing
        CCLOG(@"init");
    }
    return self;
}

- (void)didLoadFromCCB {
    // play background sound
    player.bgVolume = 0.2f;
    [player playBg:@"Published-iOS/echo_sounds/crickets.caf" loop:TRUE];

    CCLOG(@"loaded FromCCB");
}

@end
