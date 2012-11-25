//
//  NSDictionary+fileAdditions.m
//  BallEscape
//
//  Created by Alberto Salido López on 23/11/12.
//  Copyright (c) 2012 Alberto Salido López. All rights reserved.
//

#import "NSDictionary+fileAdditions.h"

@implementation NSDictionary (fileAdditions)

- (BOOL)writeToFile:(NSString *)filePath
{
    NSError *error;
    NSString *header = @"<!-- Copyright (c) 2012 Alberto Salido López. All rights reserved. -->\n <?xml version=\"1.0\" encoding=\"UTF-8\"?>\n<!DOCTYPE plist PUBLIC \"-//Apple//DTD PLIST 1.0//EN\" \"http://www.apple.com/DTDs/PropertyList-1.0.dtd\">\n<plist version=\"1.0\">\n";
    
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
            scoreAsString = [NSString stringWithFormat:@"<time>%2.f</time>\n<date>%@</date>\n<level>%d</level>\n</score>\n",
                             score.timeUsedInCompleteLevel, score.date, (score.level + 1)];
            body = [body stringByAppendingString:scoreAsString];
        }
        
        body = [body stringByAppendingString:@"</array>\n</value>\n"];
    }
    
    NSString *footer = @"</dict>\n</plist>\n</xml>\n";
    
    header = [header stringByAppendingString:body];
    header = [header stringByAppendingString:footer];
    [header writeToFile:filePath atomically:YES encoding:NSUTF8StringEncoding error:&error];
    
    if (error) {
        return NO;
    } else {
        return YES;
    }
}

- (BOOL)readFromFile:(NSString *)filePath
{
    NSError *error;
    NSString *fileContent = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:&error];
    
    if (error) {
        return NO;
    }
        
    NSArray *elements = [fileContent componentsSeparatedByString:@"\n"];
    
    BOOL key = NO;
    BOOL value = NO;
    
    NSString *elementKey;
    NSMutableArray *values = [[NSMutableArray alloc] init];
    Score *scoreValue = [[Score alloc] initWithTime:0.0 atLevel:0];
    
    for (NSString *element in elements) {
        
        if (key) {
            elementKey = element;
            key = NO;
        } else if (value) {
            NSArray *elementSplitted = [element componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]];
            if ([[elementSplitted objectAtIndex:1] isEqualToString:@"time"]) {
                scoreValue.timeUsedInCompleteLevel = [[elementSplitted objectAtIndex:2] floatValue];
            } else if ([[elementSplitted objectAtIndex:1] isEqualToString:@"date"]) {
                scoreValue.date = [elementSplitted objectAtIndex:2];
            } else if ([[elementSplitted objectAtIndex:1] isEqualToString:@"level"]) {
                scoreValue.level = [[elementSplitted objectAtIndex:2] intValue];
            }
        }
        
        if ([element isEqualToString:@"<key>"]) {
            key = YES;
        } else if ([element isEqualToString:@"<score>"]) {
            value = YES;
        } else if ([element isEqualToString:@"</score>"]) {
            [values addObject:scoreValue];
                        value = NO;
        }
    }
    if ([values count] > 0) {
        [((NSMutableDictionary *)self) setValue:values 
                                         forKey:[NSString stringWithFormat:@"%d", 
                                                 scoreValue.level]];
    }
    return YES;
}

@end
