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
#import "BoardGame+viewAdditions.h"
#import "Wall.h"
#import "LevelManager.h"
#import "Ball+viewAdditions.h"
 
//  The GLKViewController class provides all of the standard view
//  controller functionality, but additionally implements an
//  OpenGL ES rendering loop. A GLKViewController object works in
//  conjunction with a GLKView object to display frames of 
//  animation in the view.
//  This interface manages all the view events, using the model
//  for that propose.
//
@interface OpenGLViewController : GLKViewController <ObjectController>

//  Property for the time elapsed since the
//  player started to play.
@property (weak, nonatomic) IBOutlet UILabel *time;


/*
 *  Sliders para simular el nsor de movimento.
 */
- (IBAction)tiltXAxis:(UISlider *)sender;
- (IBAction)tiltZAxis:(UISlider *)sender;

@end
