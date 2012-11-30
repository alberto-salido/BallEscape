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
{
    return (self = [super initWithModel:model 
                               position:position 
                               velocity:velocity]);
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
    
    //  The dot product is the cos() of the angle between two
    //  vectors: in this case, the default orientation of the
    //  ball model and the ball's velocity vector.
    float dotProduct = GLKVector3DotProduct(
                                            GLKVector3Normalize(self.velocity),
                                            GLKVector3Make(0.0, 0, -1.0));
    
    //  Checks if the velocity is negative, the ghost is moving to the lower border, in this case, the 
    //  yaw angle sign must be changed to positive to simulate the rotation.
    if (self.velocity.x < 0) {
        self.yawRadians = acosf(dotProduct);
    } else {
        self.yawRadians = -acosf(dotProduct);
    }

    
    self.position = self.nextPosition;
    
    return gameOver; 
}

@end
