//
//  Bat.h
//  EchoBat
//
//  Created by Jordan on 5/2/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Vector2D.h"

@interface Bat : NSObject
{
@public
    Vector2D *position;
    int size; // radius of size of bat
    
    
//@private
    Vector2D *rightEar;
    Vector2D *leftEar;
    Vector2D *velocity;
    
    float ears; // half distance between ears (affects difficulty)
    float dir; // direction of flight (in degrees)
    float speed; // speed of bat
    
    bool predator; // is bat in chase and catch mode? else evade mode
    
}

// class methods
+ (Bat*) withX:(int)ix Y:(int)iy size:(int)iz ears:(float)ie direction:(float)angle speed:(float)is pred:(BOOL)p;

// instance methods
- (Bat*) initWithX:(int)ix Y:(int)iy size:(int)iz ears:(float)ie direction:(float)angle speed:(float)is pred:(BOOL)p;

- (void) update;

- (void) newLoc;

- (void) accelerate:(float)change;

- (void) turn:(int)angle;


@end
