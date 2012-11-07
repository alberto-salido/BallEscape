//
//  LevelManager.m
//  BallEscape
//
//  Created by Alberto Salido López on 06/11/12.
//  Copyright (c) 2012 Alberto Salido López. All rights reserved.
//

#import "LevelManager.h"


@class LevelManager;

@interface LevelManager ()

@property int numberOfLevels;
@property int currentLevel;

//  Loads the game level corresponding to the number
//  pased by parameter, number.
//  Reads the file with the coordinates of the level's
//  obejcts, and returns an array with all the coordinates
//  inside.
- (NSArray *)loadLevelWithNumber:(int)number;

@end


@implementation LevelManager

@synthesize numberOfLevels = _numberOfLevels;
@synthesize currentLevel = _currentLevel;

//  Super class initializer, must be override.
//  Returns nil and thorws an assertion.
- (id)init
{
    NSAssert(NO, @"Invalid initializer.");
    return nil;
}

//  Creates a new level manager with the number of levels provided.
- (id)initWithNumberOfLevels:(int)number
{
    if ((self = [super init]) != nil) {
        self.currentLevel = 0;
        self.numberOfLevels = number;
    }
    return self;
}

- (NSArray *)getNextLevelStructure
{
    NSArray *elementsPositions = [[NSArray alloc] init];
    
    if (self.currentLevel < self.numberOfLevels) {
        elementsPositions = [self loadLevelWithNumber:self.currentLevel];
        self.currentLevel ++;
    } else {
        return nil;
    }
    return elementsPositions;
}

- (NSArray *)loadLevelWithNumber:(int)number
{    
    //  The level coordinates file is a CSV (Comma Separated File) file.
    //  Each file has the coordinates of a level. The name starts with "level"
    //  followed by the number of the level.
    NSError *error;
    NSString *stringWithLevelPath = [[NSBundle mainBundle] 
                                     pathForResource:[NSString stringWithFormat:@"level%d", self.currentLevel] 
                                     ofType:@"txt"]; 
    NSString *stringWithCoordinatesOfLevel = [NSString stringWithContentsOfFile:stringWithLevelPath
                                                                       encoding:NSUTF8StringEncoding
                                                                          error:&error];
    return [stringWithCoordinatesOfLevel componentsSeparatedByString:@","];
}

@end