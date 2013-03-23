//
//  SettingsViewController.m
//  BallEscape
//
//  Created by Alberto Salido López on 25/11/12.
//  Copyright (c) 2012 Alberto Salido López. All rights reserved.
//

#import "SettingsViewController.h"

// Constants for switch values.
static int const ON = 0;
static int const OFF = 1;
static int const OK = 1;

// Constant with the file name of the scores file.
static NSString *const SCORE_FILE_NAME = @"ball_Escape_HScores.scoreplist";


@interface SettingsViewController ()

// Reference to the Main View Controller.
@property (nonatomic, strong) MainViewController *mvc;

@end

@implementation SettingsViewController
@synthesize SFXLabel = _SFXLabel;
@synthesize ghostThowWallsLabel = _ghostThowWallsLabel;
@synthesize clearDataLabel = _clearDataLabel;
@synthesize SFXButton = _SFXButton;
@synthesize ghostThrowSwitch = _ghostThrowSwitch;
@synthesize clearButton = _clearButton;

@synthesize mvc = _mvc;


#pragma mark - View lifecycle

- (void)viewDidUnload
{
    // Release any retained subviews of the main view.
    [self setSFXLabel:nil];
    [self setGhostThowWallsLabel:nil];
    [self setClearDataLabel:nil];
    [self setSFXButton:nil];
    [self setGhostThrowSwitch:nil];
    [self setClearButton:nil];
    [super viewDidUnload];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    //  Gets a reference to the previous ViewController.
    self.mvc = ((MainViewController *) self.presentingViewController);
    
    // Updates the status of the switches.
    self.ghostThrowSwitch.on = self.mvc.ghostThrowWalls;
    self.SFXButton.on = self.mvc.shouldPlayMusic;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return ((interfaceOrientation != UIInterfaceOrientationPortrait) && (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown));
}

- (IBAction)BackToMenuButtonAction:(UIButton *)sender {
    [self dismissModalViewControllerAnimated:YES];
}

- (IBAction)SFXSwitcher:(UISwitch *)sender {
    self.mvc.shouldPlayMusic = sender.on;
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    //  Restart the scores.
    if (buttonIndex == OK) {
        [self.mvc restartScores];
    } 
}

- (IBAction)ClearDataButtonAction:(UIButton *)sender {
    //  Shows a warning before deleting the scores.
    UIAlertView *warningAboutDeletingScores = [[UIAlertView alloc] 
                                               initWithTitle:@"Warning" 
                                               message:@"You will delete all your saved scores." 
                                               delegate:self
                                               cancelButtonTitle:@"Cancel" 
                                               otherButtonTitles:@"Okay", nil];
    [warningAboutDeletingScores show];
}

- (IBAction)GhostCanPassThrowWall:(UISwitch *)sender {
    self.mvc.ghostThrowWalls = sender.on;
}

@end
