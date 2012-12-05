//
//  GameViewController.m
//  BallEscape
//
//  Created by Alberto Salido López on 15/11/12.
//  Copyright (c) 2012 Alberto Salido López. All rights reserved.
//

#import "GameViewController.h"

//  Constants.
static int const NUMBER_OF_LEVELS = 1;
static NSString *const PLAY_GAME_SEGUE_ID = @"playGame";
static int const SCORES_PER_SECTION = 5;
static NSString *const CONGRATS_MSG = @"Congratulations!\n You have escaped!!";
static NSString *const FAIL_MSG = @"Ooooh!, You failed!!";
static int const OK = 1;

@interface GameViewController ()

@property (nonatomic, strong) LevelManager *levelManager;

- (void)performSegueToPlayGame;

@end

@implementation GameViewController

@synthesize timeUsedInCompleteLevel = _timeUsedInCompleteLevel;
@synthesize gameOver = _gameOver;
@synthesize ghostThrowWall = _ghostThrowWall;
@synthesize showTime = _showTime;
@synthesize congratulationsMessage = _congratulationsMessage;
@synthesize levelToPlayLabel = _levelToPlayLabel;
@synthesize playButton = _playButton;
@synthesize continueButton = _continueButton;
@synthesize menuButton = _menuButton;
@synthesize restartLevelButton = _restartLevelButton;
@synthesize levelManager = _levelManager;

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];    
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    //  Initializes the LevelManages with the number of levels.
    self.levelManager = [[LevelManager alloc] 
                         initWithNumberOfLevels:NUMBER_OF_LEVELS];
    [super viewDidLoad];   
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    self.levelToPlayLabel.text = [NSString stringWithFormat:@"Level - %d",
                                  (self.levelManager.currentLevel + 1)];
    
    //  If the user has complete a level...
    if (self.timeUsedInCompleteLevel) {
        
        //  Show messages and buttons.
        self.congratulationsMessage.text = CONGRATS_MSG;
        self.congratulationsMessage.hidden = NO;
        self.showTime.hidden = NO;
        self.showTime.text = [NSString stringWithFormat:@"Your time: %.2f",
                              self.timeUsedInCompleteLevel];
        self.playButton.hidden = YES;
        
        //  If there are more levels...
        if ([self.levelManager numberOfLevels] != [self.levelManager currentLevel]) {
            //  Enables the "Continue" button.
            self.continueButton.hidden = NO;
        }
        
        //  Enables the "Restart" button.
        self.restartLevelButton.hidden = NO;
    }
    
    //  If the user losses the previous game;
    if (self.gameOver) {
        self.congratulationsMessage.text = FAIL_MSG;
        self.congratulationsMessage.hidden = NO;
        self.showTime.hidden = YES;
        self.playButton.hidden = YES;
        self.continueButton.hidden = YES;
        self.levelToPlayLabel.text = [NSString stringWithFormat:@"Level - %d",
                                      (self.levelManager.currentLevel)];
        self.gameOver = NO;
        self.timeUsedInCompleteLevel = 0.0;
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    //  Stores the score.
    if (self.timeUsedInCompleteLevel) {
        Score *s = [[Score alloc] initWithTime:self.timeUsedInCompleteLevel 
                                       atLevel:(self.levelManager.currentLevel - 1)];
        
        //  Updates the dictionary.
        NSString *level = [NSString stringWithFormat:@"%d", s.level];
        NSMutableDictionary *dic = ((MainViewController *)self.presentingViewController).scoresDictionary;
        NSMutableArray *array;
        
        if ((array = [dic objectForKey:level])) {
            [array addObject:s];
            array = [array sortedArrayUsingSelector:@selector(compareScores:)].mutableCopy;
            if ([array count] > SCORES_PER_SECTION) {
                [array removeLastObject];
            }
        } else {
            array =[[NSMutableArray alloc] initWithObjects:s, nil];
        }
        
        [dic setObject:array forKey:level];
    }
}

- (void)viewDidUnload
{
    [self setShowTime:nil];
    [self setCongratulationsMessage:nil];
    [self setPlayButton:nil];
    [self setContinueButton:nil];
    [self setMenuButton:nil];
    [self setRestartLevelButton:nil];
    [self setLevelToPlayLabel:nil];
    self.levelManager = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return ((interfaceOrientation != UIInterfaceOrientationPortrait) && (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown));
}

- (IBAction)playGame:(UIButton *)sender 
{
    [self performSegueToPlayGame];
}

- (IBAction)continueWithNextLevel:(id)sender {
    [self performSegueToPlayGame];
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == OK) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (IBAction)goBackToMenu:(id)sender {
    
    if (self.levelManager.currentLevel == 0) {
        [self dismissViewControllerAnimated:YES completion:nil];
        
    } else {
        
        UIAlertView *warningAboutEndCurrentGame = [[UIAlertView alloc] 
                                                   initWithTitle:@"Warning" 
                                                   message:@"If you go back, you will lose all your progress. Next time you will start on Level - 1" 
                                                   delegate:self 
                                                   cancelButtonTitle:@"Cancel" 
                                                   otherButtonTitles:@"Okay", nil];
        [warningAboutEndCurrentGame show];
    }
    
}

- (IBAction)restartCurrentLevel:(id)sender {
    [self.levelManager restartCurrentLevel];
    [self performSegueToPlayGame];
}

- (void)performSegueToPlayGame
{
    [self performSegueWithIdentifier:PLAY_GAME_SEGUE_ID sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:PLAY_GAME_SEGUE_ID]) {
        OpenGLViewController *ovc = [segue destinationViewController];
        ovc.ghostThrowWall = self.ghostThrowWall;
    }
}


@end
