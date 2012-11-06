//
//  LevelManager.h
//  BallEscape
//
//  Created by Alberto Salido López on 06/11/12.
//  Copyright (c) 2012 Alberto Salido López. All rights reserved.
//

#import <Foundation/Foundation.h>

//  Constants for the level's name.
#define LEVEL_ZERO 0

@interface LevelManager : NSObject

//  Structure for storing the position in the screen of 
//  every object that will be displayed.
typedef struct {
    float x, y, z;
    BOOL rotate;
}Location;

//  Number of levels in the game
@property (readonly) int numberOfLevels;

//  Level played now.
@property (readonly) int currentLevel;


- (id)initWithNumberOfLevels:(int)number;
- (NSArray *)getNextLevelStructure;

@end
