//
//  OpenGLViewController.h
//  BallEscape
//
//  Created by Alberto Salido López on 29/10/12.
//  Copyright (c) 2012 Alberto Salido López. All rights reserved.
//

#import <GLKit/GLKit.h>
#import "AGLKContext.h"
#import "UtilityModelManager.h"
#import "UtilityModel+viewAdditions.h"
#import "Wall.h"

//  The GLKViewController class provides all of the standard view
//  controller functionality, but additionally implements an
//  OpenGL ES rendering loop. A GLKViewController object works in
//  conjunction with a GLKView object to display frames of 
//  animation in the view.
@interface OpenGLViewController : GLKViewController

/*
 *  Sliders para simular el sensor de movimento.
 */
- (IBAction)tiltXAxis:(UISlider *)sender;
- (IBAction)tiltYAxis:(UISlider *)sender;

@end
