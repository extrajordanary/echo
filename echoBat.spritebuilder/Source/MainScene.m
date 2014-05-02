//
//  MainScene.m
//  PROJECTNAME
//
//  Created by Viktor on 10/10/13.
//  Copyright (c) 2013 Apportable. All rights reserved.
//

#import "MainScene.h"

@implementation MainScene

OALSimpleAudio *audio;
int loadCount = 0;
BOOL initialized = false;

- (void)didLoadFromCCB {

    if (!initialized) {
    loadCount += 1;
        // access audio object
        audio = [OALSimpleAudio sharedInstance];
        // play background sound
//        [audio playBg:@"Published-iOS/echo_sounds/crickets.caf" loop:TRUE];
        initialized = true;
    }
    CCLOG(@"%i",loadCount);

}

-(void) enterGame {
    CCLOG(@"enter the game");
    CCScene *gameScene = [CCBReader loadAsScene:@"Gameplay"];
    [[CCDirector sharedDirector] replaceScene:gameScene];
    
//    CCScene *testScene = [CCBReader loadAsScene:@"SoundTest"];
//    [[CCDirector sharedDirector] replaceScene:testScene];
}




@end
