//
//  MainController.m
//  BallEscape
//
//  Created by Alberto Salido López on 18/11/12.
//  Copyright (c) 2012 Alberto Salido López. All rights reserved.
//

#import "MainViewController.h"
#import "AppDelegate.h"

//  Constants.
static NSString *const FILE_NAME = @"scores.plist"; 
static NSString *const PLAY_SEGUE_ID = @"goToPlayMenu";
static NSString *const HIGHSCORES_SEGUE_ID = @"showHighScores";
static NSString *const SETTINGS_SEGUE_ID = @"settings";
static NSString *const ABOUT_ME_SEGUE_ID = @"aboutMe";

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
}

- (void)saveData
{
    /*
     * test
     */
    [self.scoresDictionary writeScoresToFile:self.scoresPath];

    if (![self.dictionaryCache isEqualToDictionary:self.scoresDictionary]) {
        [self.scoresDictionary writeScoresToFile:self.scoresPath];
    }
}
@end
