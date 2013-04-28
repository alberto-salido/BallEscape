//
//  GameViewController.m
//  BallEscape
//
//  Created by Alberto Salido López on 15/11/12.
//  Copyright (c) 2012 Alberto Salido López. All rights reserved.
//

#import "GameViewController.h"

//  Constants.
static int const NUMBER_OF_LEVELS = 3;
static NSString *const PLAY_GAME_SEGUE_ID = @"playGame";
static int const SCORES_PER_SECTION = 5;
static NSString *const CONGRATS_MSG = @"Congratulations!\n You have escaped!!";
static NSString *const FAIL_MSG = @"Ooooh!, You failed!!";
static int const OK = 1;
static NSString *const WIN_VIEW = @"BallEscape.GameMenu.Win.bmp";
static NSString *const LOSE_VIEW = @"BallEscape.GameMenu.Lose.bmp";


@interface GameViewController ()

@property (nonatomic, strong) LevelManager *levelManager;

//  Reference to the main view controller which has the
//  inforation about the settings and the scores.
@property MainViewController *mvc;

- (void)performSegueToPlayGame;

@end

@implementation GameViewController

@synthesize timeUsedInCompleteLevel = _timeUsedInCompleteLevel;
@synthesize gameOver = _gameOver;
@synthesize ghostThroughWall = _ghostThroughWall;
@synthesize showTime = _showTime;
@synthesize congratulationsMessage = _congratulationsMessage;
@synthesize levelToPlayLabel = _levelToPlayLabel;
@synthesize playButton = _playButton;
@synthesize continueButton = _continueButton;
@synthesize menuButton = _menuButton;
@synthesize restartLevelButton = _restartLevelButton;
@synthesize levelManager = _levelManager;
@synthesize labelNewHighScore = _labelNewHighScore;
@synthesize imageView = _imageView;
@synthesize mvc = _mvc;
@synthesize calibrationCoordinates = _calibrationCoordinates;


#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.mvc = (MainViewController *)self.presentingViewController;
    
    //  Gets the calibration information from the previous view-controller.
    self.calibrationCoordinates = self.mvc.calibrationCoordinates;
    
    //  Initializes the LevelManages with the number of levels.
    self.levelManager = [[LevelManager alloc] 
                         initWithNumberOfLevels:NUMBER_OF_LEVELS];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.labelNewHighScore.hidden = YES;
    self.continueButton.hidden = YES;
    
    self.levelToPlayLabel.text = [NSString stringWithFormat:@"Level - %d",
                                  (self.levelManager.currentLevel + 1)];
    
    //  If the user losses the previous game;
    if (self.gameOver) {
        
        // Changes the view.
        self.imageView.image = [UIImage imageNamed:LOSE_VIEW];
        
        self.congratulationsMessage.text = FAIL_MSG;
        self.congratulationsMessage.hidden = NO;
        self.showTime.hidden = YES;
        self.playButton.hidden = YES;
        self.continueButton.hidden = YES;
        self.levelToPlayLabel.text = [NSString stringWithFormat:@"Level - %d",
                                      (self.levelManager.currentLevel)];
        self.gameOver = NO;
        self.timeUsedInCompleteLevel = 0.0;
        
        //  Enables the "Restart" button.
        self.restartLevelButton.hidden = NO;
    }
    
    //  If the user has complete a level...
    if (self.timeUsedInCompleteLevel) {
        
        // Changes the view.
        self.imageView.image = [UIImage imageNamed:WIN_VIEW];
        
        //  Show messages and buttons.
        self.congratulationsMessage.text = CONGRATS_MSG;
        self.congratulationsMessage.hidden = NO;
        self.showTime.hidden = NO;
        self.showTime.text = [NSString stringWithFormat:@"Your time: %.2f",
                              self.timeUsedInCompleteLevel];
        self.playButton.hidden = YES;
        
        Score *s = [[Score alloc] initWithTime:self.timeUsedInCompleteLevel 
                                       atLevel:(self.levelManager.currentLevel - 1)];
        
        //  Updates the dictionary with the socres.
        NSString *level = [NSString stringWithFormat:@"%d", s.level];
        NSMutableDictionary *dic = ((MainViewController *)self.presentingViewController).scoresDictionary;
        NSMutableArray *array;
        
        if ((array = [dic objectForKey:level])) {
            [array addObject:s];
            array = [array sortedArrayUsingSelector:@selector(compareScores:)].mutableCopy;
            
            //  Show a message of new High Score.
            int index = [array indexOfObject:s];
            if (index == 0) {
                self.labelNewHighScore.hidden = NO;
            }
            
            if ([array count] > SCORES_PER_SECTION) {
                [array removeLastObject];
            } 
        } else {
            array =[[NSMutableArray alloc] initWithObjects:s, nil];
        }
        
        [dic setObject:array forKey:level];
        
        //  If there are more levels...
        if ([self.levelManager currentLevel] < [self.levelManager numberOfLevels]) {
            //  Enables the "Continue" button.
            self.continueButton.hidden = NO;
        }
        
        //  Enables the "Restart" button.
        self.restartLevelButton.hidden = NO;
    }
}

- (void)viewDidUnload
{
    [self setImageView:nil];
    [self setShowTime: nil];
    [self setCongratulationsMessage: nil];
    [self setLevelToPlayLabel:nil];
    [self setPlayButton:nil];
    [self setContinueButton:nil];
    [self setMenuButton:nil];
    [self setRestartLevelButton:nil];
    [self setLevelManager:nil];
    [self setLabelNewHighScore:nil];
    [self setMvc:nil];
    [self setCalibrationCoordinates:nil];
    [super viewDidUnload];
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
    
    if ((self.levelManager.currentLevel < 1) ||
        (self.levelManager.currentLevel == NUMBER_OF_LEVELS)) {
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
        ovc.ghostThroughWall = self.ghostThroughWall;
    }
}


@end
