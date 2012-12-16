//
//  MainController.m
//  BallEscape
//
//  Created by Alberto Salido López on 18/11/12.
//  Copyright (c) 2012 Alberto Salido López. All rights reserved.
//

#import "MainViewController.h"

//  Constants.
static NSString *const FILE_NAME = @"ball_Escape_HScores.scoreplist"; 
static NSString *const PLAY_SEGUE_ID = @"goToPlayMenu";
static NSString *const HIGHSCORES_SEGUE_ID = @"showHighScores";
static NSString *const SETTINGS_SEGUE_ID = @"settings";
static NSString *const ABOUT_ME_SEGUE_ID = @"aboutMe";
static NSString *const TUTORIAL_SEGUE_ID = @"showTutorial";

@interface MainViewController ()

@property (nonatomic, strong) NSMutableDictionary *scoresDictionary;
@property (nonatomic, weak) NSDictionary *dictionaryCache;

//  Property with the path in which store the file with the scores.
@property (nonatomic, strong) NSString *scoresPath;

@end

@implementation MainViewController

@synthesize scoresDictionary = _scoresDictionary;
@synthesize scoresPath = _scoresPath;
@synthesize dictionaryCache = _dictionaryCache;
@synthesize ghostThrowWalls = _ghostThrowWalls;

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
        
    //  Sets the path in Documents/scores.plist.
    self.scoresPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                                NSUserDomainMask,
                                                                YES) lastObject];
    self.scoresPath = [self.scoresPath stringByAppendingPathComponent:FILE_NAME];
    
    //  Reads the file and stores its content into a dictionary.
    self.scoresDictionary = [[NSMutableDictionary alloc] init];
    [self.scoresDictionary readScoresFromFile:self.scoresPath];
    self.dictionaryCache = self.scoresDictionary.copy;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    self.scoresPath = nil;
    self.scoresPath = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return ((interfaceOrientation != UIInterfaceOrientationPortrait) &&
            (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown));
}

- (IBAction)playButton:(id)sender {
    [self performSegueWithIdentifier:PLAY_SEGUE_ID sender:self];
}

- (IBAction)settingsButton:(id)sender {
    [self performSegueWithIdentifier:SETTINGS_SEGUE_ID sender:self];
}

- (IBAction)showHighScoresButton:(id)sender {
    [self performSegueWithIdentifier:HIGHSCORES_SEGUE_ID sender:self];
}

- (IBAction)howToPlayButton:(id)sender {
    [self performSegueWithIdentifier:TUTORIAL_SEGUE_ID sender:self];
}

- (IBAction)aboutMeButton:(id)sender {
    [self performSegueWithIdentifier:ABOUT_ME_SEGUE_ID sender:self];
}

//  Prepares the next view controller before the segue is triggered.
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    //  Sends information about the dictionary to the next segue.
    if ([[segue identifier] isEqualToString:HIGHSCORES_SEGUE_ID]) {
        HighScoresViewController *hvc = [segue destinationViewController];
        hvc.scoresDictionary = self.scoresDictionary;
    }
    
    if ([[segue identifier] isEqualToString:PLAY_SEGUE_ID]) {
        GameViewController *gvc = [segue destinationViewController];
        gvc.ghostThrowWall = self.ghostThrowWalls;
    }
    
    if ([[segue identifier] isEqualToString:SETTINGS_SEGUE_ID]) {
        SettingsViewController *svc = [segue destinationViewController];
        svc.ghostThrowSwitch.on = self.ghostThrowWalls;
    }
}

- (void)saveData
{
    if (![self.dictionaryCache isEqualToDictionary:self.scoresDictionary]) {
        [self.scoresDictionary writeScoresToFile:self.scoresPath];
    }
}

- (void)restartScores
{
    self.scoresDictionary = [[NSMutableDictionary alloc] init];
}
@end
