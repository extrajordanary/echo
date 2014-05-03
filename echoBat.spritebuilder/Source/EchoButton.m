//
//  EchoButton.m
//  echoBat
//
//  Created by Jordan on 5/3/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "EchoButton.h"

@implementation EchoButton

- (void)echoButtonAnimation
{
    // the animation manager of each node is stored in the 'userObject' property
    CCBAnimationManager* animationManager = self.userObject;
    // timelines can be referenced and run by name
    [animationManager runAnimationsForSequenceNamed:@"echoButton"];
}

@end
