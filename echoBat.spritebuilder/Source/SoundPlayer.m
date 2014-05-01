//
//  SoundPlayer.m
//  echoBat
//
//  Created by Jordan on 4/30/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "SoundPlayer.h"
#include <AVFoundation/AVFoundation.h>

@implementation SoundPlayer

+(SoundPlayer*)initNew {
    return [[SoundPlayer alloc] init];
}

-(SoundPlayer*)init
    {
        self = [super init];
        if(self != nil)
        {
            // load audio files
            //~/Resources/Published-iOS/echo_sounds
            NSString *soundFilePath =
            [[NSBundle mainBundle] pathForResource: @"Published-iOS/echo_sounds/chirpRight"
                                            ofType: @"caf"];
            NSURL *fileURL = [[NSURL alloc] initFileURLWithPath: soundFilePath];
            echoRight = [[AVAudioPlayer alloc] initWithContentsOfURL: fileURL
                                                               error: nil];
            
            soundFilePath =
            [[NSBundle mainBundle] pathForResource: @"Published-iOS/echo_sounds/chirpRightBehind"
                                            ofType: @"caf"];
            fileURL = [[NSURL alloc] initFileURLWithPath: soundFilePath];
            echoRightB = [[AVAudioPlayer alloc] initWithContentsOfURL: fileURL
                                                                error: nil];
            
            soundFilePath =
            [[NSBundle mainBundle] pathForResource: @"Published-iOS/echo_sounds/chirpLeft"
                                            ofType: @"caf"];
            fileURL = [[NSURL alloc] initFileURLWithPath: soundFilePath];
            echoLeft = [[AVAudioPlayer alloc] initWithContentsOfURL: fileURL
                                                              error: nil];
            
            soundFilePath =
            [[NSBundle mainBundle] pathForResource: @"Published-iOS/echo_sounds/chirpLeftBehind"
                                            ofType: @"caf"];
            fileURL = [[NSURL alloc] initFileURLWithPath: soundFilePath];
            echoLeftB = [[AVAudioPlayer alloc] initWithContentsOfURL: fileURL
                                                               error: nil];
            
            soundFilePath =
            [[NSBundle mainBundle] pathForResource: @"Published-iOS/echo_sounds/pulseOut"
                                            ofType: @"caf"];
            fileURL = [[NSURL alloc] initFileURLWithPath: soundFilePath];
            pulseOut = [[AVAudioPlayer alloc] initWithContentsOfURL: fileURL
                                                              error: nil];
            
            soundFilePath =
            [[NSBundle mainBundle] pathForResource: @"Published-iOS/echo_sounds/scored2"
                                            ofType: @"caf"];
            fileURL = [[NSURL alloc] initFileURLWithPath: soundFilePath];
            scored = [[AVAudioPlayer alloc] initWithContentsOfURL: fileURL
                                                            error: nil];
            
            soundFilePath =
            [[NSBundle mainBundle] pathForResource: @"Published-iOS/echo_sounds/gameOver"
                                            ofType: @"caf"];
            fileURL = [[NSURL alloc] initFileURLWithPath: soundFilePath];
            gameOver = [[AVAudioPlayer alloc] initWithContentsOfURL: fileURL
                                                              error: nil];
            
  
        }
        return self;
    }
    

    //        pulseOut = newPlayer;
    //        [fileURL release];
    //        [newPlayer release];
    




-(void) echoRight {
    [echoRight play];
}

-(void) echoRightB {
    [echoRightB play];
}

-(void) echoLeft {
    [echoLeft play];
}

-(void) echoLeftB {
    [echoLeftB play];
}

-(void) pulseOut {
    [pulseOut play];
}

-(void) scored {
    [scored play];
}

-(void) gameOver {
    [gameOver play];
}

@end
