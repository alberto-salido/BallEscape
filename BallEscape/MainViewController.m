//
//  MainController.m
//  BallEscape
//
//  Created by Alberto Salido López on 18/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()

@property (nonatomic, strong) NSMutableArray *scoresList;

@end

@implementation MainViewController

@synthesize scoresList = _scoresList;

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //  Initializes the scores array loading the content stored in a file.
    NSError *fileError;
    
    //  Initializes the array of scores.
    self.scoresList = [[NSMutableArray alloc] init];
    
    //  Reads previous scores from a text file. If there are not a file, a new one 
    //  is created.
    NSString *scoresPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                                NSUserDomainMask,
                                                                YES) lastObject];
    scoresPath = [scoresPath stringByAppendingPathComponent:@"scores.txt"];
    
    //  Reads the file.
    NSString *fileContent = [NSString stringWithContentsOfFile:scoresPath
                                                      encoding:NSUTF8StringEncoding 
                                                         error:&fileError];
    if (!fileError) {
        //  Stores its content into an array.
        //self.scoresList = [fileContent componentsSeparatedByString:@","];
        self.scoresList = [Score arrayWithScoresFromCSVString:fileContent];
    } else {
        fileError = nil;
        //  Creates a new empty file.
        [@"" writeToFile:scoresPath 
              atomically:YES 
                encoding:NSUTF8StringEncoding 
                   error:&fileError];
        NSAssert(!fileError, @"Error creating a new file for storing scores.");
    }
    NSLog(@"%@", self.scoresList);
}

- (void)viewWillAppear:(BOOL)animated
{
    if ([self.scoresList count] > 0) {
        NSLog(@"%f", ((Score *)[self.scoresList objectAtIndex:0]).timeUsedInCompleteLevel);
    }
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return ((interfaceOrientation != UIInterfaceOrientationPortrait) &&
            (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown));
}

- (IBAction)playButton:(id)sender {
    [self performSegueWithIdentifier:@"goToPlayMenu" sender:self];
}

- (IBAction)settingsButton:(id)sender {
}

- (IBAction)showHighScoresButton:(id)sender {
    [self performSegueWithIdentifier:@"showHighScores" sender:self];
}

- (IBAction)howToPlayButton:(id)sender {
}

- (IBAction)aboutMeButton:(id)sender {
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    //  Sends information to the next segue.
    if ([[segue identifier] isEqualToString:@"showHighScores"]) {
        HighScoresViewController *hvc = [segue destinationViewController];
        hvc.scoresList = self.scoresList;
    }
}
@end
