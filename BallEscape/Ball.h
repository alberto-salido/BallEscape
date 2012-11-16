//
//  Ball.h
//  BallEscape
//
//  Created by Alberto Salido López on 08/11/12.
//  Copyright (c) 2012 Alberto Salido López. All rights reserved.
//

#import "3DObject.h"
#import "ObjectController.h"
#import "Wall.h"

//  The main character in the game.
//  Represents a Ball. This ball extends the interface |threeDObject| adding
//  a couple of properties; one for the velocity and another for the raidus.
//  The ball also implements the |AbstractDraw| and |ObjectController| for 
//  drawing it and control his movement and the posibles collision with
//  the enviroment. The second protocol is implemented using the method
//  updateWithController.
//
@interface Ball : threeDObject

//  Ball's velocity.
@property (nonatomic, readonly) GLKVector3 velocity;

//  Ball's radius.
@property (nonatomic, readonly) GLfloat radius;

//  Creates a new instance for this object.
- (id)initWithModel:(UtilityModel *)model
           position:(GLKVector3)position 
           velocity:(GLKVector3)velocity;

//  Updates the position and velocity of the receiver
//  to simulate effects of collision with walls.
//  The method returns YES if the ball has touched the door.
- (BOOL)updateWithController:(id <ObjectController>)controller;

@end
