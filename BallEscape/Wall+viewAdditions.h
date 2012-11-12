//
//  Wall+viewAdditions.h
//  BallEscape
//
//  Created by Alberto Salido López on 12/11/12.
//  Copyright (c) 2012 Alberto Salido López. All rights reserved.
//

#import "Wall.h"

//  Category that allows the walls object to be drawn.
//
@interface Wall (viewAdditions)

//  Draws a Wall.
- (void)drawWithBaseEffect:(GLKBaseEffect *)baseEffect;

@end
