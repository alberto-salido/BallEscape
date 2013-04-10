//
//  Score.h
//  BallEscape
//
//  Created by Alberto Salido López on 21/11/12.
//  Copyright (c) 2012 Alberto Salido López. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Score : NSObject

@property float timeUsedInCompleteLevel;
@property (nonatomic, strong) NSString *date;
@property int level;

- (id)initWithTime:(float)timeUsed atLevel:(int)level;
- (NSComparisonResult)compareScores:(Score *)sc1;

@end
