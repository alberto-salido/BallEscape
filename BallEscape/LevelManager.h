//
//  LevelManager.h
//  BallEscape
//
//  Created by Alberto Salido López on 06/11/12.
//  Copyright (c) 2012 Alberto Salido López. All rights reserved.
//

#import <Foundation/Foundation.h>

//  Manages all the levels of the game. When the game starts,
//  the |LevelManager| has to be initialized with the number
//  of levels and he returns every game turn, using the
//  |getNextLevelStructure| call, the position of the object in
//  the game.
//
@interface LevelManager : NSObject

//  Number of levels in the game
@property (readonly) int numberOfLevels;

//  Level played now.
@property (readonly) int currentLevel;

//  Initializes with the number of levels.
- (id)initWithNumberOfLevels:(int)number;

//  Gets the array with the position of every object in the current level.
//  Returns |nil| if there are not more levels.
//  The array has the following format:
//  - [x, z, BOOL, ...]
//  Where, x and z are the coordinates of the object, the y
//  axis is not necessary because the objects are all over the floor.
//  The |BOOL| element represent if the object has to be rotated or not.
- (NSArray *)getNextLevelStructure;

//  Makes the next level the current level. So, the player can play
//  again the last level.
- (void)restartCurrentLevel;

//  Restart the complete game. The next level will be the first level.
- (void)restartGame;

@end
