//
//  AGLKContext.h
//  BallEscape
//
//  Created by Alberto Salido López on 29/10/12.
//  References Learning OpenGL ES for iOS, Erik M. Buck.
//  Copyright (c) 2012 Alberto Salido López. All rights reserved.
//

#import <GLKit/GLKit.h>

//  The AGLKContext class is a simple subclass of the
//  built-in EAGLContext class provided by the OpenGLES framework.
//  This class unwarp the OpenGL methods using the Objective-C sintax.
@interface AGLKContext : EAGLContext
{
   GLKVector4 clearColor;
}

@property (nonatomic, assign, readwrite) 
   GLKVector4 clearColor;

- (void)clear:(GLbitfield)mask;
- (void)enable:(GLenum)capability;
- (void)disable:(GLenum)capability;
- (void)setBlendSourceFunction:(GLenum)sfactor 
   destinationFunction:(GLenum)dfactor;
   
@end
