//
//  GameViewController.h
//  BallEscape
//
//  Created by Alberto Salido López on 15/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GameViewController : UIViewController

//  Property with the time used by the player
//  in complete the game.
@property float timeUsedInCompleteLevel;

//  Congratulates the player and show the time in complete
//  the labyrinth.
@property (weak, nonatomic) IBOutlet UILabel *showTime;
@property (weak, nonatomic) IBOutlet UILabel *congratulationsMessage;

//  Starts a new game.
- (IBAction)playGame:(UIButton *)sender;

@end
