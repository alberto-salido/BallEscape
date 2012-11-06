//
//  LevelManager.h
//  BallEscape
//
//  Created by Alberto Salido López on 06/11/12.
//  Copyright (c) 2012 Alberto Salido López. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UtilityModelManager.h"
#import "Wall.h"

@interface LevelManager : NSObject

//  Array with the objects of the current level.
@property (readonly, nonatomic, strong) NSMutableArray *levelStructure;

//  Number of levels in the game
@property (readonly) int numberOfLevels;

//  Level played now.
@property (readonly) int currentLevel;

//  The UtilityModelManager simplifies the load of models. This class
//  loads a unique Modelplist file with the entire model.
@property (readonly, nonatomic, strong) UtilityModelManager *modelManager;

//  The UtilityModel class stores a simple model. In this case, the 
//  boardgame model; floor, walls and borders.
@property (readonly, nonatomic, strong) UtilityModel *gameModelFloor;
@property (readonly, nonatomic, strong) UtilityModel *gameModelBorders;
@property (readonly, nonatomic, strong) UtilityModel *gameModelWalls;

//  Vector (array) with the elements to draw into the labyrinth.
@property (readonly, nonatomic, strong) NSMutableArray *elements;

//  The GLKBaseEffect class provides shaders that mimic many of the
//  behaviors provided by the OpenGL ES 1.1 lighting and shading model,
//  including materials, lighting and texturing. The base effect 
//  allows up to three lights and two textures to be applied to a scene.
@property (readonly, nonatomic, strong) GLKBaseEffect *baseEffect;


- (id)initWithNumberOfLevels:(int)number;
- (void)prepareLevelStructure;
- (void)loadModelsFromPath:(NSString *)path;
- (void)prepareViewAndDrawScene;

@end
