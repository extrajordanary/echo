//
//  Pulse.h
//  EchoBat
//
//  Created by Jordan on 4/16/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Vector2D.h"


@interface Pulse : NSObject
{
@public
    float x;
    float y;
    float radius;
    float speed;
    Vector2D *position;
}

// class methods
+ (Pulse*) withX:(float)x Y:(float)y speed:(float)speed;


// instance methods
- (Pulse*) initWithX:(float)x Y:(float)y speed:(float)speed;

- (void) update;


@end
