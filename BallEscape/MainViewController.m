//
//  MainController.m
//  BallEscape
//
//  Created by Alberto Salido López on 18/11/12.
//  Copyright (c) 2012 Alberto Salido López. All rights reserved.
//

#import "MainViewController.h"
	
// Scores file name.
static NSString *const FILE_NAME = @"ball_Escape_HScores.scoreplist";

//  Constants with the name of the segues.
static NSString *const PLAY_SEGUE_ID = @"goToPlayMenu";
static NSString *const HIGHSCORES_SEGUE_ID = @"showHighScores";
static NSString *const SETTINGS_SEGUE_ID = @"settings";
static NSString *const ABOUT_ME_SEGUE_ID = @"aboutMe";
static NSString *const TUTORIAL_SEGUE_ID = @"showTutorial";

// Music
static NSString *const MUSIC = @"DoKashiteru_-_The_Annual_New_England_Xylophone_Symposium";

// Private properties.
@interface MainViewController ()

//  Two dictionaries are created, one with the real infomation of the scores,
//  and another, working as a cache, for minimize the number of disk access.
@property (nonatomic, strong) NSMutableDictionary *scoresDictionary;
@property (nonatomic, weak) NSDictionary *dictionaryCache;

//  Property with the path in which store the file with the scores.
@property (nonatomic, strong) NSString *scoresPath;

@property (nonatomic, strong) AVAudioPlayer *musicPlayer;

@end

@implementation MainViewController 

// Getter and setter implementations.
@synthesize scoresDictionary = _scoresDictionary;
@synthesize scoresPath = _scoresPath;
@synthesize dictionaryCache = _dictionaryCache;
@synthesize ghostThrowWalls = _ghostThrowWalls;
@synthesize musicPlayer = _musicPlayer;
@synthesize shouldPlayMusic = _shouldPlayMusic;
@synthesize calibrationCoordinates = _calibrationView;


#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //  Open the music file.
    NSURL* url = [[NSBundle mainBundle] URLForResource:MUSIC withExtension:@"mp3"];
    NSAssert(url, @"URL is valid.");
    NSError* error = nil;
    self.musicPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
    if(!self.musicPlayer)
    {
        NSLog(@"Error creating player: %@", error);
    }
    
    // By default starts playing music.
    self.shouldPlayMusic = YES;
    
    self.musicPlayer.numberOfLoops = 2;
    
    if (self.shouldPlayMusic) {
         [self.musicPlayer play];
    }
   
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

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    // If the music is over, restart the song.
    if(![self.musicPlayer isPlaying]) {
        [self.musicPlayer play];
    }
    
    // If the sound option is disabled, stop playing music.
    if (!self.shouldPlayMusic) {
        [self.musicPlayer stop];
    }
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    self.scoresDictionary = nil;
    self.scoresPath = nil;
    self.dictionaryCache = nil;
    self.ghostThrowWalls = NO;
    self.musicPlayer = nil;
    self.shouldPlayMusic = NO;
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return ((interfaceOrientation != UIInterfaceOrientationPortrait) &&
            (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown));
}

//  Changes the view.
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
    //  Sends information about the dictionary to the next segue in case of High
    //  Scores View Controller.
    if ([[segue identifier] isEqualToString:HIGHSCORES_SEGUE_ID]) {
        HighScoresViewController *hvc = [segue destinationViewController];
        hvc.scoresDictionary = self.scoresDictionary;
    }
    
    //  Sends if the ghost will pass throw the walls or not, to the Game View Controller.
    if ([[segue identifier] isEqualToString:PLAY_SEGUE_ID]) {
        GameViewController *gvc = [segue destinationViewController];
        gvc.ghostThrowWall = self.ghostThrowWalls;
    }
    
    //  Updates the attributes in the Settings View Controller according to the game. 
    if ([[segue identifier] isEqualToString:SETTINGS_SEGUE_ID]) {
        SettingsViewController *svc = [segue destinationViewController];
        svc.ghostThrowSwitch.on = self.ghostThrowWalls;
    }
}

- (void)saveData
{
    //  Saves data only if the scrores in the app and in the disk are differents,
    //  otherwise, do not spend time in writing.
    if (![self.dictionaryCache isEqualToDictionary:self.scoresDictionary]) {
        [self.scoresDictionary writeScoresToFile:self.scoresPath];
    }
}

- (void)restartScores
{
    //  Creates a new dictionary with the scores.
    self.scoresDictionary = [[NSMutableDictionary alloc] init];
}

@end
