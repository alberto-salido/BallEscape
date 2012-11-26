//
//  Score.m
//  BallEscape
//
//  Created by Alberto Salido López on 21/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Score.h"

@implementation Score

@synthesize timeUsedInCompleteLevel = _timeUsedInCompleteLevel;
@synthesize date = _date;
@synthesize level = _level;

- (id)init
{
    NSAssert(NO, @"Invalid initializer");
    return nil;
}

- (id)initWithTime:(float)timeUsed atLevel:(int)level
{
    if ((self = [super init]) != nil) {
        self.timeUsedInCompleteLevel = timeUsed;
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"dd-MM-yyyy HH:mm"];
        
        self.date = [formatter stringFromDate:[NSDate date]];
                
        self.level = level;
    }
    return self;
}


- (NSComparisonResult)compareScores:(Score *)sc1
{
    if (sc1.timeUsedInCompleteLevel < self.timeUsedInCompleteLevel) {
        return NSOrderedDescending;
    } else if (sc1.timeUsedInCompleteLevel > self.timeUsedInCompleteLevel) {
        return NSOrderedAscending;
    } else {
        return NSOrderedSame;
    }
}

@end
