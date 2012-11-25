//
//  MainController.h
//  BallEscape
//
//  Created by Alberto Salido López on 18/11/12.
//  Copyright (c) 2012 Alberto Salido López. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HighScoresViewController.h"
#import "Score.h"
#import "NSDictionary+fileAdditions.h"

//  This controller manages the complete application, creating segues to
//  the other view controller.
//
@interface MainViewController : UIViewController

//  Dictionary with the scores obtained(Values) in each level(Key).
@property (nonatomic, strong, readonly) NSMutableDictionary *scoresDictionary;

//  Actions.
//  Changes to the |GameViewController| for prepare the eviroment to play.
- (IBAction)playButton:(UIButton *)sender;

//  Changes to the |SettingsViewController|.
- (IBAction)settingsButton:(UIButton *)sender;

//  Shows a "popover" with the scores, managed by the |HighScoresViewController|.
- (IBAction)showHighScoresButton:(UIButton *)sender;

//  Changes to the |TutorialViewController|.
- (IBAction)howToPlayButton:(UIButton *)sender;

//  Shows a description of the app.
- (IBAction)aboutMeButton:(UIButton *)sender;

//  Save the current data to a plist file.
- (void)saveData;
@end
