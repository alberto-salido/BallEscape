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
@synthesize boundingBox = _boundingBox;
@synthesize isADoor = _isADoor;

- (id)initWithModel:(UtilityModel *)model 
           position:(GLKVector3)position 
       shouldRotate:(BOOL)rotate
{
    if ((self = [super initWithModel:model position:position]) != nil) {
        
        AGLKAxisAllignedBoundingBox oldBoundingBox = model.axisAlignedBoundingBox;
        AGLKAxisAllignedBoundingBox newBoundingBox;
        
        GLKVector3 newMax;
        GLKVector3 newMin;
        
        //  Rotates the B.Box.
        if ((self.shouldRotate = rotate)) {
            newMax = GLKVector3Make(oldBoundingBox.max.z,
                                    oldBoundingBox.max.y,
                                    oldBoundingBox.max.x);
            newMin = GLKVector3Make(oldBoundingBox.min.z,
                                    oldBoundingBox.min.y,
                                    oldBoundingBox.min.x);
        } else {
            newMax = GLKVector3Make(oldBoundingBox.max.x,
                                    oldBoundingBox.max.y,
                                    oldBoundingBox.max.z);
            newMin = GLKVector3Make(oldBoundingBox.min.x,
                                    oldBoundingBox.min.y,
                                    oldBoundingBox.min.z);
        }
        
        newBoundingBox.min = newMin;
        newBoundingBox.max = newMax;
        
        //  Stores the B.Box into the property.
        self.boundingBox = newBoundingBox;
    }
    return self;
}

@end
