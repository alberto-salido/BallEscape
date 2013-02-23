//
//  TutorialContentViewController.m
//  BallEscape
//
//  Created by Alberto Salido López on 16/12/12.
//  Copyright (c) 2012 Alberto Salido López. All rights reserved.
//

#import "TutorialContentViewController.h"

@implementation TutorialContentViewController

@synthesize imageView = _imageView;
@synthesize dataObject = _dataObject;


#pragma mark - View lifecycle

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [_imageView setImage:(UIImage *)_dataObject];
}

- (void)viewDidUnload
{
    [self setImageView:nil];
    [self setDataObject:nil];
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return ((interfaceOrientation != UIInterfaceOrientationPortrait) && (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown));
}

#pragma mark - Skip Action

- (IBAction)skipTutorial:(UIButton *)sender 
{
    [self dismissModalViewControllerAnimated:YES];
}
@end
