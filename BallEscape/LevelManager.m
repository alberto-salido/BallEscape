//
//  LevelManager.m
//  BallEscape
//
//  Created by Alberto Salido López on 06/11/12.
//  Copyright (c) 2012 Alberto Salido López. All rights reserved.
//

#import "LevelManager.h"

//  Constants for the Dictionary's keys.
static NSString *const WALL_KEY = @"wall";
static NSString *const BALL_KEY = @"ball";
static NSString *const GHOST_KEY = @"ghost";
static NSString *const DOOR_KEY = @"door";

@class LevelManager;

@interface LevelManager ()

@property int numberOfLevels;
@property int currentLevel;
@property (nonatomic, strong) NSArray *levelStructure;
@property (nonatomic, strong) NSArray *ballPosition;
@property (nonatomic, strong) NSArray *ghostPosition;
@property (nonatomic, strong) NSArray *doorPosition;

//  Property with the infromation about the game level.
//  It stores the location of each element, index by a key with
//  the object name.
@property (nonatomic, strong) NSMutableDictionary *gameLevelStructure;

@end

@implementation LevelManager

@synthesize numberOfLevels = _numberOfLevels;
@synthesize currentLevel = _currentLevel;
@synthesize levelStructure = _levelStructure;
@synthesize ballPosition = _ballPosition;
@synthesize ghostPosition = _ghostPosition;
@synthesize doorPosition = _doorPosition;
@synthesize gameLevelStructure = _gameLevelStructure;

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
        self.gameLevelStructure = [[NSMutableDictionary alloc] init];
    }
    return self;
}

- (BOOL)hasNextLevel
{
    return (self.currentLevel < self.numberOfLevels);
}

- (void)setUpLevel
{    
    NSString *stringWithLevelPath = [[NSBundle mainBundle] 
                                     pathForResource:[NSString stringWithFormat:@"level%d", self.currentLevel + 1] 
                                     ofType:@"gameplist"]; 
    
    if (![self.gameLevelStructure readLevelStructureFromFile:stringWithLevelPath])
    {
        NSAssert(NO, @"FATAL ERROR: Error reading level structure.");
    }
    
    self.levelStructure = [self.gameLevelStructure objectForKey:WALL_KEY];
    self.ballPosition = [self.gameLevelStructure objectForKey:BALL_KEY];
    self.ghostPosition = [self.gameLevelStructure objectForKey:GHOST_KEY];
    self.doorPosition = [self.gameLevelStructure objectForKey:DOOR_KEY];
        
    self.currentLevel ++;
}

- (void)restartCurrentLevel
{
    self.currentLevel --;
}

- (void)restartGame
{
    self.currentLevel = 0;
}

@end