//
//  Ball+viewAdditions.h
//  BallEscape
//
//  Created by Alberto Salido López on 12/11/12.
//  Copyright (c) 2012 Albeto Saido López. All rights reserved.
//

#import "Ball.h"

//  Category used for drawing the Ball object.
//
@interface Ball (viewAdditions)

//  Draws the ball using the base effect.
- (void)drawWithBaseEffect:(GLKBaseEffect *)baseEffect;

@end
