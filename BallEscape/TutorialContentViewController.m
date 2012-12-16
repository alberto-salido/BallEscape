//
//  TutorialContentViewController.m
//  BallEscape
//
//  Created by Alberto Salido López on 16/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TutorialContentViewController.h"

@implementation TutorialContentViewController
@synthesize imageView = _imageView;
@synthesize dataObject = _dataObject;

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [_imageView setImage:(UIImage *)_dataObject];
}

- (void)viewDidUnload {
    [self setImageView:nil];
    [self setDataObject:nil];
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return ((interfaceOrientation != UIInterfaceOrientationPortrait) && (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown));
}

- (IBAction)skipTutorial:(UIButton *)sender 
{
    [self dismissModalViewControllerAnimated:YES];
}
@end
