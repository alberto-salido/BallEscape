//
//  NSDictionary+fileAdditions.m
//  BallEscape
//
//  Created by Alberto Salido López on 23/11/12.
//  Copyright (c) 2012 Alberto Salido López. All rights reserved.
//

#import "NSDictionary+fileAdditions.h"

@implementation NSDictionary (fileAdditions)

- (BOOL)writeScoresToFile:(NSString *)filePath
{
    NSError *error;
    NSString *header = @"<!-- Copyright (c) 2012 Alberto Salido López. All rights reserved. -->\n <?xml version=\"1.0\" encoding=\"UTF-8\"?>\n";
    
    NSString *body = @"<dict>\n";
    
    NSEnumerator *keys = [self keyEnumerator];
    NSArray *values;
    
    NSString *scoreAsString;
    
    for (NSString *key in keys) {
        body = [body stringByAppendingString:@"<key>\n"];
        body = [body stringByAppendingString:key];
        body = [body stringByAppendingString:@"\n</key>\n"];
        
        values = [self objectForKey:key];
        
        body = [body stringByAppendingString:@"<value>\n<array>\n"];
        
        for (Score *score in values) {
            body = [body stringByAppendingString:@"<score>\n"];
            scoreAsString = [NSString stringWithFormat:@"<time>%.2f</time>\n<date>%@</date>\n<level>%d</level>\n</score>\n",
                             score.timeUsedInCompleteLevel, score.date, score.level];
            body = [body stringByAppendingString:scoreAsString];
        }
        
        body = [body stringByAppendingString:@"</array>\n</value>\n"];
    }
    
    NSString *footer = @"</dict>\n</xml>\n";
    
    header = [header stringByAppendingString:body];
    header = [header stringByAppendingString:footer];
    [header writeToFile:filePath atomically:YES encoding:NSUTF8StringEncoding error:&error];
    
    if (error) {
        return NO;
    } else {
        return YES;
    }
}

- (BOOL)readScoresFromFile:(NSString *)filePath
{
    NSError *error;
    NSString *fileContent = [NSString stringWithContentsOfFile:filePath 
                                                      encoding:NSUTF8StringEncoding 
                                                         error:&error];
    if (error) {
        return NO;
    }
    
    NSArray *elements = [fileContent componentsSeparatedByCharactersInSet:
                         [NSCharacterSet characterSetWithCharactersInString:@"<>"]];    
    BOOL key = NO;
    BOOL value = NO;
    BOOL timeTag = NO;
    BOOL dateTag = NO;
    BOOL levelTag = NO;
    
    NSString *elementKey;
    NSMutableArray *values;
    
    float time;
    NSString *date;
    int level;
    
    for (NSString *elementWithSpecialChar in elements) {
        
        //  Removes the \n and the withe spaces.
        NSString *element = 
        [[elementWithSpecialChar stringByReplacingOccurrencesOfString:@"\n" withString:@""]
         stringByReplacingOccurrencesOfString:@" " withString:@""];
        
        //  If is not an empty string.
        if (![element isEqualToString:@""]) {   
            if (key) {
                elementKey = element;
               values = [[NSMutableArray alloc] init];
                key = NO;
            } else if (value) {
                if (timeTag) {
                    time = [element floatValue];
                    timeTag = NO;
                } else if (dateTag) {
                    date = element.copy;
                    dateTag = NO;
                } else if (levelTag) {
                    level = [element intValue];
                    levelTag = NO;
                }
            }
            
            if ([element isEqualToString:@"key"]) {
                key = YES;
            } else if ([element isEqualToString:@"score"]) {
                value = YES;
            } else if ([element isEqualToString:@"/score"]) {
                Score *scoreValue = [[Score alloc] initWithTime:time atLevel:level];
                scoreValue.date = date;
                [values addObject:scoreValue];
                value = NO;
            } else if ([element isEqualToString:@"time"]) {
                timeTag = YES;
            } else if ([element isEqualToString:@"date"]) {
                dateTag = YES;
            } else if ([element isEqualToString:@"level"]) {
                levelTag = YES;
            }             
        }
        
        if ([values count] > 0) {
            [self setValue:values forKey:elementKey];
        }
        
    }
    return YES;
}

- (BOOL)readLevelStructureFromFile:(NSString *)filePath
{
    NSError *error;
    
    NSString *fileContent = [NSString stringWithContentsOfFile:filePath 
                                                      encoding:NSUTF8StringEncoding 
                                                         error:&error];
    if (error) {
        return NO;
    }
    
    NSArray *elements = [fileContent componentsSeparatedByCharactersInSet:
                         [NSCharacterSet characterSetWithCharactersInString:@"<>"]];
    
    BOOL wall = NO;
    BOOL position = NO;
    BOOL ball = NO;
    BOOL ghost = NO;
    BOOL door = NO;
    
    NSMutableArray *wallPostions = [[NSMutableArray alloc] init];
    NSMutableArray *ballPostion = [[NSMutableArray alloc] init];
    NSMutableArray *ghostPostion = [[NSMutableArray alloc] init];
    NSMutableArray *doorPostion = [[NSMutableArray alloc] init];
    
    for (NSString *elementWithSpecialChar in elements) {
        
        //  Removes the \n and the withe spaces.
        NSString *element = 
        [[elementWithSpecialChar stringByReplacingOccurrencesOfString:@"\n" withString:@""] stringByReplacingOccurrencesOfString:@" " withString:@""];
        
        //  If is not an empty string.
        if (![element isEqualToString:@""]) {            
            
            if (wall) {
                if (position) {
                    NSArray *positions = [element componentsSeparatedByString:@","];
                    [wallPostions addObjectsFromArray:positions];
                    position = NO;
                }
            }
            
            if (ball) {
                if (position) {
                    NSArray *positions = [element componentsSeparatedByString:@","];
                    [ballPostion addObjectsFromArray:positions];
                    position = NO;
                }
            }
            
            if (ghost) {
                if (position) {
                    NSArray *positions = [element componentsSeparatedByString:@","];
                    [ghostPostion addObjectsFromArray:positions];
                    position = NO;
                }
            }
            
            if (door) {
                if (position) {
                    NSArray *positions = [element componentsSeparatedByString:@","];
                    [doorPostion addObjectsFromArray:positions];
                    position = NO;
                }
            }
            
            if ([element isEqualToString:@"wall"]) {
                wall = YES;
            } else if ([element isEqualToString:@"position"]) {
                position = YES;
            } else if ([element isEqualToString:@"/wall"]) {
                wall = NO;
            } else if ([element isEqualToString:@"ball"]) {
                ball = YES;
            } else if ([element isEqualToString:@"/ball"]) {
                ball = NO;
            } else if ([element isEqualToString:@"ghost"]) {
                ghost = YES;
            } else if ([element isEqualToString:@"/ghost"]) {
                ghost = NO;
            } else if ([element isEqualToString:@"door"]) {
                door = YES;
            } else if ([element isEqualToString:@"/door"]) {
                door = NO;
            }
        }
    }
        
    [self setValue:(NSArray *)wallPostions forKey:@"wall"];
    [self setValue:ballPostion forKey:@"ball"];
    [self setValue:ghostPostion forKey:@"ghost"];
    [self setValue:doorPostion forKey:@"door"];
       
    return YES;
}

@end
