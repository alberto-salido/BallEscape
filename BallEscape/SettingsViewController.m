//
//  SettingsViewController.m
//  BallEscape
//
//  Created by Alberto Salido López on 25/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SettingsViewController.h"

static int const MULTIMEDIA = 0;
static int const GAME = 1;

@implementation SettingsViewController
@synthesize optionMenu;
@synthesize soundLabel;
@synthesize ballSpeedLabel;
@synthesize SFXLabel;
@synthesize ghostThowWallsLabel;
@synthesize clearDataLabel;
@synthesize soundButton;
@synthesize speedSlider;
@synthesize SFXButton;
@synthesize ghostThrowSwitch;
@synthesize clearButton;

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
     
}

- (void)viewDidUnload
{
    [self setSoundLabel:nil];
    [self setBallSpeedLabel:nil];
    [self setSFXLabel:nil];
    [self setGhostThowWallsLabel:nil];
    [self setClearDataLabel:nil];
    [self setOptionMenu:nil];
    [self setSoundButton:nil];
    [self setSpeedSlider:nil];
    [self setSFXButton:nil];
    [self setGhostThrowSwitch:nil];
    [self setClearButton:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return ((interfaceOrientation != UIInterfaceOrientationPortrait) && (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown));
}

- (IBAction)BackToMenuButtonAction:(id)sender {
    [self dismissModalViewControllerAnimated:YES];
}

- (IBAction)SoundSwitcher:(id)sender {
}

- (IBAction)SFXSwitcher:(id)sender {
}

- (IBAction)ClearDataButtonAction:(id)sender {
}

- (IBAction)OptionsSwitcher:(id)sender {
    if (self.optionMenu.selectedSegmentIndex ==  MULTIMEDIA) {
        self.soundLabel.hidden = NO;
        self.soundButton.hidden = NO;
        self.ballSpeedLabel.hidden = YES;
        self.speedSlider.hidden = YES;
        self.SFXLabel.hidden = NO;
        self.SFXButton.hidden = NO;
        self.ghostThowWallsLabel.hidden = YES;
        self.ghostThrowSwitch.hidden = YES;
        self.clearDataLabel.hidden = YES;
        self.clearButton.hidden = YES;
    } else if (self.optionMenu.selectedSegmentIndex == GAME) {
        self.soundLabel.hidden = YES;
        self.soundButton.hidden = YES;
        self.ballSpeedLabel.hidden = NO;
        self.speedSlider.hidden = NO;
        self.SFXLabel.hidden = YES;
        self.SFXButton.hidden = YES;
        self.ghostThowWallsLabel.hidden = NO;
        self.ghostThrowSwitch.hidden = NO;
        self.clearDataLabel.hidden = NO;
        self.clearButton.hidden = NO;    }
}

- (IBAction)BallSpeedSlider:(id)sender {
}

- (IBAction)GhostCanPassThrowWall:(id)sender {
}
@end
