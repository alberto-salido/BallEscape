//
//  AGLKAxisAllignedBoundingBox.h
//  BallEscape
//
//  Created by Alberto Salido López on 29/10/12.
//  References Learning OpenGL ES for iOS, Erik M. Buck.
//  Copyright (c) 2012 Alberto Salido López. All rights reserved.
//

#import <GLKit/GLKit.h>

/////////////////////////////////////////////////////////////////
// Type that defines a bounding box. No vertex in contained 
// objects has X coordinate less than min.x or 
// X coordinate greater than max.x. The same is true for Y and Z
// coordinates relative to min.y, min.z, max.y, and max.z.
typedef struct
{
   GLKVector3 min;
   GLKVector3 max;
}
AGLKAxisAllignedBoundingBox;

