//
//  UtilityModel+viewAdditions.h
//  BallEscape
//
//  Created by Alberto Salido López on 29/10/12.
//  References Learning OpenGL ES for iOS, Erik M. Buck.
//  Copyright (c) 2012 Alberto Salido López. All rights reserved.
//

#import "UtilityModel+viewAdditions.h"
#import "UtilityMesh+viewAdditions.h"


@implementation UtilityModel (viewAdditions)

/////////////////////////////////////////////////////////////////
// This method draws the receiver using the receiver's
// UtilityMesh and a UtilityModelEffect that have both already 
// been prepared for drawing.
- (void)draw
{
   [self.mesh drawCommandsInRange:NSMakeRange(
      indexOfFirstCommand_, numberOfCommands_)];
}

@end
