//
//  Wall.m
//  BallEscape
//
//  Created by Alberto Salido López on 04/11/12.
//  Copyright (c) 2012 Alberto Salido López. All rights reserved.
//

#import "Wall.h"

@implementation Wall

@synthesize shouldRotate = _shouldRotate;

- (id)initWithModel:(UtilityModel *)model 
           position:(GLKVector3)position 
       shouldRotate:(BOOL)rotate
{
    if ((self = [super initWithModel:model position:position]) != nil) {
        self.shouldRotate = rotate;
    }
    return self;
}

@end
