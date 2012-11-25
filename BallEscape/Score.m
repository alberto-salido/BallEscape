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

- (NSString *)printCSVString
{
    return [NSString stringWithFormat:@"%@,%@,%@,", 
            self.timeUsedInCompleteLevel, self.date, self.level];
}

+ (NSMutableDictionary *)dictionaryWithScoresFromCSVString:(NSString *)csvString
{
    NSArray *stringSlitted = [csvString componentsSeparatedByString:@","];
    NSMutableDictionary *result = [[NSMutableDictionary alloc] init];
    NSMutableArray *values = [[NSMutableArray alloc] init];
    
    Score *aux;
    
    if ([stringSlitted count] > 3) {
        for (int i = 0; i < [stringSlitted count]; i = i + 3) {
            aux = [[Score alloc] initWithTime:[[stringSlitted objectAtIndex:i]  floatValue] 
                                      atLevel:[[stringSlitted objectAtIndex:i + 2] floatValue]];
            aux.date = [stringSlitted objectAtIndex:i + 1];
            
            NSString *levelString = [NSString stringWithFormat:@"%d", aux.level];
            
            if ((values = (NSMutableArray *)[result objectForKey:levelString])) {
                [values addObject:aux];
            }else {
                values = [[NSMutableArray alloc] initWithObjects:aux, nil];
            }
            
            [result setObject:values 
                       forKey:levelString];
        }
    }
    return result;
}

@end
