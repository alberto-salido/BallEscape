//
//  LevelManager.m
//  BallEscape
//
//  Created by Alberto Salido López on 06/11/12.
//  Copyright (c) 2012 Alberto Salido López. All rights reserved.
//

#import "LevelManager.h"

@class LevelManager;

@interface LevelManager ()

@property (nonatomic, strong) NSMutableArray *levelStructure;

@property int numberOfLevels;
@property int currentLevel;

@property (nonatomic, strong) UtilityModelManager *modelManager;

@property (nonatomic, strong) UtilityModel *gameModelFloor;
@property (nonatomic, strong) UtilityModel *gameModelBorders;
@property (nonatomic, strong) UtilityModel *gameModelWalls;

@property (nonatomic, strong) NSMutableArray *elements;

@property (nonatomic, strong) GLKBaseEffect *baseEffect;


//  Auxiliary functions.
- (void)loadLevel0;

@end

@implementation LevelManager

@synthesize levelStructure = _levelStructure;
@synthesize numberOfLevels = _numberOfLevels;
@synthesize currentLevel = _currentLevel;
@synthesize modelManager = _modelManager;
@synthesize gameModelFloor = _gameModelFloor;
@synthesize gameModelBorders = _gameModelBorders;
@synthesize gameModelWalls = _gameModelWalls;
@synthesize elements = _elements;
@synthesize baseEffect = _baseEffect;

//  Creates a new level manager with the number of levels provided.
- (id)initWithNumberOfLevels:(int)number
{
    if ((self = [super init]) != nil) {
        self.currentLevel = 0;
        self.numberOfLevels = number;
        self.levelStructure = [[NSMutableArray alloc] init];
        self.baseEffect = [[GLKBaseEffect alloc] init];
        self.elements = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)prepareLevelStructure
{
    switch (self.currentLevel) {
        case 0:
            [self loadLevel0];
            break;
            
        default:
            break;
    }
}

- (void)loadModelsFromPath:(NSString *)path
{
    //  Searches for the path and stores it.
    NSString *modelsPath = [[NSBundle bundleForClass:[self class]]
                            pathForResource:path ofType:@"modelplist"];
    self.modelManager = [[UtilityModelManager alloc] initWithModelPath:modelsPath];
    
    //  Loads the floor.
    self.gameModelFloor = [self.modelManager modelNamed:@"floor"];
    NSAssert(self.gameModelFloor != nil, @"Failed to load floor model");
    
    //  Loads the borders.
    self.gameModelBorders = [self.modelManager modelNamed:@"borders"];
    NSAssert(self.gameModelBorders != nil, @"Failed to load borders model");
    
    //  Loads the walls.
    self.gameModelWalls = [self.modelManager modelNamed:@"walls"];
    NSAssert(self.gameModelWalls != nil, @"Failed to load walls");
    
    //  Load the textures.
    self.baseEffect.texture2d0.name = self.modelManager.textureInfo.name;
    self.baseEffect.texture2d0.target = self.modelManager.textureInfo.target;

}

- (void)prepareViewAndDrawScene
{
    //  Prepares the view for drawing and draws the models.
    [self.modelManager prepareToDraw];
    [self.baseEffect prepareToDraw];
    
    //  Draw the boardgame.
    [self.gameModelFloor draw];
    [self.gameModelBorders draw];
    
    // Draw elements of the game.
    [self.elements makeObjectsPerformSelector:@selector(drawWithBaseEffect:) 
                                   withObject:self.baseEffect];

}

- (void)loadLevel0
{
    //  A)
    [self.levelStructure addObject:[[Wall alloc] 
                           initWithModel:self.gameModelWalls 
                           position:GLKVector3Make(-3.5, 0.0, -6.0) 
                           shouldRotate:YES]];
    //  B)
    [self.levelStructure addObject:[[Wall alloc] 
                           initWithModel:self.gameModelWalls 
                           position:GLKVector3Make(-2.0, 0.0, -4.5) 
                           shouldRotate:YES]];
    [self.levelStructure addObject:[[Wall alloc] 
                           initWithModel:self.gameModelWalls 
                           position:GLKVector3Make(-2.0, 0.0, -3.5) 
                           shouldRotate:YES]];
    [self.levelStructure addObject:[[Wall alloc] 
                           initWithModel:self.gameModelWalls 
                           position:GLKVector3Make(-2.0, 0.0, -2.5) 
                           shouldRotate:YES]];
    [self.levelStructure addObject:[[Wall alloc] 
                           initWithModel:self.gameModelWalls 
                           position:GLKVector3Make(-2.0, 0.0, -1.5) 
                           shouldRotate:YES]];
    [self.levelStructure addObject:[[Wall alloc] 
                           initWithModel:self.gameModelWalls 
                           position:GLKVector3Make(-2.25, 0.0, -0.8) 
                           shouldRotate:NO]];
    [self.levelStructure addObject:[[Wall alloc] 
                           initWithModel:self.gameModelWalls 
                           position:GLKVector3Make(-3.25, 0.0, -0.8) 
                           shouldRotate:NO]];
    [self.levelStructure addObject:[[Wall alloc] 
                           initWithModel:self.gameModelWalls 
                           position:GLKVector3Make(-4.25, 0.0, -0.8) 
                           shouldRotate:NO]];
    [self.levelStructure addObject:[[Wall alloc] 
                           initWithModel:self.gameModelWalls 
                           position:GLKVector3Make(-2.0, 0.0, -0.1) 
                           shouldRotate:YES]];
    [self.levelStructure addObject:[[Wall alloc] 
                           initWithModel:self.gameModelWalls 
                           position:GLKVector3Make(-2.0, 0.0, 0.9) 
                           shouldRotate:YES]];
    [self.levelStructure addObject:[[Wall alloc] 
                           initWithModel:self.gameModelWalls 
                           position:GLKVector3Make(-2.0, 0.0, 1.9) 
                           shouldRotate:YES]];
    [self.levelStructure addObject:[[Wall alloc] 
                           initWithModel:self.gameModelWalls 
                           position:GLKVector3Make(-2.0, 0.0, 2.9) 
                           shouldRotate:YES]];
    [self.levelStructure addObject:[[Wall alloc] 
                           initWithModel:self.gameModelWalls 
                           position:GLKVector3Make(-2.0, 0.0, 3.5) 
                           shouldRotate:NO]];
    [self.levelStructure addObject:[[Wall alloc] 
                           initWithModel:self.gameModelWalls 
                           position:GLKVector3Make(-3.0, 0.0, 3.5) 
                           shouldRotate:NO]];
    [self.levelStructure addObject:[[Wall alloc] 
                           initWithModel:self.gameModelWalls 
                           position:GLKVector3Make(-1.0, 0.0, 3.5) 
                           shouldRotate:NO]];
    [self.levelStructure addObject:[[Wall alloc] 
                           initWithModel:self.gameModelWalls 
                           position:GLKVector3Make(0.0, 0.0, 3.5) 
                           shouldRotate:NO]];
    [self.levelStructure addObject:[[Wall alloc] 
                           initWithModel:self.gameModelWalls 
                           position:GLKVector3Make(-1.3, 0.0, -3.5) 
                           shouldRotate:NO]];
    [self.levelStructure addObject:[[Wall alloc] 
                           initWithModel:self.gameModelWalls 
                           position:GLKVector3Make(-0.3, 0.0, -3.5) 
                           shouldRotate:NO]];
    [self.levelStructure addObject:[[Wall alloc] 
                           initWithModel:self.gameModelWalls 
                           position:GLKVector3Make(0.7, 0.0, -3.5) 
                           shouldRotate:NO]];
    [self.levelStructure addObject:[[Wall alloc] 
                           initWithModel:self.gameModelWalls 
                           position:GLKVector3Make(1.7, 0.0, -3.5) 
                           shouldRotate:NO]];
    [self.levelStructure addObject:[[Wall alloc] 
                           initWithModel:self.gameModelWalls 
                           position:GLKVector3Make(2.4, 0.0, -3.25) 
                           shouldRotate:YES]];
    [self.levelStructure addObject:[[Wall alloc] 
                           initWithModel:self.gameModelWalls 
                           position:GLKVector3Make(2.4, 0.0, -2.25) 
                           shouldRotate:YES]];
    
    
    //  C)
    [self.levelStructure addObject:[[Wall alloc] 
                           initWithModel:self.gameModelWalls 
                           position:GLKVector3Make(4.5, 0.0, -5.0) 
                           shouldRotate:NO]];
    [self.levelStructure addObject:[[Wall alloc] 
                           initWithModel:self.gameModelWalls 
                           position:GLKVector3Make(3.5, 0.0, -5.0) 
                           shouldRotate:NO]];
    
    //  D)
    [self.levelStructure addObject:[[Wall alloc] 
                           initWithModel:self.gameModelWalls 
                           position:GLKVector3Make(3.0, 0.0, 0.0) 
                           shouldRotate:NO]];
    
    //  E)
    [self.levelStructure addObject:[[Wall alloc] 
                           initWithModel:self.gameModelWalls 
                           position:GLKVector3Make(4.5, 0.0, 2.0) 
                           shouldRotate:NO]];
    [self.levelStructure addObject:[[Wall alloc] 
                           initWithModel:self.gameModelWalls 
                           position:GLKVector3Make(3.5, 0.0, 2.0) 
                           shouldRotate:NO]];
    [self.levelStructure addObject:[[Wall alloc] 
                           initWithModel:self.gameModelWalls 
                           position:GLKVector3Make(2.5, 0.0, 2.0) 
                           shouldRotate:NO]];
    [self.levelStructure addObject:[[Wall alloc] 
                           initWithModel:self.gameModelWalls 
                           position:GLKVector3Make(1.5, 0.0, 2.0) 
                           shouldRotate:NO]];
    [self.levelStructure addObject:[[Wall alloc] 
                           initWithModel:self.gameModelWalls 
                           position:GLKVector3Make(0.5, 0.0, 2.0) 
                           shouldRotate:NO]];
    [self.levelStructure addObject:[[Wall alloc] 
                           initWithModel:self.gameModelWalls 
                           position:GLKVector3Make(0.25, 0.0, 1.3) 
                           shouldRotate:YES]];
    [self.levelStructure addObject:[[Wall alloc] 
                           initWithModel:self.gameModelWalls 
                           position:GLKVector3Make(0.25, 0.0, 0.3) 
                           shouldRotate:YES]];
    [self.levelStructure addObject:[[Wall alloc] 
                           initWithModel:self.gameModelWalls 
                           position:GLKVector3Make(0.25, 0.0, -0.7) 
                           shouldRotate:YES]];
    
    //  F)
    [self.levelStructure addObject:[[Wall alloc] 
                           initWithModel:self.gameModelWalls 
                           position:GLKVector3Make(3.0, 0.0, 4.0) 
                           shouldRotate:YES]];
    [self.levelStructure addObject:[[Wall alloc] 
                           initWithModel:self.gameModelWalls 
                           position:GLKVector3Make(3.0, 0.0, 5.0) 
                           shouldRotate:YES]];

}




@end
