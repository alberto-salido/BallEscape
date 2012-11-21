//
//  GameViewController.m
//  BallEscape
//
//  Created by Alberto Salido López on 15/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "GameViewController.h"

static const int NUMBER_OF_LEVELS = 1;

@interface GameViewController ()

@property (nonatomic, strong) LevelManager *levelManager;

- (void)performSegueToPlayGame;

@end

@implementation GameViewController

@synthesize timeUsedInCompleteLevel = _timeUsedInCompleteLevel;
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
}

- (void)viewWillDisappear:(BOOL)animated
{
    //  Stores the score.
    if (self.timeUsedInCompleteLevel) {
        Score *s = [[Score alloc] initWithTime:self.timeUsedInCompleteLevel 
                                       atLevel:(self.levelManager.currentLevel - 1)];
        
        [((MainViewController *)self.presentingViewController).scoresList addObject:s];
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
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
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

- (IBAction)goBackToMenu:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)restartCurrentLevel:(id)sender {
    [self.levelManager restartCurrentLevel];
    [self performSegueToPlayGame];
}

- (void)performSegueToPlayGame
{
    [self performSegueWithIdentifier:@"playGame" sender:self];
}
@end
