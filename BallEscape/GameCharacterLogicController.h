//
//  GameCharacterLogicController.h
//  BallEscape
//
//  Created by Alberto Salido López on 27/11/12.
//  Copyright (c) 2012 Alberto Salido López. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ObjectController.h"

//  This class is used for updating the values of any object into the game.
//
@protocol GameCharacterLogicController <NSObject>

//  Updates the position and velocity of the receiver
//  to simulate effects of collision with walls and other elements
//  into the game. The method retuns a boolean, indicating if the 
//  game character has completed its propose in the game.
//  I.e: For this game, if the ball has escaped or if the ghost has
//  caught him.
- (BOOL)updateWithController:(id <ObjectController>)controller;

@end
