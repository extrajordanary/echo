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
    NSArray *soundFiles;
    NSArray *soundNames;
    NSDictionary *soundEffects;

}

- (id)init {
    self = [super init];

    if (self) {
        // initialize instance variables here
        
        //create audio player and preload sound effects
        player = [OALSimpleAudio sharedInstance];
        
        soundFiles = @[@"Published-iOS/echo_sounds/chirpLeft.caf",
                        @"Published-iOS/echo_sounds/chirpLeftBehind.caf",
                        @"Published-iOS/echo_sounds/chirpRight.caf",
                        @"Published-iOS/echo_sounds/chirpRightBehind.caf",
                        @"Published-iOS/echo_sounds/gameOver.caf",
                        @"Published-iOS/echo_sounds/pulseOut.caf",
                        @"Published-iOS/echo_sounds/scored3.caf",
                        @"Published-iOS/echo_sounds/crickets.caf"];

        for (NSString *string in soundFiles) {
            [player preloadEffect:string];
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
        
        
        // finished initializing
        CCLOG(@"init");
    }
    return self;
}

- (void)didLoadFromCCB {
    // play background sound
    player.bgVolume = 0.2f;
    [player playBg:soundEffects[@"crickets"] loop:TRUE];

    CCLOG(@"loaded FromCCB");
}

@end
