//
//  BoardGame+viewAdditions.h
//  BallEscape
//
//  Created by Alberto Salido López on 12/11/12.
//  Copyright (c) 2012 Alberto Salido López. All rights reserved.
//

#import "BoardGame.h"

//  Category used for drawing the boardgame.
//
@interface BoardGame (viewAdditions)

//  Draw the current object using the provided base effect.
- (void)drawWithBaseEffect:(GLKBaseEffect *)baseEffect;

@end
