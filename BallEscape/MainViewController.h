//
//  MainController.h
//  BallEscape
//
//  Created by Alberto Salido López on 18/11/12.
//  Copyright (c) 2012 Alberto Salido López. All rights reserved.
//

// Framework References.
#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

// File References.
#import "HighScoresViewController.h"
#import "SettingsViewController.h"
#import "GameViewController.h"
#import "Score.h"
#import "NSDictionary+fileAdditions.h"


//  This controller manages the complete application, creating segues to
//  the other view controller. MainViewController is the first controller
//  opened when the application starts.
//
@interface MainViewController : UIViewController

//  Dictionary with the scores obtained(Values) in each level(Key).
//  Example:
//  For level 0 (key 0) there are a set of scores (value).
@property (nonatomic, strong, readonly) NSMutableDictionary *scoresDictionary;

//  Properties about the game settings:
//  Enables the option of ghost can pass through the wall of the labyrinth, and
//  the sound for the game.
@property (nonatomic) BOOL ghostThroughWalls;
@property (nonatomic) BOOL shouldPlayMusic;

//  Player for the game music.
@property (nonatomic, strong, readonly) AVAudioPlayer *musicPlayer;

// Calibration position. Array with x and z positions.
@property (nonatomic) NSArray *calibrationCoordinates;


//  Actions:
//  Changes to the |GameViewController| for preparing the eviroment to play.
- (IBAction)playButton:(UIButton *)sender;

//  Changes to the |SettingsViewController|.
- (IBAction)settingsButton:(UIButton *)sender;

//  Shows a "popover" with the scores, managed by the |HighScoresViewController|.
- (IBAction)showHighScoresButton:(UIButton *)sender;

//  Changes to the |TutorialViewController|.
- (IBAction)howToPlayButton:(UIButton *)sender;

//  Shows a description of the app and myself.
- (IBAction)aboutMeButton:(UIButton *)sender;

//  Save the current data to a plist file.
- (void)saveData;

//  Deletes the |NSDictionary| with the scores, creating a new one empty.
- (void)restartScores;

@end
