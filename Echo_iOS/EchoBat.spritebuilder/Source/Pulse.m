//
//  Pulse.m
//  EchoBat
//
//  Created by Jordan on 4/16/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "Pulse.h"

@implementation Pulse


// class methods

+ (Pulse*) withX:(float)nx Y:(float)ny speed:(float)nspeed
{
    return [[Pulse alloc] initWithX:nx Y:ny speed:nspeed];
}

// instance methods
- (Pulse*) init
{
    self = [self initWithX:0.0f Y:0.0f speed:0.0f];
    return self;
}

- (Pulse*) initWithX:(float)nx Y:(float)ny speed:(float)nspeed
{
    self = [super init];
    if(nil != self)
    {
        x = nx;
        y = ny;
        position = [Vector2D withX:x Y:y];
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
