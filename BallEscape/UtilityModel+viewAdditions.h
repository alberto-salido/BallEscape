//
//  UtilityModel+viewAdditions.h
//  BallEscape
//
//  Created by Alberto Salido López on 29/10/12.
//  References Learning OpenGL ES for iOS, Erik M. Buck.
//  Copyright (c) 2012 Alberto Salido López. All rights reserved.
//

#import "UtilityModel.h"

//  The UtilityModel (viewAdditions) category adds exactly
//  one method to the UtilityModel class from the Model subsystem.
//  The added method calls the associated mesh’s 
//  -drawCommandsInRange: method specifying the range of commands
//  applicable to the model.
@interface UtilityModel (viewAdditions)

- (void)draw;

@end
