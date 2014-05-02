//
//  SoundWave.h
//  echoBat
//
//  Created by Jordan on 5/2/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Vector2D.h"

@interface SoundWave : NSObject
{
@public
    float x;
    float y;
    float radius;
    float speed;
    Vector2D *position;
}

// class methods
+ (SoundWave*) withX:(float)x Y:(float)y speed:(float)speed;


// instance methods
- (SoundWave*) initWithX:(float)x Y:(float)y speed:(float)speed;

- (void) update;
@end
