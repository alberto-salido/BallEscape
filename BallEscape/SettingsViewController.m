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

// Motion controller for the calibration.
@property (nonatomic, strong) CMMotionManager *motionManager;

// Array to store the current position of the tablet [x, z].
@property (nonatomic, strong) NSMutableArray *calibrationCoordinates;

@end

@implementation SettingsViewController
@synthesize soundLabel = _soundLabel;
@synthesize ghostThoughWallsLabel = _ghostThoughWallsLabel;
@synthesize clearDataLabel = _clearDataLabel;
@synthesize soundSwitcher = _soundSwitcher;
@synthesize ghostThroughSwitcher = _ghostThroughSwitcher;
@synthesize clearButton = _clearButton;
@synthesize mvc = _mvc;
@synthesize calibrationCoordinates = _calibrationCoordinates;


#pragma mark - View lifecycle

- (void)viewDidUnload
{
    // Release any retained subviews of the main view.
    [self setSoundLabel:nil];
    [self setGhostThoughWallsLabel:nil];
    [self setClearDataLabel:nil];
    [self setSoundSwitcher:nil];
    [self setGhostThroughSwitcher:nil];
    [self setClearButton:nil];
    [self setCalibrationCoordinates:nil];
    [self setMvc:nil];
    [self.motionManager stopDeviceMotionUpdates];
    [self setMotionManager:nil];
    [super viewDidUnload];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    //  Gets a reference to the previous ViewController.
    self.mvc = ((MainViewController *) self.presentingViewController);
    
    // Updates the status of the switches.
    self.ghostThroughSwitcher.on = self.mvc.ghostThroughWalls;
    self.soundSwitcher.on = self.mvc.shouldPlayMusic;
    
    self.motionManager = [[CMMotionManager alloc] init];
    [self.motionManager startDeviceMotionUpdates];
    
    // Initializes the array if needed.
    if (self.calibrationCoordinates == nil) {
        self.calibrationCoordinates = [NSMutableArray arrayWithCapacity:2];
        [self.calibrationCoordinates insertObject:[NSNumber numberWithDouble:0.0] atIndex:0];
        [self.calibrationCoordinates insertObject:[NSNumber numberWithDouble:0.0] atIndex:1];
        self.mvc.calibrationCoordinates = self.calibrationCoordinates;
    }
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return ((interfaceOrientation != UIInterfaceOrientationPortrait) && (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown));
}

- (IBAction)backToMenuButtonAction:(UIButton *)sender
{
    [self dismissModalViewControllerAnimated:YES];
}

- (IBAction)soundSwitcher:(UISwitch *)sender
{
    if ((self.mvc.shouldPlayMusic = sender.on)) {
      //  [self.mvc.musicPlayer play];
    } else  {
        [self.mvc.musicPlayer stop];

    }
}

- (IBAction)calibrateViewButtonAction:(UIButton *)sender
{
    
    // Calibrates the current view of the array.
    if (self.motionManager.isDeviceMotionActive) {
        [self.calibrationCoordinates insertObject:[NSNumber
                                                   numberWithDouble:self.motionManager.deviceMotion.attitude.roll]
                                          atIndex:0];
        [self.calibrationCoordinates insertObject:[NSNumber
                                                   numberWithDouble:self.motionManager.deviceMotion.attitude.pitch]
                                          atIndex:1];
        
        self.mvc.calibrationCoordinates = self.calibrationCoordinates;
    }
    
    // Message indicating that the calibration has been made.
    UIAlertView *calibrationDone = [[UIAlertView alloc] initWithTitle:@"Message"
                                                              message:@"Calibration completed."
                                                             delegate:nil cancelButtonTitle:@"Okay"
                                                    otherButtonTitles:nil];
    [calibrationDone show];
}

- (IBAction)resetCalibrationButtonAction:(UIButton *)sender
{    
    [self.calibrationCoordinates insertObject:[NSNumber numberWithDouble:0.0] atIndex:0];
    [self.calibrationCoordinates insertObject:[NSNumber numberWithDouble:0.0] atIndex:1];
    self.mvc.calibrationCoordinates = self.calibrationCoordinates;
    
    // Message indicating that the calibration has been made.
    UIAlertView *calibrationReset = [[UIAlertView alloc] initWithTitle:@"Message"
                                                              message:@"Calibration reseted."
                                                             delegate:nil cancelButtonTitle:@"Okay"
                                                    otherButtonTitles:nil];
    [calibrationReset show];

}

- (IBAction)calibrationInfo:(UIButton *)sender
{
    UIAlertView *calibrationInfo = [[UIAlertView alloc] initWithTitle:@"Info"
                                                               message:@"Place your iPad in a comfortable position and press CALIBRATE. From now you can play in that position. Press RESET VIEW to default settings."
                                                              delegate:nil cancelButtonTitle:@"Okay"
                                                     otherButtonTitles:nil];
    [calibrationInfo show];
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    //  Restart the scores.
    if (buttonIndex == OK) {
        [self.mvc restartScores];
    } 
}

- (IBAction)clearDataButtonAction:(UIButton *)sender {
    //  Shows a warning before deleting the scores.
    UIAlertView *warningAboutDeletingScores = [[UIAlertView alloc] 
                                               initWithTitle:@"Warning" 
                                               message:@"You will delete all your saved scores." 
                                               delegate:self
                                               cancelButtonTitle:@"Cancel" 
                                               otherButtonTitles:@"Okay", nil];
    [warningAboutDeletingScores show];
}

- (IBAction)ghostCanPassThroughWall:(UISwitch *)sender {
    self.mvc.ghostThroughWalls = sender.on;
}

@end
