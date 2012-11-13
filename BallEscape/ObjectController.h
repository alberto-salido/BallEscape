//
//  ObjectController.h
//  BallEscape
//
//  Created by Alberto Salido López on 08/11/12.
//  Copyright (c) 2012 Alberto Salido López. All rights reserved.
//

#import <Foundation/Foundation.h>

//  Protocol for simulating the movement of the objects.
//  The class which use this protocol, has to implement the 
//  following methods. This functions gives to the object, which
//  movement is going to be update, the information needed about
//  the enviroment.
@protocol ObjectController <NSObject>

- (NSTimeInterval)timeSinceLastUpdate;

//  Position of the borders. Used for collision.
- (AGLKAxisAllignedBoundingBox)borders;

//  Set with the position of the labyrinth's walls.
- (NSSet *)labyrinth;

//  Array with the position of the monsters.
//  At first, is only one monster, but in futures implementations
//  should have more.
//- (NSArray *)monsters;

//  Gets the slope of the boardgame.
- (float)getXSlope;
- (float)getZSlope;

@end