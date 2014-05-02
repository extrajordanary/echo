//
//  MainScene.m
//  PROJECTNAME
//
//  Created by Viktor on 10/10/13.
//  Copyright (c) 2013 Apportable. All rights reserved.
//

#import "MainScene.h"

@implementation MainScene


-(void) enterGame {
    CCLOG(@"enter the game");
    CCScene *gameScene = [CCBReader loadAsScene:@"Gameplay"];
    [[CCDirector sharedDirector] replaceScene:gameScene];
    
//    CCScene *testScene = [CCBReader loadAsScene:@"SoundTest"];
//    [[CCDirector sharedDirector] replaceScene:testScene];
}




@end
