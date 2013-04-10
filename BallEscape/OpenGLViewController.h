//
//  OpenGLViewController.h
//  BallEscape
//
//  Created by Alberto Salido López on 29/10/12.
//  Copyright (c) 2012 Alberto Salido López. All rights reserved.
//

#import <GLKit/GLKit.h>
#import <CoreMotion/CoreMotion.h>

#import "AGLKContext.h"
#import "GameViewController.h"
#import "UtilityModelManager.h"
#import "UtilityModel+viewAdditions.h"
#import "BoardGame+viewAdditions.h"
#import "Wall.h"
#import "Ball+viewAdditions.h"
#import "Ghost+viewAdditions.h"
 
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

//  Settings.
@property (nonatomic) BOOL ghostThrowWall;

// Image to display when pause game is paused.
@property (weak, nonatomic) IBOutlet UIImageView *pauseView;

// Back button.
@property (weak, nonatomic) IBOutlet UIButton *goBackButton;

// Being the game paused, go back to the menu.
- (IBAction)goBackToMenu:(UIButton *)sender;

//  Pauses the current game.
//  Pauses and play the game.
- (IBAction)pauseGame:(UIButton *)sender;

//  Pauses the game.
- (void)pauseFrameRate;

@end
