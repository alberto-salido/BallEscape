//
//  BoardGame.h
//  BallEscape
//
//  Created by Alberto Salido López on 12/11/12.
//  Copyright (c) 2012 Alberto Salido López. All rights reserved.
//

#import "3DObject.h"

//  This class represents the boardgame. As all the objects in the
//  game it extends the |3DObject| interface.
//  The boardgame is composed by a floor and for walls making the
//  borders of the floor.
//
@interface BoardGame : threeDObject

//  Borders of the gameboard.
@property (readonly, nonatomic, strong) UtilityModel *borders;

//  Initializes the boardgame with floor and borders.
- (id)initBoardgameWithFloor:(UtilityModel *)floor 
                  andBorders:(UtilityModel *)borders
                  inPosition:(GLKVector3)position;

//  Gets the Bounding box of the boardgame. It has the
//  maximum, and minimum, position in X and Z axis. 
- (AGLKAxisAllignedBoundingBox)getBoardgameDimension;

@end
