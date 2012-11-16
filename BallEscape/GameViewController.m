//
//  GameViewController.m
//  BallEscape
//
//  Created by Alberto Salido López on 15/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "GameViewController.h"

@implementation GameViewController

@synthesize timeUsedInCompleteLevel = _timeUsedInCompleteLevel;
@synthesize showTime = _showTime;
@synthesize congratulationsMessage = _congratulationsMessage;

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
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if (self.timeUsedInCompleteLevel) {
        NSLog(@"Estoy aqui");
        self.congratulationsMessage.hidden = NO;
        self.showTime.hidden = NO;
        self.showTime.text = [NSString stringWithFormat:@"%@ %.2f",
                              self.showTime.text, 
                              self.timeUsedInCompleteLevel];
    }
}

- (void)viewDidUnload
{
    [self setShowTime:nil];
    [self setCongratulationsMessage:nil];
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
    self.congratulationsMessage.hidden = YES;
    self.showTime.hidden = YES;
    [self performSegueWithIdentifier:@"playGame" sender:self];
}
@end
