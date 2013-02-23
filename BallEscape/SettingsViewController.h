//
//  SettingsViewController.h
//  BallEscape
//
//  Created by Alberto Salido López on 25/11/12.
//  Copyright (c) 2012 Alberto Salido López. All rights reserved.
//

//  Framework references.
#import <UIKit/UIKit.h>

//  File References.
#import "MainViewController.h"

//  View Controller for handling the settings of the application.
//  The available settings for the application are the SFX sound,
//  if the ghost can pass throw walls and to reset the scores obtained.

@interface SettingsViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *SFXLabel;
@property (weak, nonatomic) IBOutlet UILabel *ghostThowWallsLabel;
@property (weak, nonatomic) IBOutlet UILabel *clearDataLabel;
@property (weak, nonatomic) IBOutlet UISwitch *SFXButton;
@property (weak, nonatomic) IBOutlet UISwitch *ghostThrowSwitch;
@property (weak, nonatomic) IBOutlet UIButton *clearButton;

//  Returns to the  main menu.
- (IBAction)BackToMenuButtonAction:(UIButton *)sender;

//  Turns on or off the sfx sound.
- (IBAction)SFXSwitcher:(UISwitch *)sender;

//  Reset the scores obtained.
- (IBAction)ClearDataButtonAction:(UIButton *)sender;

//  Allow the ghost to pass throw the walls.
- (IBAction)GhostCanPassThrowWall:(UISwitch *)sender;

@end
