//
//  SoundWave.m
//  echoBat
//
//  Created by Jordan on 5/2/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "SoundWave.h"

@implementation SoundWave


// class methods

+ (SoundWave*) withX:(float)nx Y:(float)ny speed:(float)nspeed
{
    return [[SoundWave alloc] initWithX:nx Y:ny speed:nspeed];
}

// instance methods
- (SoundWave*) init
{
    self = [self initWithX:0.0f Y:0.0f speed:0.0f];
    return self;
}

- (SoundWave*) initWithX:(float)nx Y:(float)ny speed:(float)nspeed
{
    self = [super init];
    if(nil != self)
    {
//        x = nx;
//        y = ny;
        position = [Vector2D withX:nx Y:ny];
        speed = nspeed;
        radius = 0.0f;
    }
    return self;
}

- (void) update
{
    radius += speed;
}

@end
