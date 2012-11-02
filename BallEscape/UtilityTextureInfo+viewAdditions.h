//
//  UtilityTextureInfo+viewAdditions.h
//  BallEscape
//
//  Created by Alberto Salido López on 29/10/12.
//  References Learning OpenGL ES for iOS, Erik M. Buck.
//  Copyright (c) 2012 Alberto Salido López. All rights reserved.
//

#import "UtilityTextureInfo.h"
#import <GLKit/GLKit.h>

//  The UtilityTextureInfo class encapsulates a dictionary
//  of attributes including the binary data defining a 
//  texture’s image, but the attributes are not suitable for
//  direct use with OpenGL ES. The UtilityTextureInfo (viewAdditions)
//  category provides name and target properties needed by OpenGL ES
//  to identify a texture for subsequent rendering.
@interface GLKTextureInfo (utilityAdditions)

+ (GLKTextureInfo *)textureInfoFromUtilityPlistRepresentation:
   (NSDictionary *)aDictionary;
   
@end


@interface UtilityTextureInfo (viewAdditions)

@property (nonatomic, readonly, assign) GLuint name;
@property (nonatomic, readonly, assign) GLenum target;

@end
