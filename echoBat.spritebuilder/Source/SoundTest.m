//
//  SoundTest.m
//  echoBat
//
//  Created by Jordan on 4/30/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "SoundTest.h"
#import "SoundPlayer.h"
#include <AVFoundation/AVFoundation.h>

@implementation SoundTest {
    
}

SoundPlayer* player;
BOOL loaded = false;

//AVAudioPlayer *echoRight;
//AVAudioPlayer *echoRightB;
//AVAudioPlayer *echoLeft;
//AVAudioPlayer *echoLeftB;
//AVAudioPlayer *pulseOut;
//AVAudioPlayer *scored;
//AVAudioPlayer *gameOver;



- (void)didLoadFromCCB {
    if (!loaded) {
        player = [SoundPlayer initNew];
        loaded = true;
    }
    
    // load audio files
    //~/Resources/Published-iOS/echo_sounds
//    NSString *soundFilePath =
//    [[NSBundle mainBundle] pathForResource: @"Published-iOS/echo_sounds/chirpRight"
//                                        ofType: @"caf"];
//    NSURL *fileURL = [[NSURL alloc] initFileURLWithPath: soundFilePath];
//    echoRight = [[AVAudioPlayer alloc] initWithContentsOfURL: fileURL
//                                                      error: nil];
//    
//    soundFilePath =
//    [[NSBundle mainBundle] pathForResource: @"Published-iOS/echo_sounds/chirpRightBehind"
//                                    ofType: @"caf"];
//    fileURL = [[NSURL alloc] initFileURLWithPath: soundFilePath];
//    echoRightB = [[AVAudioPlayer alloc] initWithContentsOfURL: fileURL
//                                                       error: nil];
//
//    soundFilePath =
//    [[NSBundle mainBundle] pathForResource: @"Published-iOS/echo_sounds/chirpLeft"
//                                    ofType: @"caf"];
//    fileURL = [[NSURL alloc] initFileURLWithPath: soundFilePath];
//    echoLeft = [[AVAudioPlayer alloc] initWithContentsOfURL: fileURL
//                                                      error: nil];
//  
//    soundFilePath =
//    [[NSBundle mainBundle] pathForResource: @"Published-iOS/echo_sounds/chirpLeftBehind"
//                                    ofType: @"caf"];
//    fileURL = [[NSURL alloc] initFileURLWithPath: soundFilePath];
//    echoLeftB = [[AVAudioPlayer alloc] initWithContentsOfURL: fileURL
//                                                      error: nil];
//    
//    soundFilePath =
//    [[NSBundle mainBundle] pathForResource: @"Published-iOS/echo_sounds/pulseOut"
//                                    ofType: @"caf"];
//    fileURL = [[NSURL alloc] initFileURLWithPath: soundFilePath];
//    pulseOut = [[AVAudioPlayer alloc] initWithContentsOfURL: fileURL
//                                                      error: nil];
//    
//    soundFilePath =
//    [[NSBundle mainBundle] pathForResource: @"Published-iOS/echo_sounds/scored2"
//                                    ofType: @"caf"];
//    fileURL = [[NSURL alloc] initFileURLWithPath: soundFilePath];
//    scored = [[AVAudioPlayer alloc] initWithContentsOfURL: fileURL
//                                                      error: nil];
//    
//    soundFilePath =
//    [[NSBundle mainBundle] pathForResource: @"Published-iOS/echo_sounds/gameOver"
//                                    ofType: @"caf"];
//    fileURL = [[NSURL alloc] initFileURLWithPath: soundFilePath];
//    gameOver = [[AVAudioPlayer alloc] initWithContentsOfURL: fileURL
//                                                      error: nil];
//    
    
//        pulseOut = newPlayer;
//        [fileURL release];
//        [newPlayer release];
    
}

//-(void) echoRight {
//    [echoRight play];
//}
//
//-(void) echoRightB {
//    [echoRightB play];
//}
//
//-(void) echoLeft {
//    [echoLeft play];
//}
//
//-(void) echoLeftB {
//    [echoLeftB play];
//}
//
//-(void) pulseOut {
//    [pulseOut play];
//}
//
//-(void) scored {
//    [scored play];
//}
//
//-(void) gameOver {
//    [gameOver play];
//}

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
