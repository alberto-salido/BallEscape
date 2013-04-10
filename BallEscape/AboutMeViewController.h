//
//  AboutMeViewController.h
//  BallEscape
//
//  Created by Alberto Salido López on 25/11/12.
//  Copyright (c) 2012 Alberto Salido López. All rights reserved.
//

//  Framework reference.
#import <UIKit/UIKit.h>

//  Show information about the author of the app, and the description
//  of the same.
//
@interface AboutMeViewController : UIViewController <UIWebViewDelegate>

// HTML View
@property (nonatomic, weak, readonly) IBOutlet UIWebView *htmlView;

//  Button to the main menu.
- (IBAction)BackButtonAction:(id)sender;

@end
