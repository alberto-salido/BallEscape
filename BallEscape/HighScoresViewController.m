//
//  HighScoresViewController.m
//  BallEscape
//
//  Created by Alberto Salido López on 18/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "HighScoresViewController.h"

@interface HighScoresViewController ()

@property (nonatomic, strong) NSFileManager *fileManager;

@end

@implementation HighScoresViewController

@synthesize fileManager = _fileManager;
@synthesize scoresList = _scoresList;

- (void)viewDidLoad
{
    NSError *fileError;
    
    [super viewDidLoad];
    
    //  Initializes the array of scores.
    self.scoresList = [[NSArray alloc] init];
    
    //  Reads previous scores from a text file. If there are not a file, a new one 
    //  is created.
    NSString *scoresPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                                NSUserDomainMask,
                                                                YES) lastObject];
    scoresPath = [scoresPath stringByAppendingPathComponent:@"scores.txt"];
    
    //  Reads the file.
    NSString *fileContent = [NSString stringWithContentsOfFile:scoresPath
                                                      encoding:NSUTF8StringEncoding 
                                                         error:&fileError];
    if (!fileError) {
        //  Stores its content into an array.
        self.scoresList = [fileContent componentsSeparatedByString:@","];
    } else {
        fileError = nil;
        //  Creates a new empty file.
        [@"" writeToFile:scoresPath 
              atomically:YES 
                encoding:NSUTF8StringEncoding 
                   error:&fileError];
        NSAssert(!fileError, @"Error creating a new file for storing scores.");
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"scoreCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    cell.textLabel.text = [self.scoresList objectAtIndex:indexPath.row];
        
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
