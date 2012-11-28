//
//  Ball.h
//  BallEscape
//
//  Created by Alberto Salido López on 08/11/12.
//  Copyright (c) 2012 Alberto Salido López. All rights reserved.
//

#import "GameCharacter.h"
#import "ObjectController.h"
#import "GameCharacterLogicController.h"

//  The main character in the game.
//  Represents a Ball. This ball extends the interface |threeDObject| adding
//  a couple of properties; one for the velocity and another for the raidus.
//
@interface Ball : GameCharacter <GameCharacterLogicController>

@property (readonly, nonatomic, strong) UtilityModel *model;
@property (readonly, nonatomic) GLKVector3 position;
@property (readonly, nonatomic) GLKVector3 velocity;
@property (readonly, nonatomic) float yawRadians;

- (id)initWithModel:(UtilityModel *)model 
           position:(GLKVector3)position 
           velocity:(GLKVector3)velocity
         yawRadians:(float)radians;

@end
