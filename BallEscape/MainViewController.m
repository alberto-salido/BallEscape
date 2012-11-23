//
//  MainController.m
//  BallEscape
//
//  Created by Alberto Salido López on 18/11/12.
//  Copyright (c) 2012 Alberto Salido López. All rights reserved.
//

#import "MainViewController.h"

//  Constants.
static NSString *const FILE_NAME = @"scores.plist"; 
static NSString *const PLAY_SEGUE_ID = @"goToPlayMenu";
static NSString *const HIGHSCORES_SEGUE_ID = @"showHighScores";

@interface MainViewController ()

@property (nonatomic, strong) NSMutableDictionary *scoresDictionary;

//  Property with the path in which store the file with the scores.
@property (nonatomic, strong) NSString *scoresPath;

@end

@implementation MainViewController

@synthesize scoresDictionary = _scoresDictionary;
@synthesize scoresPath = _scoresPath;

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
    /*
     *  Crear metodo propio.
     *  self.scoresDictionary = [NSMutableDictionary dictionaryWithContentsOfFile:self.scoresPath];
     */
}

- (void)viewDidAppear:(BOOL)animated
{
    /*
     *  Tener una copia del dictionary, si la copia es diferente del actual
     *  sobreescribir fichero, sino, dejarlo como esta.
     */
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
}

- (IBAction)showHighScoresButton:(id)sender {
    [self performSegueWithIdentifier:HIGHSCORES_SEGUE_ID sender:self];
}

- (IBAction)howToPlayButton:(id)sender {
}

- (IBAction)aboutMeButton:(id)sender {
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
@end
