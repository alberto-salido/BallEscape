//
//  AboutMeViewController.m
//  BallEscape
//
//  Created by Alberto Salido López on 25/11/12.
//  Copyright (c) 2012 Alberto Salido López. All rights reserved.
//

#import "AboutMeViewController.h"

@interface AboutMeViewController ()

@property (nonatomic, weak) UIWebView *htmlView;

@end

@implementation AboutMeViewController

@synthesize htmlView = _htmlView;

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
        
    // Loads the main HTML file with the references to objects within, like css or js files.
    NSString *path = [[NSBundle mainBundle] bundlePath];
    NSString *htmlFile = [[NSBundle mainBundle] pathForResource:@"aboutMeHTMLView" ofType:@"html"];
    NSString *htmlString = [NSString stringWithContentsOfFile:htmlFile encoding:NSUTF8StringEncoding error:nil];
    NSURL *baseURL = [NSURL fileURLWithPath:path];
    [self.htmlView loadHTMLString:htmlString baseURL:baseURL];
    
    self.htmlView.delegate = self;
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return ((interfaceOrientation != UIInterfaceOrientationPortrait) && (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown));}

- (IBAction)BackButtonAction:(id)sender {
    [self dismissModalViewControllerAnimated:YES];
}

-(BOOL) webView:(UIWebView *)inWeb shouldStartLoadWithRequest:(NSURLRequest *)inRequest navigationType:(UIWebViewNavigationType)inType {
    if ( inType == UIWebViewNavigationTypeLinkClicked ) {
        [[UIApplication sharedApplication] openURL:[inRequest URL]];
        return NO;
    }
    
    return YES;
}


@end
