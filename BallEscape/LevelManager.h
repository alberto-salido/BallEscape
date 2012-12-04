//
//  LevelManager.h
//  BallEscape
//
//  Created by Alberto Salido López on 06/11/12.
//  Copyright (c) 2012 Alberto Salido López. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSDictionary+fileAdditions.h"

//  Manages all the levels of the game. When the game starts,
//  the |LevelManager| has to be initialized with the number
//  of levels. Every game turn, using the
//  |getNextLevelStructure| call, returns a |NSDictionary| the 
//  position of the objects in the game.
//
@interface LevelManager : NSObject

//  Number of levels in the game
@property (readonly) int numberOfLevels;

//  Level played now.
@property (readonly) int currentLevel;

//  Array with the positions of the walls in the game.
//  i.e: [x,z,BOOL...].
@property (readonly, strong, nonatomic) NSArray *levelStructure;

//  Array with the coordinates of the ball.
//  [x, y, z]
@property (readonly, strong, nonatomic) NSArray *ballPosition;

//  Array with the coordinates of the ghost.
//  [x, y, z]
@property (readonly, strong, nonatomic) NSArray *ghostPosition;

//  Array with the coordinates of the door.
//  [x, y, z]
@property (readonly, strong, nonatomic) NSArray *doorPosition;

//  Initializes with the number of levels.
- (id)initWithNumberOfLevels:(int)number;

//  Checks if there are more levels.
- (BOOL)hasNextLevel;

//  Loads the information of the level from a file.
//  This method must be called before any other (except init).
- (void)setUpLevel;

//  Makes the next level the current level. So, the player can play
//  again the last level.
- (void)restartCurrentLevel;

//  Restart the complete game. The next level will be the first level.
- (void)restartGame;

@end
