//
//  HighScoresViewController.m
//  BallEscape
//
//  Created by Alberto Salido López on 18/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "HighScoresViewController.h"
#import "Score.h"

@implementation HighScoresViewController

@synthesize scoresList = _scoresList;

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"scoreCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    Score *score = (Score *)[self.scoresList objectAtIndex:indexPath.row];
    NSString *time = [NSString stringWithFormat:@"%f", score.timeUsedInCompleteLevel];
    cell.textLabel.text = time;
        
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.scoresList count];
}

@end
