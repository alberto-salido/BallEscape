//
//  NSDictionary+fileAdditions.h
//  BallEscape
//
//  Created by Alberto Salido López on 23/11/12.
//  Copyright (c) 2012 Alberto Salido López. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Score.h"

//  Provides a new method to the NSDictionary class.
//
@interface NSDictionary (fileAdditions)

//  Writes the NSDictionary with the scores of the game
//  into a file.
- (BOOL)writeScoresToFile:(NSString *)filePath;

//  Reads from a file the information about de game's 
//  socres and stores it into a NSDictionary.
- (BOOL)readScoresFromFile:(NSString *)filePath;

//  Reads the elements of a level from a file.
//  The elements are stored into a |NSDictionary|.
- (BOOL)readLevelStructureFromFile:(NSString *)filePath;

@end
