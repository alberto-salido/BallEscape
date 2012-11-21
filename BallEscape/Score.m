//
//  Score.m
//  BallEscape
//
//  Created by Alberto Salido López on 21/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Score.h"

@interface Score ()

@property float timeUsedInCompleteLevel;
@property (nonatomic, strong) NSString *date;
@property int level;

@end

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

- (NSString *)printCSVString
{
    return [NSString stringWithFormat:@"%@,%@,%@,", 
            self.timeUsedInCompleteLevel, self.date, self.level];
}

+ (NSMutableArray *)arrayWithScoresFromCSVString:(NSString *)csvString
{
    NSArray *stringSlitted = [csvString componentsSeparatedByString:@","];
    NSMutableArray *result = [[NSMutableArray alloc] init];
    
    Score *aux;
    
    if ([stringSlitted count] > 3) {
        for (int i = 0; i < [stringSlitted count]; i = i + 3) {
            aux = [[Score alloc] initWithTime:[[stringSlitted objectAtIndex:i]  floatValue] 
                                      atLevel:[[stringSlitted objectAtIndex:i + 2] floatValue]];
            aux.date = [stringSlitted objectAtIndex:i + 1];
            
            [result addObject:aux];
        }

    }
    return result;
}

@end
