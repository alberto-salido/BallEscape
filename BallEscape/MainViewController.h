//
//  MainController.h
//  BallEscape
//
//  Created by Alberto Salido López on 18/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HighScoresViewController.h"
#import "Score.h"

@interface MainViewController : UIViewController

@property (nonatomic, strong, readonly) NSMutableArray *scoresList;

- (IBAction)playButton:(UIButton *)sender;
- (IBAction)settingsButton:(UIButton *)sender;
- (IBAction)showHighScoresButton:(UIButton *)sender;
- (IBAction)howToPlayButton:(UIButton *)sender;
- (IBAction)aboutMeButton:(UIButton *)sender;
@end
