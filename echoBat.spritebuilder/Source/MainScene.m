//
//  MainScene.m
//  PROJECTNAME
//
//  Created by Viktor on 10/10/13.
//  Copyright (c) 2013 Apportable. All rights reserved.
//

#import "MainScene.h"

@implementation MainScene

//SoundPlayer* player1;
//BOOL loaded = false;
//
//
//- (void)didLoadFromCCB {
//    if (!loaded) {
//        player1 = [SoundPlayer initNew];
//        loaded = true;
//    }
//}

-(void) enterGame {
    CCLOG(@"enter the game");
//    [player1 echoLeft];
    CCScene *testScene = [CCBReader loadAsScene:@"SoundTest"];
    [[CCDirector sharedDirector] replaceScene:testScene];
}


@end
