//
//  MainController.m
//  BallEscape
//
//  Created by Alberto Salido López on 18/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MainViewController.h"

@implementation MainViewController

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
@end
