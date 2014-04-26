//
//  MainScene.m
//  EchoBat
//
//  Created by Jordan on 4/12/14.
//  Created by Viktor on 10/10/13.
//  Copyright (c) 2013 Apportable. All rights reserved.
//

#import "MainScene.h"

@implementation MainScene

//- (void)play {
//    CCLOG(@"play button pressed");
//}

- (void)play {
    CCLOG(@"play button pressed");
    CCScene *gameplayScene = [CCBReader loadAsScene:@"Gameplay"];
    [[CCDirector sharedDirector] replaceScene:gameplayScene];
}

@end
