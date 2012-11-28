//
//  Ghost+viewAdditions.h
//  BallEscape
//
//  Created by Alberto Salido López on 28/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Ghost.h"

@interface Ghost (viewAdditions)

//  Draws the ball using the base effect.
- (void)drawWithBaseEffect:(GLKBaseEffect *)baseEffect;

@end
