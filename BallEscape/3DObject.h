//
//  3DObject.h
//  BallEscape
//
//  Created by Alberto Salido López on 04/11/12.
//  Copyright (c) 2012 Alberto Salido López. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UtilityModel.h"
#import "AGLKAxisAllignedBoundingBox.h"
#import "UtilityModel+viewAdditions.h"

//  A simple 3DObject. It has two properties, the |UtilityModel|
//  with the mesh and the information about him; and the position
//  into the space.
//
@interface threeDObject : NSObject

//  Object's model.
@property (nonatomic, readonly, strong) UtilityModel *model;

//  Obejct's position.
@property (readonly) GLKVector3 position;


//  Initializes the object with a model and a position.
- (id)initWithModel:(UtilityModel *)model position:(GLKVector3)position;

@end


//  Protocol for drawing the scene using a base effect.
@protocol AbstractDraw <NSObject>

//  Draw the object model in the position set, using a 
//  base effect property.
- (void)drawWithBaseEffect:(GLKBaseEffect *)baseEffect;

@end
