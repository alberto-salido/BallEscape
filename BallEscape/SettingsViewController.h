//
//  SettingsViewController.h
//  BallEscape
//
//  Created by Alberto Salido López on 25/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingsViewController : UIViewController

@property (weak, nonatomic) IBOutlet UISegmentedControl *optionMenu;
@property (weak, nonatomic) IBOutlet UILabel *soundLabel;
@property (weak, nonatomic) IBOutlet UILabel *ballSpeedLabel;
@property (weak, nonatomic) IBOutlet UILabel *SFXLabel;
@property (weak, nonatomic) IBOutlet UILabel *ghostThowWallsLabel;
@property (weak, nonatomic) IBOutlet UILabel *clearDataLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *soundButton;
@property (weak, nonatomic) IBOutlet UISlider *speedSlider;
@property (weak, nonatomic) IBOutlet UISegmentedControl *SFXButton;
@property (weak, nonatomic) IBOutlet UISwitch *ghostThrowSwitch;
@property (weak, nonatomic) IBOutlet UIButton *clearButton;

- (IBAction)BackToMenuButtonAction:(id)sender;
- (IBAction)SoundSwitcher:(id)sender;
- (IBAction)SFXSwitcher:(id)sender;
- (IBAction)ClearDataButtonAction:(id)sender;
- (IBAction)OptionsSwitcher:(id)sender;
- (IBAction)BallSpeedSlider:(id)sender;
- (IBAction)GhostCanPassThrowWall:(id)sender;

@end
