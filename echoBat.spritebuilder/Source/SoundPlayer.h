//
//  SoundPlayer.h
//  echoBat
//
//  Created by Jordan on 4/30/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "CCNode.h"

@interface SoundPlayer : CCNode
{
@public
    
    
@private
    AVAudioPlayer *echoRight;
    AVAudioPlayer *echoRightB;
    AVAudioPlayer *echoLeft;
    AVAudioPlayer *echoLeftB;
    AVAudioPlayer *pulseOut;
    AVAudioPlayer *scored;
    AVAudioPlayer *gameOver;
}

+(SoundPlayer*) initNew;

-(void) echoRight;
-(void) echoRightB;
-(void) echoLeft;
-(void) echoLeftB;
-(void) pulseOut;
-(void) scored;
-(void) gameOver;


@end
