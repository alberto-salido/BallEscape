//
//  Wall.h
//  BallEscape
//
//  Created by Alberto Salido López on 04/11/12.
//  Copyright (c) 2012 Alberto Salido López. All rights reserved.
//

#import "3DObject.h"

@interface Wall : threeDObject <abstractDraw>

//  The model must be rotated over the Y Axis.
@property BOOL shouldRotate;

- (id)initWithModel:(UtilityModel *)model 
           position:(GLKVector3)position 
       shouldRotate:(BOOL)rotate;

@end
