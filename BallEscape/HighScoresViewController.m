//
//  HighScoresViewController.m
//  BallEscape
//
//  Created by Alberto Salido López on 18/11/12.
//  Copyright (c) 2012 Alberto Salido López. All rights reserved.
//

#import "HighScoresViewController.h"
#import "Score.h"

//  Constants.
static NSString *const CELL_NAME = @"scoreCell";

@implementation HighScoresViewController

@synthesize scoresDictionary = _scoresDictionary;

- (void)viewDidLoad
{
    [super viewDidLoad];
}

//  Configures each cell.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CELL_NAME];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CELL_NAME];
    }
    
    // Configure the cell...
    //  Obtains the scores(NSArray) form the Dictionary with Key(level) equals to the section.
    NSArray *scores = (NSArray *)[self.scoresDictionary objectForKey:[NSString stringWithFormat:@"%d", 
                                                                 (indexPath.section + 1)]];
    //  Gets a score from the array.
    Score *score = (Score *)[scores objectAtIndex:indexPath.row];
    
    //  Sends the information to the Cell.
    cell.textLabel.text = [NSString stringWithFormat:@"Time: %.2f", score.timeUsedInCompleteLevel];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"Date: %@", score.date];
        
    return cell;
}

//  Configures the sections titles.
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    //  Sets the section title using the keys of the dic.
    NSArray *keys = [((NSEnumerator *)[self.scoresDictionary keyEnumerator]) allObjects];
    return [NSString stringWithFormat:@"Level - %@", [keys objectAtIndex:section]];
}

//  Sets the number of sections.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.scoresDictionary count];
}

//  Sets the number of rows.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    int keys = [self.scoresDictionary count];
    int rows = 0;
    for (int i = 0; i < keys; i++) {
        rows += [((NSArray *)[self.scoresDictionary 
                              objectForKey:[NSString stringWithFormat:@"%d", (i + 1)]]) count];
    }
    return rows;
}

@end
