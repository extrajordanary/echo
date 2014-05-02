//
//  Bat.m
//  EchoBat
//
//  Created by Jordan on 4/13/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "Bat.h"
//@class Pulse
#import "Pulse.h"
//#import "Gameplay.m"

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
//    velocity = [Vector2D fromAngle:dir];
//    velocity = [Vector2D mult:[Vector2D fromAngle:dir] with:speed];
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

//- (void) caught:(Bat*)other
//{
//    float dist = [Vector2D distanceFrom:position to:other->position];
//    if (dist < (size + other->size)) {
//        score += 1;
//        caught = 100;
//        //scored.trigger() //TODO:
//        [other newLoc];
//    }
//}

- (void) newLoc  //TODO: possibly adjust to ensure minimum distance away from old tgt loc
{
    position->x += (arc4random() % 200) - 100;
    position->y += (arc4random() % 200) - 100;
    [self update];
}

//- (void) pulse
//{
//    pulse = [Pulse withX:position->x Y:position->y speed:pulseSpeed];
//    //pulseOut.trigger() //TODO:
//    bounced = false;
//}
//
//- (void) echo:(Pulse*)p
//{
//    if (!predator) {
//        float dist = [Vector2D distanceFrom:position to:p->position];
//        if (p->radius > dist && !bounced) {
//            echo = [Pulse withX:position->x Y:position->y speed:pulseSpeed];
//            bounced = true;
//            heardR = false;
//            heardL = false;
//        }
//    } else {
//        Vector2D *ang = [Vector2D withX:(p->x - position->x) Y:(p->y - position->y)];
//        int ab = [Vector2D angleBetween:ang and:velocity];
//        
//        float dR = [Vector2D distanceFrom:rightEar to:p->position];
//        float dL = [Vector2D distanceFrom:leftEar to:p->position];
//        
//        if (p->radius > dR && !heardR) {
//            if (ab > 120) {
//                //echoRightB.trigger() //TODO:
//            } else {
//                //echoRight.trigger() //TODO:
//            }
//            heardR = true;
//        }
//        if (p->radius > dL && !heardL) {
//            if (ab > 120) {
//                //echoLeftB.trigger() //TODO:
//            } else {
//                //echoLeft.trigger() //TODO:
//            }
//            heardL = true;
//        }
//    }
//}

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
        
//        position = new PVector(ix, iy);
        position = [Vector2D withX:ix Y:iy];
        
//        velocity = PVector.fromAngle(radians(dir));
//        velocity.mult(speed);
//        velocity = [Vector2D fromAngle:dir];
        velocity = [Vector2D mult:[Vector2D fromAngle:dir] with:speed];
        
//        rightEar = new PVector(position.x-(ears*velocity.y), position.y+(ears*velocity.x));
        rightEar = [Vector2D withX:(position->x - (ears*velocity->y)) Y:(position->y + (ears*velocity->x))];
        
//        leftEar = new PVector(position.x+(ears*velocity.y), position.y-(ears*velocity.x));
        leftEar = [Vector2D withX:(position->x + (ears*velocity->y)) Y:(position->y - (ears*velocity->x))];

        
//        score = 0;
        
    }
    return self;
}

@end
