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

@interface HighScoresViewController ()

@property (nonatomic, strong) NSMutableArray *scoresByLevel;

@end

@implementation HighScoresViewController

@synthesize scoresDictionary = _scoresDictionary;
@synthesize scoresByLevel = _scoresByLevel;

- (void)viewDidUnload
{
    [super viewDidUnload];
    self.scoresDictionary = nil;
    self.scoresByLevel = nil;
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
    NSMutableArray *scores = [self.scoresDictionary objectForKey:[NSString stringWithFormat:@"%d", 
                                                                 indexPath.section]];
    /*
    NSLog(@"%@", self.scoresDictionary);
    NSLog(@"index: %d", indexPath.section);
    NSLog(@"index.row: %d", indexPath.row);
     */
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
    return [NSString stringWithFormat:@"Level - %d", ([[keys objectAtIndex:section] intValue] + 1)];
}

//  Sets the number of sections.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.scoresDictionary count];
}

//  Sets the number of rows.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{    
    NSArray *scoresInSection = [self.scoresDictionary objectForKey:[NSString stringWithFormat:@"%d", section]];
    return [scoresInSection count];
}

- (IBAction)backToMenuButton:(UIBarButtonItem *)sender
{
     [self dismissViewControllerAnimated:YES completion:nil];
}
@end
