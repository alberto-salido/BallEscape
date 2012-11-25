//
//  Score.h
//  BallEscape
//
//  Created by Alberto Salido López on 21/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Score : NSObject

@property float timeUsedInCompleteLevel;
@property (nonatomic, strong) NSString *date;
@property int level;

- (id)initWithTime:(float)timeUsed atLevel:(int)level;
- (NSString *)printCSVString;
+ (NSMutableDictionary *)dictionaryWithScoresFromCSVString:(NSString *)csvString;

@end
