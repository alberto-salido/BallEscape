//
//  Ball.m
//  BallEscape
//
//  Created by Alberto Salido López on 08/11/12.
//  Copyright (c) 2012 Alberto Salido López. All rights reserved.
//

#import "Ball.h"

@interface Ball ()

@property (nonatomic, strong) UtilityModel *model;
@property (nonatomic) GLKVector3 position;
@property (nonatomic) GLKVector3 velocity;
@property (nonatomic) float yawRadians;
@property (nonatomic) GLKVector3 nextPosition;

@end

@implementation Ball

@synthesize model = _model;
@synthesize position = _position;
@synthesize velocity = _velocity;
@synthesize yawRadians = _yawRadians;
@synthesize nextPosition = _nextPosition;

- (id)initWithModel:(UtilityModel *)model 
           position:(GLKVector3)position 
           velocity:(GLKVector3)velocity
         yawRadians:(float)radians;
{
    return (self = [super initWithModel:model 
                               position:position 
                               velocity:velocity
                             yawRadians:radians]);
}
        
    

#pragma mark - Game Character Logic Protocol.

- (BOOL)updateWithController:(id <ObjectController>)controller
{
    NSTimeInterval elapsedTimeSeconds = 
    MIN(MAX([controller timeSinceLastUpdate], 0.1), 0.5);
    
    //  Updates the velocity using the motion controller.
    self.velocity = GLKVector3Add(self.velocity, 
                                  GLKVector3Make(-([controller getXSlope] / 6),
                                                 0.0, 
                                                 -([controller getZSlope] / 6)));
    
    GLKVector3 traveledDistance = GLKVector3MultiplyScalar(self.velocity,
                                                           elapsedTimeSeconds);
    
    self.nextPosition = GLKVector3Add(self.position, traveledDistance);
    
    //  Detects collisions.
    [self bounceOffBorders:[controller borders]];
    BOOL gameOver = [self bounceOffWalls:[controller labyrinth]];
    
    self.position = self.nextPosition;
    
    return gameOver; 
}

@end
