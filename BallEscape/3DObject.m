//
//  3DObject.m
//  BallEscape
//
//  Created by Alberto Salido López on 04/11/12.
//  Copyright (c) 2012 Alberto Salido López. All rights reserved.
//

#import "3DObject.h"

@implementation threeDObject

@synthesize model = _model;
@synthesize position = _position;

- (id)initWithModel:(UtilityModel *)model position:(GLKVector3)position
{
    if ((self = [super init]) != nil) {
        self.model = model;
        self.position = position;
    }
    
    return self;
}

@end
