//
//  GameCharacter.h
//  BallEscape
//
//  Created by Alberto Salido López on 27/11/12.
//  Copyright (c) 2012 Alberto Salido López. All rights reserved.
//

#import "3DObject.h"
#import "Wall.h"

//  This class represent an "inteligent" object into the game.
//  This kind of game character have personality, provided by the user,
//  throw the dispositive, or by the computer using a small Artifitial
//  Intelligence.
//
@interface GameCharacter : threeDObject

@property (nonatomic, readonly) GLKVector3 velocity;

@property (nonatomic, readonly) GLfloat radius;

@property (nonatomic, readonly) GLfloat yawRadians;

//  Creates a new instance for this object.
- (id)initWithModel:(UtilityModel *)model 
           position:(GLKVector3)position 
           velocity:(GLKVector3)velocity;

//  This function checks if the object has collisioned
//  with the borders of the board-game. The collisions
//  bounce of the object from the borders.
- (void)bounceOffBorders:(AGLKAxisAllignedBoundingBox)borders;

//  This method detects any collision between the object
//  and the labyrinth's walls.
//  Returns true is the object has completed his propose.
- (BOOL)bounceOffWalls:(NSDictionary *)walls;

@end
