//
//  Wall.h
//  BallEscape
//
//  Created by Alberto Salido López on 04/11/12.
//  Copyright (c) 2012 Alberto Salido López. All rights reserved.
//

#import "3DObject.h"

//  A Wall in the labyrinth. It extends from |threeDObject|.
//  Every wall has a property |shouldRotate| that indicates if the
//  object has to be rotated 90º.
//
@interface Wall : threeDObject

//  The model must be rotated over the Y Axis.
@property BOOL shouldRotate;

//  Indicates if the Wall is also a Door.
@property BOOL isADoor;

//  The model's bounding box is different is the object is
//  rotated or not. In this case, is needed a property for
//  storing it with modifying the main model's boundig box.
@property AGLKAxisAllignedBoundingBox boundingBox;

//  Initializes the object with a model, a position and a rotation.
- (id)initWithModel:(UtilityModel *)model 
           position:(GLKVector3)position 
       shouldRotate:(BOOL)rotate;

@end
