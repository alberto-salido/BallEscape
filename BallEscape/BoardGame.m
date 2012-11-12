//
//  BoardGame.m
//  BallEscape
//
//  Created by Alberto Salido López on 12/11/12.
//  Copyright (c) 2012 Alberto Salido López. All rights reserved.
//

#import "BoardGame.h"

@interface BoardGame ()

@property (nonatomic, strong) UtilityModel *borders;

@end

@implementation BoardGame

@synthesize borders = _borders;

- (id)initBoardgameWithFloor:(UtilityModel *)floor 
                 andBorders:(UtilityModel *)borders 
                  inPosition:(GLKVector3)position
{
    //  The super class is initialized with the floor.
    if ((self = [super initWithModel:floor position:position]) != nil) {
        self.borders = borders;
    }
    return self;
}

- (AGLKAxisAllignedBoundingBox)getBoardgameDimension
{
    //  The super class is initialized with the floor as main UtilityModel.
    //  See the init method.
    return super.model.axisAlignedBoundingBox;
}

@end
