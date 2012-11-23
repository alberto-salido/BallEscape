//
//  HighScoresViewController.h
//  BallEscape
//
//  Created by Alberto Salido López on 18/11/12.
//  Copyright (c) 2012 Alberto Salido López. All rights reserved.
//

#import <UIKit/UIKit.h>

//  Shows the scores obtained by the user, sorting them by best time,
//  and grouping by level.
//
@interface HighScoresViewController : UITableViewController

//  Dictionary with the scores, indexed by level.
@property (nonatomic, strong) NSMutableDictionary *scoresDictionary;

@end
