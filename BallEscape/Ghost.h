//
//  Ghost.h
//  BallEscape
//
//  Created by Alberto Salido López on 28/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "GameCharacter.h"
#import "GameCharacterLogicController.h"
#import "Ball.h"

@interface Ghost : GameCharacter <GameCharacterLogicController>

@property (nonatomic, readonly, strong) UtilityModel *model;
@property (nonatomic, readonly) GLKVector3 position;
@property (nonatomic, readonly) GLKVector3 velocity;
@property (nonatomic) BOOL shouldPassThrowTheWalls;

- (id)initWithModel:(UtilityModel *)model 
           position:(GLKVector3)position 
           velocity:(GLKVector3)velocity
         yawRadians:(float)radians
         throwWalls:(BOOL)throwWalls;

@end
