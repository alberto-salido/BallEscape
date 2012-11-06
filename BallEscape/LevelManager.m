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


//  Auxiliary functions.
- (NSArray *)loadLevel0;

@end

@implementation LevelManager

@synthesize numberOfLevels = _numberOfLevels;
@synthesize currentLevel = _currentLevel;


//  Creates a new level manager with the number of levels provided.
- (id)initWithNumberOfLevels:(int)number
{
    if ((self = [super init]) != nil) {
        self.currentLevel = 0;
        self.numberOfLevels = number;
    }
    return self;
}

//  Return an array with the Location of every object for the 
//  next level to be render.
//  - Loads the position into the array.
//  - Increments the actual level for the next call.
//  - Returns nil if there are not more levels.
/*!
 * my function
 */
- (NSArray *)getNextLevelStructure
{
    NSArray *elementsPositions = [[NSArray alloc] init];
    
    if (self.currentLevel < self.numberOfLevels) {
        switch (self.currentLevel) {
            case LEVEL_ZERO:
                elementsPositions = [self loadLevel0];
                break;
                
            default:
                break;
        }
        return elementsPositions;
    } else {
        return nil;
    }
}

//  The locations of the level are stored into an string separated by
//  commas. This function divides the string into an array with all
//  the coordinates of every element. The Y-Coordinate is not stored
//  because all the objects are over the floor. It also saves a |BOOL|
//  component which indicates to rotate the object 90º.
- (NSArray *)loadLevel0
{
    NSString *locations = 
    @"-3.5,-6.0,YES,-2.0,-4.5,YES,-2.0,-3.5,YES,-2.0,-2.5,YES,-2.0,-1.5,YES,-2.25,-0.8,NO,-3.25,-0.8,NO,-4.25,-0.8,NO,-2.0,-0.1,YES,-2.0,0.9,YES,-2.0,1.9,YES,-2.0,2.9,YES,-2.0,3.5,NO,-3.0,3.5,NO,-1.0,3.5,NO,0.0,3.5,NO,-1.3,-3.5,NO,-0.3,-3.5,NO,0.7,-3.5,NO,1.7,-3.5,NO,2.4,-3.25,YES,2.4,-2.25,YES,4.5,-5.0,NO,3.5,-5.0,NO,3.0,0.0,NO,4.5,2.0,NO,3.5,2.0,NO,2.5,2.0,NO,1.5,2.0,NO,0.5,2.0,NO,0.25,1.3,YES,0.25,0.3,YES,0.25,-0.7,YES,3.0,4.0,YES,3.0,5.0,YES";
   return [locations componentsSeparatedByString:@","];
}




@end
