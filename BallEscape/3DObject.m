//
//  3DObject.m
//  BallEscape
//
//  Created by Alberto Salido López on 04/11/12.
//  Copyright (c) 2012 Alberto Salido López. All rights reserved.
//

#import "3DObject.h"

//  Private interface, used for changing the visibility of the
//  properties. The properties in the publi API are |readonly|
//  but in the implementation class are |readwrite|.
//
@interface threeDObject ()

@property (nonatomic, strong) UtilityModel *model;
@property GLKVector3 position;

@end


@implementation threeDObject

@synthesize model = _model;
@synthesize position = _position;


//  Default initializer. Must be override from the super class.
//  Returns an Assertion.
- (id)init
{
    NSAssert(NO, @"Invalid initializer");
    return nil;
}

- (id)initWithModel:(UtilityModel *)model position:(GLKVector3)position
{
    if ((self = [super init]) != nil) {
        self.model = model;
        self.position = position;
    }
    return self;
}

@end