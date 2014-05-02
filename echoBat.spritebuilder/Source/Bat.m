//
//  Bat.m
//  EchoBat
//
//  Created by Jordan on 52/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "Bat.h"

@implementation Bat


// *** class methods

+ (Bat*) withX:(int)ix Y:(int)iy size:(int)iz ears:(float)ie direction:(float)angle speed:(float)is pred:(BOOL)p
{
    return [[Bat alloc] initWithX:ix Y:iy size:iz ears:ie direction:angle speed:is pred:p];
}

// *** instance methods

- (void) turn:(int)angle
{
    dir = fmodf((dir+angle), 360);
}

- (void) accelerate:(float)change
{
    speed = max(speed + change, .4f);
    ears = 60/speed;
}

- (void) update
{
    velocity = [Vector2D mult:[Vector2D fromAngle:dir] with:speed];
    position = [Vector2D add:position to:velocity];
    rightEar->x = position->x - (ears*velocity->y);
    rightEar->y = position->y + (ears*velocity->x);
    leftEar->x = position->x + (ears*velocity->y);
    leftEar->y = position->y - (ears*velocity->x);
}

- (void) newLoc  //TODO: possibly adjust to ensure minimum distance away from old tgt loc
{
    position->x += (arc4random() % 200) - 100;
    position->y += (arc4random() % 200) - 100;
    [self update];
}


// *** init method

- (Bat*) init
{
    self = [self initWithX:0 Y:0 size:1 ears:1 direction:1 speed:1 pred:false];
    return self;
}

- (Bat*) initWithX:(int)ix Y:(int)iy size:(int)iz ears:(float)ie direction:(float)angle speed:(float)is pred:(BOOL)p
{
    self = [super init];
    if(self != nil)
    {
        size = iz;
        dir = angle;
        speed = is;
        ears = ie/speed;
        predator = p;
        
        position = [Vector2D withX:ix Y:iy];

        velocity = [Vector2D mult:[Vector2D fromAngle:dir] with:speed];
        
        rightEar = [Vector2D withX:(position->x - (ears*velocity->y)) Y:(position->y + (ears*velocity->x))];
        
        leftEar = [Vector2D withX:(position->x + (ears*velocity->y)) Y:(position->y - (ears*velocity->x))];
        
    }
    return self;
}

@end
