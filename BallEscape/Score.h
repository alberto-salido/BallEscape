//
//  Score.h
//  BallEscape
//
//  Created by Alberto Salido López on 21/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Score : NSObject

@property (readonly) float timeUsedInCompleteLevel;
@property (nonatomic, readonly, strong) NSString *date;
@property (readonly) int level;

- (id)initWithTime:(float)timeUsed atLevel:(int)level;
- (NSString *)printCSVString;
+ (NSMutableArray *)arrayWithScoresFromCSVString:(NSString *)csvString;

@end
